{include file="sections/header.tpl"}

<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
<script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
<script src="https://cdn.datatables.net/1.10.23/js/jquery.dataTables.min.js"></script>
<link rel="stylesheet" href="https://cdn.datatables.net/1.10.23/css/jquery.dataTables.min.css">
<link rel="stylesheet" href="https://cdn.datatables.net/buttons/1.7.1/css/buttons.dataTables.min.css">
<script src="https://cdn.datatables.net/buttons/1.7.1/js/dataTables.buttons.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/apexcharts"></script>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script src="https://cdn.datatables.net/1.11.3/js/jquery.dataTables.min.js"></script>
<script src="https://cdn.datatables.net/1.11.3/js/dataTables.bootstrap5.min.js"></script>

<style>
.app-container {
    padding: 2rem;
    background: #f1f5f9;
    min-height: 100vh;
}

/* Modern Navigation */
.nav-container {
    margin-bottom: 2rem;
    display: flex;
    gap: 1rem;
    flex-wrap: wrap;
}

.nav-item {
    flex: 1;
    min-width: 200px;
}

.nav-link {
    display: flex;
    align-items: center;
    gap: 0.75rem;
    padding: 1rem 1.5rem;
    background: white;
    border-radius: 10px;
    color: #1e293b;
    text-decoration: none;
    box-shadow: 0 1px 3px rgba(0,0,0,0.1);
    transition: all 0.2s ease;
}

.nav-link.active {
    background: #3b82f6;
    color: white;
}

.nav-link:hover {
    transform: translateY(-2px);
    box-shadow: 0 4px 6px rgba(0,0,0,0.1);
}

/* Search Section */
.search-container {
    background: white;
    padding: 1.5rem;
    border-radius: 10px;
    margin-bottom: 2rem;
    box-shadow: 0 1px 3px rgba(0,0,0,0.1);
}

.search-form {
    display: flex;
    gap: 1rem;
    flex-wrap: wrap;
}

.search-group {
    flex: 1;
    min-width: 250px;
    position: relative;
}

.search-group i {
    position: absolute;
    left: 1rem;
    top: 50%;
    transform: translateY(-50%);
    color: #64748b;
}

.search-input {
    width: 100%;
    padding: 0.75rem 1rem 0.75rem 2.5rem;
    border: 1px solid #e2e8f0;
    border-radius: 8px;
    outline: none;
    transition: all 0.2s ease;
}

.search-input:focus {
    border-color: #3b82f6;
    box-shadow: 0 0 0 3px rgba(59,130,246,0.1);
}

/* Table Styling */
.table-container {
    background: white;
    border-radius: 10px;
    padding: 1.5rem;
    box-shadow: 0 1px 3px rgba(0,0,0,0.1);
}

.data-table {
    width: 100%;
    border-collapse: separate;
    border-spacing: 0;
}

.data-table th {
    background: #f8fafc;
    padding: 1rem;
    font-size: 0.75rem;
    font-weight: 600;
    text-transform: uppercase;
    letter-spacing: 0.05em;
    color: #475569;
}

.data-table td {
    padding: 1rem;
    border-bottom: 1px solid #e2e8f0;
}

/* Traffic Data */
.traffic-box {
    background: #f8fafc;
    padding: 0.75rem;
    border-radius: 8px;
    text-align: center;
}

.traffic-speed {
    color: #0f172a;
    font-weight: 600;
}

.traffic-bytes {
    color: #64748b;
    font-size: 0.875rem;
}

/* Status Badge */
.status-badge {
    display: inline-flex;
    align-items: center;
    gap: 6px;
    padding: 6px 12px;
    border-radius: 20px;
    font-size: 0.75rem;
    font-weight: 600;
    line-height: 1;
    min-width: 100px;
    justify-content: center;
}

.status-badge.connected {
    background: linear-gradient(135deg, #059669, #10b981);
    color: white;
    box-shadow: 0 2px 4px rgba(5, 150, 105, 0.2);
}

.status-badge.disconnected {
    background: linear-gradient(135deg, #dc2626, #ef4444);
    color: white;
    box-shadow: 0 2px 4px rgba(220, 38, 38, 0.2);
}

.status-badge i {
    font-size: 8px;
}

.status-badge.connected i {
    color: #34d399;
    filter: drop-shadow(0 0 2px rgba(52, 211, 153, 0.8));
    animation: pulse 2s infinite;
}

.status-badge.disconnected i {
    color: #fca5a5;
}

@keyframes pulse {
    0% {
        opacity: 0.4;
    }
    50% {
        opacity: 1;
    }
    100% {
        opacity: 0.4;
    }
}

/* Action Button */
.btn-action {
    padding: 0.5rem 1rem;
    border-radius: 6px;
    background: #ef4444;
    color: white;
    border: none;
    cursor: pointer;
    transition: all 0.2s ease;
}

.btn-action:hover {
    background: #dc2626;
    transform: translateY(-2px);
}

/* Responsive Design */
@media (max-width: 768px) {
    .app-container {
        padding: 1rem;
    }
    
    .nav-item {
        width: 100%;
    }
    
    .search-group {
        width: 100%;
    }
    
    .table-container {
        overflow-x: auto;
    }
}

/* Traffic Icon Styling */
.user-info {
    display: flex;
    align-items: center;
    gap: 10px;
}

.traffic-indicator {
    display: flex;
    flex-direction: column;
    align-items: center;
    width: 16px;
    height: 24px;
    position: relative;
}

.traffic-dot {
    width: 8px;
    height: 8px;
    border-radius: 50%;
    margin: 2px 0;
    transition: all 0.3s ease;
}

.traffic-arrow {
    width: 0;
    height: 0;
    border-left: 4px solid transparent;
    border-right: 4px solid transparent;
}

.traffic-up {
    border-bottom: 4px solid #6c757d;
}

.traffic-down {
    border-top: 4px solid #6c757d;
}

.traffic-dot.traffic-icon-green {
    background: #28a745;
    box-shadow: 0 0 4px #28a745;
}

.traffic-dot.traffic-icon-yellow {
    background: #ffc107;
    box-shadow: 0 0 4px #ffc107;
}

.traffic-dot.traffic-icon-red {
    background: #dc3545;
    box-shadow: 0 0 4px #dc3545;
}

.username {
    font-weight: 500;
    color: #2d3748;
}

/* Active traffic animation */
@keyframes pulse {
    0% { transform: scale(1); }
    50% { transform: scale(1.2); }
    100% { transform: scale(1); }
}

.traffic-dot.active {
    animation: pulse 1s infinite;
}

/* Update arrow colors based on traffic */
.traffic-indicator.active .traffic-up {
    border-bottom-color: #28a745;
}

.traffic-indicator.active .traffic-down {
    border-top-color: #dc3545;
}

/* Enhanced Reconnect Button */
.action-btn.reset {
    background: linear-gradient(135deg, #f43f5e, #e11d48);
    color: white;
    padding: 8px 16px;
    border-radius: 8px;
    font-size: 13px;
    font-weight: 500;
    border: none;
    cursor: pointer;
    transition: all 0.3s ease;
    display: inline-flex;
    align-items: center;
    gap: 8px;
    box-shadow: 0 2px 4px rgba(244, 63, 94, 0.2);
}

.action-btn.reset:hover {
    background: linear-gradient(135deg, #e11d48, #be123c);
    transform: translateY(-2px);
    box-shadow: 0 4px 12px rgba(244, 63, 94, 0.3);
}

.action-btn.reset:active {
    transform: translateY(0);
}

.action-btn.reset.loading {
    background: #9ca3af;
    cursor: wait;
    pointer-events: none;
}

.action-btn.reset.loading i {
    animation: spin 1s linear infinite;
}
</style>

<div class="app-container">
    <!-- Navigation -->
    <nav class="nav-container">
        {foreach $routers as $r}
        <div class="nav-item">
            <a href="{$_url}plugin/pppoe_monitor_router_menu/{$r['id']}" 
               class="nav-link {if $r['id']==$router}active{/if}">
                <i class="fas fa-router"></i>
                <span>{$r['name']}</span>
            </a>
        </div>
        {/foreach}
    </nav>

    <!-- Search -->
    <div class="search-container">
        <div class="search-form">
            <div class="search-group">
                <i class="fas fa-search"></i>
                <input type="text" class="search-input" id="searchUsername" placeholder="Search username...">
            </div>
            <div class="search-group">
                <i class="fas fa-filter"></i>
                <select class="search-input" id="searchStatus">
                    <option value="">All Status</option>
                    <option value="Connected">Connected</option>
                    <option value="Disconnected">Disconnected</option>
                </select>
            </div>
        </div>
    </div>

    <!-- Table -->
    <div class="table-container">
        <table class="data-table" id="ppp-table">
            <thead>
                <tr>
                    <th>Username</th>
                    <th>IP Address</th>
                    <th>Uptime</th>
                    <th>Service</th>
                    <th>Caller ID</th>
                    <th>Download Speed</th>
                    <th>Upload Speed</th>
                    <th>Max Limit</th>
                    <th>Total Usage</th>
                    <th>Status</th>
                    <th>Actions</th>
                </tr>
            </thead>
            <tbody>
                <!-- Isi tabel akan dimasukkan melalui JavaScript -->
            </tbody>
        </table>
    </div>
</div>

<script>
var $j = jQuery.noConflict();

// Update constants for better real-time performance
const CHART_UPDATE_INTERVAL = 2000; // 2 seconds
const TRAFFIC_REQUEST_TIMEOUT = 3000; // 3 seconds
const MAX_RETRIES = 3;

class TrafficMonitor {
    constructor() {
        this.trafficData = {};
        this.pendingRequests = {};
        this.retryCount = {};
        this.activeUsers = new Set();
        this.tableInitialized = false;
        this.isPolling = false;
        this.pollTimeout = null;
        
        this.initializeDataTable();
        this.initializeEventListeners();
    }

    initializeEventListeners() {
        // Add click handler for reconnect buttons
        $j('#ppp-table').on('click', '.action-btn.reset:not(.disabled)', (e) => {
            const button = $j(e.currentTarget);
            const username = button.data('username');
            const id = button.data('id');
            
            if (confirm('Are you sure you want to disconnect ' + username + '?')) {
                this.reconnectUser(id, username);
            }
        });
    }

    async reconnectUser(id, username) {
        try {
            const button = $j('[data-username="' + username + '"]');
            
            // Disable button and show loading state
            button.addClass('loading')
                  .prop('disabled', true)
                  .html('<i class="fas fa-spinner"></i> Disconnecting...');

            const response = await $j.ajax({
                url: '{$_url}plugin/pppoe_monitor_router_delete_ppp_user/{$router}',
                method: 'POST',
                data: { id: id, username: username },
                dataType: 'json'
            });

            if (response.success) {
                this.showNotification(
                    'Success', 
                    '<i class="fas fa-check-circle"></i> User ' + username + ' has been disconnected', 
                    'success'
                );
                
                // Refresh the table after short delay
                setTimeout(() => this.table.ajax.reload(null, false), 1000);
            } else {
                throw new Error(response.message || 'Failed to disconnect user');
            }
        } catch (error) {
            console.error('Disconnect error:', error);
            this.showNotification(
                'Error',
                '<i class="fas fa-exclamation-triangle"></i> ' + error.message,
                'error'
            );
            
            // Restore button state
            const button = $j('[data-username="' + username + '"]');
            button.removeClass('loading')
                  .prop('disabled', false)
                  .html('<i class="fas fa-sync-alt"></i> Reset');
        }
    }

    showNotification(title, message, type = 'info') {
        const notificationClass = type === 'success' ? 'bg-green' : 'bg-red';
        const notification = $j('<div>')
            .addClass('notification ' + notificationClass)
            .html('<strong>' + title + '</strong><br>' + message)
            .appendTo('body');
        
        setTimeout(() => {
            notification.fadeOut(300, function() { $j(this).remove(); });
        }, 3000);
    }

    initializeDataTable() {
        if (this.tableInitialized) return;
        
        const self = this;
        this.table = $j('#ppp-table').DataTable({
            processing: true,
            serverSide: false,
            responsive: true,
            ajax: {
                url: '{$_url}plugin/pppoe_monitor_router_get_combined_users/{$router}',
                dataSrc: function(json) {
                    if (json) {
                        setTimeout(() => self.startMonitoring(), 1000);
                    }
                    return json || [];
                }
            },
            columns: [
                {
                    data: 'username',
                    render: function(data, type, row) {
                        const traffic = self.trafficData[data] || {};
                        const speed = traffic.tx || '0.00 Kbps';
                        const iconClass = self.getTrafficIconClass(speed);
                        
                        return '<div class="user-info">' +
                            '<div class="traffic-indicator">' +
                            '<div class="traffic-arrow traffic-up"></div>' +
                            '<div class="traffic-dot ' + iconClass + '"></div>' +
                            '<div class="traffic-arrow traffic-down"></div>' +
                            '</div>' +
                            '<span class="username">' + (data || '') + '</span>' +
                            '</div>';
                    }
                },
                { data: 'address' },
                { data: 'uptime' },
                { data: 'service' },
                { data: 'caller_id' },
                { 
                    data: 'tx',
                    render: function(data, type, row) {
                        const username = row.username || '';
                        const traffic = self.trafficData[username] || {};
                        const speed = traffic.tx || '0.00 Kbps';
                        const bytes = traffic.txRaw || 0;
                        
                        return '<div id="' + username + '-tx" class="traffic-data">' +
                            '<span class="bytes-counter">' + formatBytes(bytes) + '</span><br>' +
                            '<small class="speed-indicator">' + speed + '</small>' +
                            '</div>';
                    }
                },
                { 
                    data: 'rx',
                    render: function(data, type, row) {
                        const username = row.username || '';
                        const traffic = self.trafficData[username] || {};
                        const speed = traffic.rx || '0.00 Kbps';
                        const bytes = traffic.rxRaw || 0;
                        
                        return '<div id="' + username + '-rx" class="traffic-data">' +
                            '<span class="bytes-counter">' + formatBytes(bytes) + '</span><br>' +
                            '<small class="speed-indicator">' + speed + '</small>' +
                            '</div>';
                    }
                },
                { data: 'max_limit', defaultContent: 'N/A' },
                { data: 'total', defaultContent: '0 B' },
                {
                    data: 'status',
                    render: function(data) {
                        var status = data.toLowerCase();
                        var icon = status === 'connected' ? 
                            '<i class="fas fa-circle"></i>' : 
                            '<i class="fas fa-circle-xmark"></i>';
                            
                        return '<span class="status-badge ' + status + '">' +
                            icon + ' ' + 
                            data +
                            '</span>';
                    }
                },
                {
                    data: null,
                    render: function(data, type, row) {
                        var btnClass = row.status.toLowerCase() === 'connected' ? '' : 'disabled';
                        return '<button class="action-btn reset ' + btnClass + '" ' +
                               'data-username="' + (row.username || '') + '" ' +
                               'data-id="' + (row.id || '') + '">' +
                               '<i class="fas fa-sync-alt"></i> Reset' +
                               '</button>';
                    }
                }
            ],
            order: [[1, 'asc']],
            pageLength: 10,
            lengthMenu: [[10, 25, 50, -1], [10, 25, 50, 'All']],
            dom: 'Bfrtip'
        });

        this.tableInitialized = true;
    }

    startMonitoring() {
        this.updateActiveUsers();
        this.startPolling();
    }

    updateActiveUsers() {
        const rows = this.table.rows().data();
        this.activeUsers.clear();
        
        rows.each(row => {
            if (row.status === 'Connected' && row.username) {
                this.activeUsers.add(row.username.trim());
            }
        });

        console.log('Active users:', Array.from(this.activeUsers));
    }

    startPolling() {
        if (this.isPolling) return;
        
        this.isPolling = true;
        this.doPoll();
    }

    async doPoll() {
        try {
            await this.pollTraffic();
        } catch (error) {
            console.error('Polling error:', error);
        }

        // Schedule next poll if still active
        if (this.isPolling) {
            this.pollTimeout = setTimeout(() => this.doPoll(), CHART_UPDATE_INTERVAL);
        }
    }

    stopPolling() {
        this.isPolling = false;
        if (this.pollTimeout) {
            clearTimeout(this.pollTimeout);
            this.pollTimeout = null;
        }
    }

    async pollTraffic() {
        this.updateActiveUsers();
        const users = Array.from(this.activeUsers);
        
        // Process users in batches of 3
        for (let i = 0; i < users.length; i += 3) {
            const batch = users.slice(i, i + 3);
            await Promise.all(batch.map(user => this.fetchTrafficData(user)));
            
            // Small delay between batches
            if (i + 3 < users.length) {
                await new Promise(resolve => setTimeout(resolve, 200));
            }
        }
    }

    async fetchTrafficData(username) {
        if (this.pendingRequests[username]) return;
        
        try {
            this.pendingRequests[username] = true;
            const response = await $j.ajax({
                url: '{$_url}plugin/pppoe_monitor_router_traffic/{$router}',
                data: { username },
                timeout: TRAFFIC_REQUEST_TIMEOUT,
                cache: false
            });

            if (response?.success && response?.rows) {
                this.trafficData[username] = {
                    tx: this.formatSpeed(response.rows.tx[0]),
                    rx: this.formatSpeed(response.rows.rx[0]),
                    txBytes: response.bytes?.tx || 0,
                    rxBytes: response.bytes?.rx || 0,
                    timestamp: Date.now()
                };

                this.updateUserRow(username);
            }
        } catch (error) {
            console.warn('Traffic error for', username, ':', error.message);
        } finally {
            delete this.pendingRequests[username];
        }
    }

    formatSpeed(bitsPerSecond) {
        const bits = Math.max(0, parseInt(bitsPerSecond) || 0);
        const kbps = bits / 1024;
        
        if (kbps >= 1024) {
            return (kbps / 1024).toFixed(2) + ' Mbps';
        }
        return kbps.toFixed(2) + ' Kbps';
    }

    getSpeedClass(speed) {
        if (!speed) return 'speed-low';
        
        // Extract number and unit from speed string
        const matches = speed.match(/^([\d.]+)\s*(Kbps|Mbps)$/);
        if (!matches) return 'speed-low';

        const value = parseFloat(matches[1]);
        const unit = matches[2];
        
        // Convert everything to Mbps for comparison
        const mbps = unit === 'Kbps' ? value / 1024 : value;
        
        if (mbps > 2) return 'speed-high';
        if (mbps > 1) return 'speed-medium';
        return 'speed-low';
    }

    getTrafficIconClass(speed) {
        if (!speed) return 'traffic-icon-green';
        
        const matches = speed.match(/^([\d.]+)\s*(Kbps|Mbps)$/);
        if (!matches) return 'traffic-icon-green';

        const value = parseFloat(matches[1]);
        const unit = matches[2];
        
        // Convert to Mbps for comparison
        const mbps = unit === 'Kbps' ? value / 1024 : value;
        
        // Reverse the color logic:
        // Green for low traffic (< 1 Mbps)
        // Yellow/Orange for medium traffic (1-2 Mbps)
        // Red for high traffic (> 2 Mbps)
        if (mbps < 1) return 'traffic-icon-green';
        if (mbps <= 2) return 'traffic-icon-yellow';
        return 'traffic-icon-red';
    }

    updateSpeedDisplay(username) {
        if (!username || !this.trafficData[username]) return;
        
        const data = this.trafficData[username];
        if (!data.tx || !data.rx) return;

        const txCell = $j('#' + username + '-tx');
        const rxCell = $j('#' + username + '-rx');

        if (txCell.length) {
            txCell.find('.speed-indicator').text(data.tx);
            txCell.find('.bytes-counter').text(formatBytes(data.txRaw));
        }

        if (rxCell.length) {
            rxCell.find('.speed-indicator').text(data.rx);
            rxCell.find('.bytes-counter').text(formatBytes(data.rxRaw));
        }
    }

    updateUserRow(username) {
        var data = this.trafficData[username];
        if (!data) return;

        var iconClass = this.getTrafficIconClass(data.tx);
        var cell = $j('#ppp-table td:contains("' + username + '")').find('.traffic-dot');
        
        if (cell.length) {
            cell.removeClass('traffic-icon-green traffic-icon-yellow traffic-icon-red')
                .addClass(iconClass);
                
            // Add active class if there's traffic
            var hasTraffic = parseFloat(data.tx) > 0 || parseFloat(data.rx) > 0;
            cell.toggleClass('active', hasTraffic);
            cell.closest('.traffic-indicator').toggleClass('active', hasTraffic);
        }

        // Update traffic data display
        var txCell = $j('#' + username + '-tx');
        var rxCell = $j('#' + username + '-rx');

        if (txCell.length) {
            txCell.find('.bytes-counter').text(formatBytes(data.txBytes));
            txCell.find('.speed-indicator').text(data.tx);
            txCell.attr('class', 'traffic-data ' + this.getSpeedClass(data.tx));
        }

        if (rxCell.length) {
            rxCell.find('.bytes-counter').text(formatBytes(data.rxBytes));
            rxCell.find('.speed-indicator').text(data.rx);
            rxCell.attr('class', 'traffic-data ' + this.getSpeedClass(data.rx));
        }
    }

    findRowIndex(username) {
        const rows = this.table.rows().data();
        for (let i = 0; i < rows.length; i++) {
            if (rows[i].username === username) {
                return i;
            }
        }
        return -1;
    }
}

// Initialize monitor
$j(document).ready(() => {
    window.monitor = new TrafficMonitor();
});

// Define helper functions outside ready handler
function formatBytes(bytes, decimals = 2) {
    if (bytes === 0) return '0 Bytes';
    const k = 1024;
    const dm = decimals < 0 ? 0 : decimals;
    const sizes = ['Bytes', 'KB', 'MB', 'GB', 'TB', 'PB', 'EB', 'ZB', 'YB'];
    const i = Math.floor(Math.log(bytes) / Math.log(k));
    return parseFloat((bytes / Math.pow(k, i)).toFixed(dm)) + ' ' + sizes[i];
}

function getMaxLimit(data) {
    return data.max_limit || 'N/A';
}

// Add some CSS for better speed display
const additionalStyles = `
    body {
        background: #f8f9fa;
    }
    
    .card {
        border: none;
        border-radius: 10px;
        margin-bottom: 20px;
    }
    
    .nav-pills .nav-link {
        border-radius: 20px;
        padding: 8px 20px;
        margin: 0 5px;
    }
    
    .nav-pills .nav-link.active {
        background: linear-gradient(135deg, #0d6efd, #0dcaf0);
    }
    
    .table {
        margin-bottom: 0;
    }
    
    .table > :not(:first-child) {
        border-top: none;
    }
    
    .traffic-data {
        background: #f8f9fa;
        padding: 10px;
        border-radius: 6px;
        box-shadow: inset 0 1px 3px rgba(0,0,0,0.05);
    }
    
    .speed-indicator {
        font-weight: 600;
        font-size: 13px;
    }
    
    .bytes-counter {
        color: #6c757d;
        font-size: 12px;
    }
    
    .reconnect-button {
        transition: all 0.2s;
    }
    
    .reconnect-button:hover {
        transform: translateY(-2px);
    }
    
    .label {
        padding: 5px 12px;
        border-radius: 20px;
        font-size: 12px;
    }
    
    .bg-green {
        background: #198754 !important;
    }
    
    .bg-red {
        background: #dc3545 !important;
    }
    
    .form-control, .form-select {
        border-radius: 6px;
        border: 1px solid #dee2e6;
    }
    
    .form-control:focus, .form-select:focus {
        box-shadow: 0 0 0 0.25rem rgba(13,110,253,.15);
    }
    
    .dataTables_wrapper .dataTables_paginate .paginate_button {
        border-radius: 20px !important;
        margin: 0 3px;
        border: none !important;
    }
    
    .dataTables_wrapper .dataTables_paginate .paginate_button.current {
        background: linear-gradient(135deg, #0d6efd, #0dcaf0) !important;
        color: white !important;
    }
    
    .notification {
        border-radius: 10px;
        box-shadow: 0 4px 15px rgba(0,0,0,0.1);
    }
    .speed-indicator {
        font-weight: bold;
        display: block;
        margin-top: 4px;
        font-size: 12px;
    }
    .traffic-data {
        transition: all 0.3s ease;
        padding: 8px;
        border-radius: 4px;
        background: rgba(0,0,0,0.02);
    }
    .traffic-icon {
        display: inline-block;
        width: 10px;
        height: 10px;
        border-radius: 50%;
        margin-right: 5px;
        vertical-align: middle;
        transition: background-color 0.3s ease;
    }
    .traffic-icon-green {
        background-color: #28a745; /* Hijau untuk trafik rendah */
    }
    .traffic-icon-yellow {
        background-color: #fd7e14; /* Orange untuk trafik sedang */
    }
    .traffic-icon-red {
        background-color: #dc3545; /* Merah untuk trafik tinggi */
    }
    .reconnect-button {
        transition: all 0.3s ease;
    }
    .reconnect-button:hover {
        color: #ff0000 !important;
        transform: scale(1.2);
    }
    .fa-spin {
        animation: fa-spin 2s infinite linear;
    }
    @keyframes fa-spin {
        0% { transform: rotate(0deg); }
        100% { transform: rotate(360deg); }
    }
    /* Card styling */
    .panel-default {
        border: none;
        border-radius: 8px;
        box-shadow: 0 2px 6px rgba(0,0,0,0.1);
        background: white;
        margin-bottom: 20px;
    }

    /* Table styling */
    .table {
        margin-bottom: 0;
    }

    .table th {
        background: #f8f9fa;
        border-top: none;
        font-weight: 600;
        color: #495057;
        text-transform: uppercase;
        font-size: 12px;
        padding: 12px 8px;
    }

    .table td {
        padding: 12px 8px;
        vertical-align: middle;
    }

    /* Traffic data styling */
    .traffic-data {
        background: #f8f9fa;
        padding: 8px 12px;
        border-radius: 6px;
        box-shadow: inset 0 1px 3px rgba(0,0,0,0.05);
    }

    .speed-indicator {
        font-size: 13px;
        font-weight: 600;
        margin-top: 4px;
    }

    .bytes-counter {
        color: #6c757d;
        font-size: 12px;
    }

    /* Traffic icons */
    .traffic-icon {
        width: 8px;
        height: 8px;
        border-radius: 50%;
        display: inline-block;
        margin-right: 8px;
        position: relative;
        box-shadow: 0 0 0 2px rgba(255,255,255,0.8);
    }

    .traffic-icon-green {
        background: linear-gradient(45deg, #28a745, #34ce57);
    }

    .traffic-icon-yellow {
        background: linear-gradient(45deg, #fd7e14, #f9a352);
    }

    .traffic-icon-red {
        background: linear-gradient(45deg, #dc3545, #e4606d);
    }

    /* Status labels */
    .label {
        padding: 5px 10px;
        border-radius: 20px;
        font-size: 12px;
        font-weight: 500;
    }

    .bg-green {
        background: #28a745;
        color: white;
    }

    .bg-red {
        background: #dc3545;
        color: white;
    }

    /* Action buttons */
    .reconnect-button {
        padding: 6px;
        border-radius: 4px;
        transition: all 0.2s ease;
        color: #dc3545;
    }

    .reconnect-button:hover {
        background: rgba(220, 53, 69, 0.1);
        transform: scale(1.1);
    }

    /* Search container */
    .advanced-search-container {
        background: #fff;
        border-radius: 8px;
        padding: 15px 20px;
        margin-bottom: 20px;
        box-shadow: 0 2px 4px rgba(0,0,0,0.05);
    }

    .form-control {
        border-radius: 4px;
        border: 1px solid #ced4da;
        padding: 8px 12px;
        font-size: 14px;
    }

    .form-control:focus {
        border-color: #80bdff;
        box-shadow: 0 0 0 0.2rem rgba(13,110,253,.25);
    }

    /* Navigation tabs */
    .nav-tabs {
        border-bottom: none;
        margin-bottom: 20px;
    }

    .nav-tabs > li > a {
        border-radius: 6px;
        padding: 10px 15px;
        margin-right: 5px;
        transition: all 0.2s ease;
    }

    .nav-tabs > li.active > a {
        background: #007bff;
        color: white;
        border: none;
    }

    .nav-tabs > li > a:hover {
        background: rgba(0,123,255,0.1);
        border-color: transparent;
    }

    /* Responsive improvements */
    @media (max-width: 768px) {
        .panel-body {
            padding: 10px;
        }
        
        .table td, .table th {
            padding: 8px 4px;
            font-size: 13px;
        }
        
        .traffic-data {
            padding: 6px 8px;
        }
    }

    /* Animation effects */
    .traffic-data, .traffic-icon, .label {
        transition: all 0.3s ease;
    }

    /* DataTables improvements */
    .dataTables_wrapper .dataTables_paginate .paginate_button {
        border-radius: 20px;
        padding: 5px 12px;
        margin: 0 2px;
    }

    .dataTables_wrapper .dataTables_paginate .paginate_button.current {
        background: #007bff;
        border-color: #007bff;
        color: white !important;
    }

    /* Modern Table Styling */
    .table-responsive {
        background: white;
        padding: 20px;
        border-radius: 12px;
        box-shadow: 0 2px 15px rgba(0,0,0,0.08);
    }

    .table {
        border-collapse: separate;
        border-spacing: 0 8px;
        margin-top: -8px;
    }

    .table thead th {
        background: #f8f9fa;
        border: none;
        padding: 15px 10px;
        font-weight: 600;
        color: #2c3e50;
        font-size: 13px;
        text-transform: uppercase;
        letter-spacing: 0.5px;
        vertical-align: middle;
    }

    .table tbody tr {
        box-shadow: 0 2px 6px rgba(0,0,0,0.02);
        border-radius: 8px;
        transition: transform 0.2s ease, box-shadow 0.2s ease;
    }

    .table tbody tr:hover {
        transform: translateY(-2px);
        box-shadow: 0 4px 12px rgba(0,0,0,0.08);
        background: #f8f9fa;
    }

    .table tbody td {
        padding: 12px 10px;
        vertical-align: middle;
        border: none;
        background: white;
        font-size: 13px;
    }

    .table tbody tr:first-child td:first-child {
        border-top-left-radius: 8px;
        border-bottom-left-radius: 8px;
    }

    .table tbody tr:first-child td:last-child {
        border-top-right-radius: 8px;
        border-bottom-right-radius: 8px;
    }

    /* Traffic Data Cells */
    .traffic-data {
        background: #f8f9fa;
        padding: 10px;
        border-radius: 8px;
        box-shadow: inset 0 2px 4px rgba(0,0,0,0.02);
        min-width: 120px;
    }

    .bytes-counter {
        color: #6c757d;
        font-size: 11px;
        display: block;
        margin-bottom: 4px;
    }

    .speed-indicator {
        font-size: 14px;
        font-weight: 600;
        display: block;
    }

    /* Status Labels */
    .label {
        padding: 6px 12px;
        border-radius: 20px;
        font-size: 12px;
        font-weight: 500;
        display: inline-block;
        min-width: 85px;
    }

    .bg-green {
        background: linear-gradient(135deg, #28a745, #20c997);
        color: white;
        box-shadow: 0 2px 4px rgba(40, 167, 69, 0.2);
    }

    .bg-red {
        background: linear-gradient(135deg, #dc3545, #f86b7c);
        color: white;
        box-shadow: 0 2px 4px rgba(220, 53, 69, 0.2);
    }

    /* Search Container Enhancement */
    .advanced-search-container {
        background: white;
        border-radius: 12px;
        padding: 20px;
        margin-bottom: 25px;
        box-shadow: 0 2px 15px rgba(0,0,0,0.08);
    }

    .form-control {
        border-radius: 6px;
        border: 1px solid #e9ecef;
        padding: 8px 16px;
        font-size: 14px;
        transition: all 0.2s ease;
    }

    .form-control:focus {
        border-color: #80bdff;
        box-shadow: 0 0 0 3px rgba(0,123,255,.15);
    }

    /* DataTables Enhancements */
    .dataTables_wrapper .dataTables_paginate {
        padding: 15px 0;
    }

    .dataTables_wrapper .dataTables_paginate .paginate_button {
        border-radius: 20px;
        padding: 6px 14px;
        margin: 0 3px;
        border: none !important;
        background: #f8f9fa !important;
        color: #495057 !important;
        transition: all 0.2s ease;
    }

    .dataTables_wrapper .dataTables_paginate .paginate_button:hover {
        background: #e9ecef !important;
        color: #212529 !important;
        transform: translateY(-1px);
    }

    .dataTables_wrapper .dataTables_paginate .paginate_button.current,
    .dataTables_wrapper .dataTables_paginate .paginate_button.current:hover {
        background: linear-gradient(135deg, #007bff, #6610f2) !important;
        color: white !important;
        box-shadow: 0 2px 6px rgba(0,123,255,0.2);
    }

    .dataTables_length select {
        border-radius: 6px;
        padding: 6px 12px;
        border: 1px solid #e9ecef;
    }

    /* Empty Table Styling */
    .dataTables_empty {
        padding: 48px !important;
        font-size: 15px;
        color: #6c757d;
        text-align: center;
        background: #f8f9fa !important;
        border-radius: 8px;
    }

    /* Responsive Design */
    @media (max-width: 768px) {
        .table-responsive {
            padding: 10px;
        }
        
        .table td, .table th {
            padding: 10px 6px;
        }
        
        .traffic-data {
            padding: 8px;
            min-width: 100px;
        }
        
        .label {
            padding: 4px 8px;
            min-width: 70px;
        }
    }

    /* Adjust column widths after removing ID */
    .table th:nth-child(1) { width: 15%; } /* Username */
    .table th:nth-child(2) { width: 12%; } /* IP Address */
    .table th:nth-child(3) { width: 10%; } /* Uptime */
    .table th:nth-child(4) { width: 10%; } /* Service */
    .table th:nth-child(5) { width: 12%; } /* Caller ID */
    .table th:nth-child(6) { width: 10%; } /* Download */
    .table th:nth-child(7) { width: 10%; } /* Upload */
    .table th:nth-child(8) { width: 8%; }  /* Max Limit */
    .table th:nth-child(9) { width: 8%; }  /* Total Usage */
    .table th:nth-child(10) { width: 8%; } /* Status */
    .table th:nth-child(11) { width: 7%; } /* Actions */

    /* Modern Reconnect Button */
    .btn-reconnect {
        background: linear-gradient(135deg, #ff4646, #ff7676);
        color: white;
        border: none;
        padding: 8px 16px;
        border-radius: 20px;
        font-size: 12px;
        font-weight: 500;
        cursor: pointer;
        transition: all 0.3s ease;
        box-shadow: 0 2px 4px rgba(255, 70, 70, 0.2);
        display: inline-flex;
        align-items: center;
        gap: 6px;
    }

    .btn-reconnect:hover {
        transform: translateY(-2px);
        box-shadow: 0 4px 8px rgba(255, 70, 70, 0.3);
        background: linear-gradient(135deg, #ff3535, #ff6565);
    }

    .btn-reconnect:active {
        transform: translateY(0);
        box-shadow: 0 2px 4px rgba(255, 70, 70, 0.2);
    }

    .btn-reconnect i {
        font-size: 14px;
    }

    .btn-reconnect.loading {
        opacity: 0.8;
        cursor: wait;
        background: linear-gradient(135deg, #888, #999);
    }

    /* Spin animation for loading state */
    .btn-reconnect.loading i {
        animation: spin 1s linear infinite;
    }

    @keyframes spin {
        0% { transform: rotate(0deg); }
        100% { transform: rotate(360deg); }
    }

    /* Notification styling */
    .notification {
        position: fixed;
        top: 20px;
        right: 20px;
        padding: 15px 25px;
        border-radius: 8px;
        color: white;
        z-index: 9999;
        box-shadow: 0 4px 12px rgba(0,0,0,0.15);
        animation: slideIn 0.3s ease;
    }

    @keyframes slideIn {
        from { transform: translateX(100%); opacity: 0; }
        to { transform: translateX(0); opacity: 1; }
    }

    /* Override Bootstrap's default navbar styling */
    .nav-pills {
        border: none !important;
    }

    .nav-pills .nav-link {
        border: none !important;
        background: #f8f9fa;
        color: #495057;
        margin: 0 5px;
        padding: 10px 20px;
        border-radius: 10px;
        transition: all 0.3s ease;
    }

    .nav-pills .nav-link:hover {
        background: #e9ecef;
        transform: translateY(-1px);
    }

    .nav-pills .nav-link.active {
        background: #0d6efd;
        color: white;
        box-shadow: 0 4px 12px rgba(13, 110, 253, 0.15);
    }

    /* Clean DataTables styling */
    .dataTables_wrapper {
        background: white;
        border-radius: 10px;
        padding: 20px;
        box-shadow: 0 2px 15px rgba(0,0,0,0.08);
`;
</script>
