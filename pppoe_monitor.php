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

    $mikrotik = ORM::for_table('tbl_routers')->where('enabled', '1')->find_one($routerId);

    if (!$mikrotik) {
        return [];
    }

    $client = Mikrotik::getClient($mikrotik['ip_address'], $mikrotik['username'], $mikrotik['password']);
    $interfaces = $client->sendSync(new RouterOS\Request('/interface/print'));

    $interfaceList = [];
    foreach ($interfaces as $interface) {
        $name = $interface->getProperty('name');
        $interfaceList[] = $name; // Jangan menghapus karakter < dan > dari nama interface
    }

    return $interfaceList;
}

function pppoe_monitor_router_get_ppp_online_users()
{
    global $routes;
    $router = $routes['2'];
    $mikrotik = ORM::for_table('tbl_routers')->where('enabled', '1')->find_one($router);
    $client = Mikrotik::getClient($mikrotik['ip_address'], $mikrotik['username'], $mikrotik['password']);
    $pppUsers = $client->sendSync(new RouterOS\Request('/ppp/active/print'));

    $interfaceTraffic = $client->sendSync(new RouterOS\Request('/interface/print'));
    $interfaceData = [];
    foreach ($interfaceTraffic as $interface) {
        $name = $interface->getProperty('name');
        // Skip interfaces with missing names
        if (empty($name)) {
            continue;
        }

        $interfaceData[$name] = [
            'status' => $interface->getProperty('running') === 'true' ? 'Connected' : 'Disconnected',
            'txBytes' => intval($interface->getProperty('tx-byte')),
            'rxBytes' => intval($interface->getProperty('rx-byte')),
        ];
    }

    $userList = [];
    foreach ($pppUsers as $pppUser) {
        $username = $pppUser->getProperty('name');
        // Skip the current iteration if the username is empty
        if (empty($username)) {
            continue;
        }
        $address = $pppUser->getProperty('address');
        $uptime = $pppUser->getProperty('uptime');
        $service = $pppUser->getProperty('service');
        $callerid = $pppUser->getProperty('caller-id');
        $bytes_in = $pppUser->getProperty('limit-bytes-in');
        $bytes_out = $pppUser->getProperty('limit-bytes-out');
        $id = $pppUser->getProperty('.id'); // Ambil .id dari pengguna PPPoE

        // Retrieve user usage based on interface name
        $interfaceName = "<pppoe-$username>";

        if (isset($interfaceData[$interfaceName])) {
            $trafficData = $interfaceData[$interfaceName];
            $txBytes = $trafficData['txBytes'];
            $rxBytes = $trafficData['rxBytes'];
            $status = $trafficData['status'];
        } else {
            $txBytes = 0;
            $rxBytes = 0;
            $status = 'Disconnected'; // Default to Disconnected if interface data not found
        }

        $userList[] = [
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
            'status' => $status,  // Menambahkan .id ke dalam data pengguna PPPoE
        ];
    }

    // Return the PPP online user list as JSON
    header('Content-Type: application/json');
    echo json_encode($userList);
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

function pppoe_monitor_router_traffic()
{
    $interface = $_GET["interface"]; // Ambil interface dari parameter GET

    // Contoh koneksi ke MikroTik menggunakan library tertentu (misalnya menggunakan ORM dan MikroTik API wrapper)
    global $routes;
    $router = $routes['2'];
    $mikrotik = ORM::for_table('tbl_routers')->where('enabled', '1')->find_one($router);
    $client = Mikrotik::getClient($mikrotik['ip_address'], $mikrotik['username'], $mikrotik['password']);

    try {
        $results = $client->sendSync(
            (new RouterOS\Request('/interface/monitor-traffic'))
                ->setArgument('interface', $interface)
                ->setArgument('once', '')
        );

        $rows = array();
        $rows2 = array();
        $labels = array();

        foreach ($results as $result) {
            $ftx = $result->getProperty('tx-bits-per-second');
            $frx = $result->getProperty('rx-bits-per-second');

            // Timestamp dalam milidetik (millisecond)
            $timestamp = time() * 1000;

            $rows[] = $ftx;
            $rows2[] = $frx;
            $labels[] = $timestamp; // Tambahkan timestamp ke dalam array labels
        }

        $result = array(
            'labels' => $labels,
            'rows' => array(
                'tx' => $rows,
                'rx' => $rows2
            )
        );
    } catch (Exception $e) {
        $result = array('error' => $e->getMessage());
    }

    // Set header untuk respons JSON
    header('Content-Type: application/json');
    echo json_encode($result);
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
