<?php

use PEAR2\Net\RouterOS;

// Register the PPPoE Monitor menu
register_menu(" PPPoE Monitor", true, "pppoe_monitor_router_menu", 'AFTER_SETTINGS', 'ion ion-ios-pulse', "Hot", "red");

function pppoe_monitor_router_menu()
{
    global $ui, $routes;
    _admin();
    $ui->assign('_title', 'PPPoE Monitor');
    $ui->assign('_system_menu', 'PPPoE Monitor');
    $admin = Admin::_info();
    $ui->assign('_admin', $admin);
    $routers = ORM::for_table('tbl_routers')->where('enabled', '1')->find_many();
    $router = $routes['2'] ?? $routers[0]['id']; 
    $ui->assign('routers', $routers);
    $ui->assign('router', $router);
    $ui->assign('interfaces', pppoe_monitor_router_getInterface());
    
    $ui->display('pppoe_monitor.tpl');
}

function pppoe_monitor_router_getInterface()
{
    global $routes;
    $routerId = $routes['2'] ?? null;

    if (!$routerId) {
        return [];
    }

    try {
        $mikrotik = ORM::for_table('tbl_routers')
            ->where('enabled', '1')
            ->find_one($routerId);

        if (!$mikrotik) {
            return [];
        }

        $client = Mikrotik::getClient($mikrotik['ip_address'], $mikrotik['username'], $mikrotik['password']);
        $interfaces = $client->sendSync(new RouterOS\Request('/interface/print'));

        return array_map(function($interface) {
            return $interface->getProperty('name');
        }, iterator_to_array($interfaces));

    } catch (Exception $e) {
        error_log('Error getting interfaces: ' . $e->getMessage());
        return [];
    }
}

function pppoe_monitor_router_get_combined_users() {
    global $routes;
    $router = $routes['2'];
    $mikrotik = ORM::for_table('tbl_routers')->where('enabled', '1')->find_one($router);

    if (!$mikrotik) {
        header('Content-Type: application/json');
        echo json_encode(['error' => 'Router not found']);
        return;
    }

    try {
        $client = Mikrotik::getClient($mikrotik['ip_address'], $mikrotik['username'], $mikrotik['password']);

        // Fetch PPP online users
        $pppUsers = $client->sendSync(new RouterOS\Request('/ppp/active/print'));
        $interfaceTraffic = $client->sendSync(new RouterOS\Request('/interface/print'));

        $interfaceData = [];
        foreach ($interfaceTraffic as $interface) {
            $name = $interface->getProperty('name');
            if (empty($name)) {
                continue;
            }

            $interfaceData[$name] = [
                'status' => $interface->getProperty('running') === 'true' ? 'Connected' : 'Disconnected',
                'txBytes' => intval($interface->getProperty('tx-byte')),
                'rxBytes' => intval($interface->getProperty('rx-byte')),
            ];
        }

        $pppUserList = [];
        foreach ($pppUsers as $pppUser) {
            $username = $pppUser->getProperty('name');
            if (empty($username)) {
                continue;
            }
            $address = $pppUser->getProperty('address');
            $uptime = $pppUser->getProperty('uptime');
            $service = $pppUser->getProperty('service');
            $callerid = $pppUser->getProperty('caller-id');
            $bytes_in = $pppUser->getProperty('limit-bytes-in');
            $bytes_out = $pppUser->getProperty('limit-bytes-out');
            $id = $pppUser->getProperty('.id');

            $interfaceName = "<pppoe-$username>";

            if (isset($interfaceData[$interfaceName])) {
                $trafficData = $interfaceData[$interfaceName];
                $txBytes = $trafficData['txBytes'];
                $rxBytes = $trafficData['rxBytes'];
                $status = $trafficData['status'];
            } else {
                $txBytes = 0;
                $rxBytes = 0;
                $status = 'Disconnected';
            }

            $pppUserList[$username] = [
                'id' => $id,
                'username' => $username,
                'address' => $address,
                'uptime' => $uptime,
                'service' => $service,
                'caller_id' => $callerid,
                'bytes_in' => $bytes_in,
                'bytes_out' => $bytes_out,
                'tx' => pppoe_monitor_router_formatBytes($txBytes),
                'rx' => pppoe_monitor_router_formatBytes($rxBytes),
                'total' => pppoe_monitor_router_formatBytes($txBytes + $rxBytes),
                'status' => $status,
                'max_limit' => 'N/A' // Default value for max_limit
            ];
        }

        // Fetch limited users
        $queues = $client->sendSync(new RouterOS\Request('/queue/simple/print'));

        foreach ($queues as $queue) {
            $name = $queue->getProperty('name');
            $max_limit = $queue->getProperty('max-limit');

            if ($max_limit !== null && $max_limit !== '') {
                $formattedMaxLimit = pppoe_monitor_router_formatMaxLimit($max_limit);
                $strippedName = str_replace('<pppoe-', '', str_replace('>', '', $name));
                if (isset($pppUserList[$name])) {
                    $pppUserList[$name]['max_limit'] = $formattedMaxLimit;
                } elseif (isset($pppUserList[$strippedName])) {
                    $pppUserList[$strippedName]['max_limit'] = $formattedMaxLimit;
                } else {
                    $pppUserList[$name] = [
                        'username' => $name,
                        'max_limit' => $formattedMaxLimit,
                        'id' => null,
                        'address' => null,
                        'uptime' => null,
                        'service' => null,
                        'caller_id' => null,
                        'bytes_in' => null,
                        'bytes_out' => null,
                        'tx' => null,
                        'rx' => null,
                        'total' => null,
                        'status' => 'Disconnected',
                    ];
                }
            }
        }

        // Convert the user list to a regular array for JSON encoding
        $userList = array_values($pppUserList);

        // Return the combined user list as JSON
        header('Content-Type: application/json');
        echo json_encode($userList);
    } catch (Exception $e) {
        header('Content-Type: application/json');
        echo json_encode(['error' => $e->getMessage()]);
    }
}

function pppoe_monitor_router_formatMaxLimit($max_limit) {
    $limits = explode('/', $max_limit);
    if (count($limits) == 2) {
        $downloadLimit = intval($limits[0]);
        $uploadLimit = intval($limits[1]);
        $formattedDownloadLimit = ceil($downloadLimit / (1024 * 1024)) . ' MB';
        $formattedUploadLimit = ceil($uploadLimit / (1024 * 1024)) . ' MB';
        return $formattedDownloadLimit . '/' . $formattedUploadLimit;
    }
    return 'N/A';
}

// Fungsi untuk menghitung total data yang digunakan per harinya

function pppoe_monitor_router_formatBytes($bytes, $precision = 2)
{
    $units = ['B', 'KB', 'MB', 'GB', 'TB', 'PB', 'EB', 'ZB', 'YB'];
    $bytes = max($bytes, 0);
    $pow = floor(($bytes ? log($bytes) : 0) / log(1024));
    $pow = min($pow, count($units) - 1);
    $bytes /= pow(1024, $pow);
    return round($bytes, $precision) . ' ' . $units[$pow];
}

function pppoe_monitor_router_traffic() {
    try {
        global $routes;
        $router = $routes['2'];
        $username = $_GET['username'] ?? '';
        
        if (empty($username)) {
            throw new Exception('Username parameter is required');
        }

        // Validate and sanitize username
        $username = preg_replace('/[^a-zA-Z0-9_-]/', '', $username);
        
        $mikrotik = ORM::for_table('tbl_routers')
            ->where('enabled', '1')
            ->find_one($router);

        if (!$mikrotik) {
            throw new Exception('Router not found');
        }

        $client = Mikrotik::getClient($mikrotik['ip_address'], $mikrotik['username'], $mikrotik['password']);
        $interface = "<pppoe-$username>";

        // Get interface data
        $interfaceData = $client->sendSync(
            (new RouterOS\Request('/interface/print'))
                ->setQuery(RouterOS\Query::where('name', $interface))
        );

        if (!count($interfaceData)) {
            throw new Exception('Interface not found');
        }

        // Get total bytes
        $bytes = [
            'tx' => (int)$interfaceData[0]->getProperty('tx-byte'),
            'rx' => (int)$interfaceData[0]->getProperty('rx-byte')
        ];

        // Get traffic speed
        $traffic = $client->sendSync(
            (new RouterOS\Request('/interface/monitor-traffic'))
                ->setArgument('interface', $interface)
                ->setArgument('once')
        );

        $response = [
            'success' => true,
            'timestamp' => time() * 1000,
            'rows' => [
                'tx' => [0],
                'rx' => [0]
            ],
            'bytes' => $bytes
        ];

        if (count($traffic)) {
            $response['rows']['tx'][0] = (int)$traffic[0]->getProperty('tx-bits-per-second');
            $response['rows']['rx'][0] = (int)$traffic[0]->getProperty('rx-bits-per-second');
        }

        header('Content-Type: application/json');
        echo json_encode($response);

    } catch (Exception $e) {
        error_log("Traffic monitoring error for $username: " . $e->getMessage());
        http_response_code(500);
        header('Content-Type: application/json');
        echo json_encode([
            'success' => false,
            'error' => $e->getMessage()
        ]);
    }
}

function pppoe_monitor_router_online()
{
    global $routes;
    $router = $routes['2'];
    $mikrotik = ORM::for_table('tbl_routers')->where('enabled', '1')->find_one($router);
    $client = Mikrotik::getClient($mikrotik['ip_address'], $mikrotik['username'], $mikrotik['password']);
    $pppUsers = $client->sendSync(new RouterOS\Request('/ppp/active/print'));

    $pppoeInterfaces = [];

    foreach ($pppUsers as $pppUser) {
        $username = $pppUser->getProperty('name');
        $interfaceName = "<pppoe-$username>"; // Tambahkan karakter < dan >

        // Ensure interface name is not empty and it's not already in the list
        if (!empty($interfaceName) && !in_array($interfaceName, $pppoeInterfaces)) {
            $pppoeInterfaces[] = $interfaceName;
        }
    }

    // Return the list of PPPoE interfaces
    return $pppoeInterfaces;
}

function pppoe_monitor_router_delete_ppp_user() {
    try {
        global $routes;
        $router = $routes['2'];
        $id = $_POST['id'] ?? '';
        $username = $_POST['username'] ?? '';

        if (empty($id)) {
            throw new Exception('User ID is required');
        }

        $mikrotik = ORM::for_table('tbl_routers')
            ->where('enabled', '1')
            ->find_one($router);

        if (!$mikrotik) {
            throw new Exception('Router not found');
        }

        $client = Mikrotik::getClient($mikrotik['ip_address'], $mikrotik['username'], $mikrotik['password']);

        // First remove from active connections
        $activeRequest = new RouterOS\Request('/ppp/active/print');
        $activeRequest->setQuery(RouterOS\Query::where('name', $username));
        $activeConnections = $client->sendSync($activeRequest);

        foreach ($activeConnections as $connection) {
            $removeRequest = new RouterOS\Request('/ppp/active/remove');
            $removeRequest->setArgument('.id', $connection->getProperty('.id'));
            $client->sendSync($removeRequest);
        }

        // Wait a moment for the disconnection to complete
        sleep(1);

        header('Content-Type: application/json');
        echo json_encode([
            'success' => true,
            'message' => 'User disconnected successfully'
        ]);

    } catch (Exception $e) {
        error_log('Disconnect error: ' . $e->getMessage());
        http_response_code(500);
        header('Content-Type: application/json');
        echo json_encode([
            'success' => false,
            'message' => $e->getMessage()
        ]);
    }
}

// ======================================================================
// NEW FUNCTIONS:

// Fungsi untuk menghitung total data yang digunakan per harinya
function pppoe_monitor_router_daily_data_usage()
{
    global $routes;
    $router = $routes['2'];
    $mikrotik = ORM::for_table('tbl_routers')->where('enabled', '1')->find_one($router);
    $client = Mikrotik::getClient($mikrotik['ip_address'], $mikrotik['username'], $mikrotik['password']);
    
    // Ambil semua pengguna aktif PPPoE
    $pppUsers = $client->sendSync(new RouterOS\Request('/ppp/active/print'));
    $interfaceTraffic = $client->sendSync(new RouterOS\Request('/interface/print'));

    // Array untuk menyimpan data penggunaan harian
    $daily_usage = [];

    // Looping untuk setiap pengguna PPPoE
    foreach ($pppUsers as $pppUser) {
        $username = $pppUser->getProperty('name');
        $interfaceName = "<pppoe-$username>"; // Nama interface sesuai format PPPoE

        // Ambil data traffic untuk interface ini
        $interfaceData = [];
        foreach ($interfaceTraffic as $interface) {
            $name = $interface->getProperty('name');
            if ($name === $interfaceName) {
                $interfaceData = [
                    'txBytes' => intval($interface->getProperty('tx-byte')),
                    'rxBytes' => intval($interface->getProperty('rx-byte'))
                ];
                break;
            }
        }

        // Hitung total penggunaan harian
        $txBytes = $interfaceData['txBytes'] ?? 0;
        $rxBytes = $interfaceData['rxBytes'] ?? 0;
        $totalDataMB = ($txBytes + $rxBytes) / (1024 * 1024); // Konversi ke MB

        // Ambil tanggal dari waktu saat ini
        $date = date('Y-m-d', time());

        // Jika belum ada data untuk tanggal ini, inisialisasi
        if (!isset($daily_usage[$date])) {
            $daily_usage[$date] = [
                'total' => 0,
                'users' => []
            ];
        }

        // Tambahkan penggunaan harian untuk pengguna ini
        $daily_usage[$date]['total'] += $totalDataMB;
        $daily_usage[$date]['users'][] = [
            'username' => $username,
            'tx' => pppoe_monitor_router_formatBytes($txBytes),
            'rx' => pppoe_monitor_router_formatBytes($rxBytes),
            'total' => pppoe_monitor_router_formatBytes($txBytes + $rxBytes)
        ];
    }

    // Kembalikan hasil dalam format JSON
    header('Content-Type: application/json');
    echo json_encode($daily_usage); // $daily_usage adalah array yang berisi data harian dalam format yang sesuai
}
// Fungsi untuk mendapatkan pengguna terbatas pada MikroTik
