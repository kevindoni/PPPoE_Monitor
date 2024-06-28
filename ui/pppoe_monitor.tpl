{include file="sections/header.tpl"}

<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
<script src="https://cdn.jsdelivr.net/npm/apexcharts"></script>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script src="https://cdn.datatables.net/1.11.3/js/jquery.dataTables.min.js"></script>
<script src="https://cdn.datatables.net/1.11.3/js/dataTables.bootstrap5.min.js"></script>


<style>
    .modal {
    display: none;
    position: fixed;
    z-index: 1;
    left: 0;
    top: 0;
    width: 100%;
    height: 100%;
    overflow: auto;
    background-color: rgba(0, 0, 0, 0.4);
    }
    .modal-content {
    background-color: #fefefe;
    margin: 15% auto;
    padding: 0px;
    border: 1px solid #888;
    width: 80%;
    box-shadow: 0 4px 8px 0 rgba(0, 0, 0, 0.2), 0 6px 20px 0 rgba(0, 0, 0, 0.19);
    max-width: 600px;
    }
    .close {
    color: #aaa;
    float: right;
    font-size: 28px;
    font-weight: bold;
    cursor: pointer;
    }
    .close:hover,
    .close:focus {
    color: black;
    text-decoration: none;
    }
    .card-body {
    padding: 1rem;
    }
    .card-header {
    padding: .75rem 1.25rem;
    margin-bottom: 0;
    background-color: none;
    border-bottom: 1px solid rgba(0,0,0,.125);
    }
    .card-title {
    margin-bottom: .75rem;
    }
    .form-group {
    margin-bottom: 1rem;
    }
    .table-responsive {
    display: block;
    width: 100%;
    overflow-x: auto;
    -webkit-overflow-scrolling: touch;
    -ms-overflow-style: -ms-autohiding-scrollbar;
    }
    .table {
    width: 100%;
    margin-bottom: 1rem;
    color: #212529;
    }
    .container {
        padding-top: 20px;
    }
    #ppp-table_wrapper {
        padding: 15px;
    }
    #ppp-table th, #ppp-table td {
        text-align: center;
        padding: 6px;
    }
    .table-striped tbody tr:nth-of-type(odd) {
        background-color: #f9f9f9;
    }
    .panel-default {
        border-color: #ddd;
    }
    .panel-heading {
        background-color: #f5f5f5;
        border-color: #ddd;
    }
    .nav-tabs {
        margin-bottom: 15px;
    }
    .nav-tabs > li > a {
        border-radius: 0;
        color: #555;
        background-color: #f9f9f9;
        border-color: #ddd;
    }
    .nav-tabs > li.active > a,
    .nav-tabs > li.active > a:focus,
    .nav-tabs > li.active > a:hover {
        background-color: #fff;
        color: #333;
        border: 1px solid #ddd;
        border-bottom-color: transparent;
        cursor: default;
    }
    .table-striped tbody tr:nth-of-type(odd) {
        background-color: #f9f9f9;
    }
    .table th {
        background-color: #f5f5f5;
        color: #333;
        font-weight: bold;
        padding: 8px;
    }
    .table-striped > tbody > tr > td {
        background-color: #fff;
    }
    .status-connect {
        color: #5cb85c;
    }
    .status-disconnect {
        color: #d9534f;
    }
      .modalsupport {
      display: none;
      position: fixed;
      z-index: 1;
      left: 0;
      top: 0;
      width: 100%;
      height: 100%;
      overflow: auto;
      background-color: rgb(0,0,0);
      background-color: rgba(0,0,0,0.4);
      justify-content: center;
      align-items: center;
    }
    .modalsupport-content {
      background-color: #fefefe;
      margin: auto;
      padding: 0px;
      border: 1px solid #888;
      width: 80%;
      max-width: 500px;
      box-shadow: 0 5px 15px rgba(0,0,0,0.3);
      text-align: center;
    }
    .modalsupport-close {
      color: #aaa;
      float: right;
      font-size: 28px;
      font-weight: bold;
    }
    .modalsupport-close:hover,
    .modalsupport-close:focus {
      color: black;
      text-decoration: none;
      cursor: pointer;
    }
    .card {
      border: none;
    }
    .card-header {
      background-color: none;
      border-bottom: none;
    }
    .card-body {
      padding: 20px;
    }
    .donate-button {
      margin-top: 10px;
    }
    .modalsupport img {
      width: 100px;
      height: auto;
      margin-top: 15px;
    }
    .dataSize {
        white-space: nowrap;
    }
    .action-icons i {
      cursor: pointer;
      margin-right: 10px;
      color: #007bff;
    }
    .action-icons i:hover {
      color: #0056b3;
    }
    .modal-title {
    text-align: center;
    width: 100%;
    display: block;
    font-size: 20px;
    font-weight: bold;
    margin-top: 20px;
  }
  .table-bordered {
      width: 100%;
      max-width: 100%;
      table-layout: fixed;
  }
  .table-bordered th, .table-bordered td {
      width: auto;
      overflow: hidden;
      text-overflow: ellipsis;
      white-space: nowrap;
      background: none;
      border: none;
      padding: 10px;
      vertical-align: middle;
      text-align: center;
  }
  .advanced-search-container {
    margin-bottom: 20px;
    padding: 15px;
    background-color: #f9f9f9;
    border: 1px solid #ddd;
    }
    .form-inline .form-group {
        margin-right: 10px;
    }
    .dataTables_filter {
        display: none;
    }
    @media (max-width: 768px) {
        .panel-default {
            padding: 10px;
            margin: 0;
        }
        .panel-heading {
            padding: 5px 15px;
        }
        .panel-body {
            padding: 5px 10px;
        }
    .table th, .table td {
        font-size: 15px; /* Mengurangi ukuran font pada tabel */
    }
}
</style>
<div class="container">
    <div class="row">
        <div class="col-xs-12 col-sm-12 col-md-12 col-lg-12">
            <!-- Form dan navigasi tabs -->
            <form class="form-horizontal" method="post" role="form" action="{$_url}plugin/pppoe_monitor_router_menu">
                <ul class="nav nav-tabs">
                    {foreach $routers as $r}
                    <li role="presentation" {if $r['id']==$router}class="active"{/if}>
                        <a href="{$_url}plugin/pppoe_monitor_router_menu/{$r['id']}">{$r['name']}</a>
                    </li>
                    {/foreach}
                </ul>
            </form>
            <div class="advanced-search-container">
                <form id="advancedSearchForm" class="form-inline">
                    <div class="form-group">
                        <label for="searchUsername">Username:</label>
                        <input type="text" class="form-control" id="searchUsername" placeholder="Enter username">
                    </div>
                    <div class="form-group">
                        <label for="searchStatus">Status:</label>
                        <select class="form-control" id="searchStatus">
                            <option value="">Any</option>
                            <option value="Connected">Connected</option>
                            <option value="Disconnected">Disconnected</option>
                        </select>
                    </div>
                </form>
            </div>
            <div class="panel panel-default">
                <div class="table-responsive">
                    <div class="panel-body">
                        <table class="table table-striped" id="ppp-table">
                            <thead>
                                <tr>
                                    <th>ID</th>
                                    <th>Username</th>
                                    <th>IP Address</th>
                                    <th>Uptime</th>
                                    <th>Service</th>
                                    <th>Caller ID</th>
                                    <th>Download</th>
                                    <th>Upload</th>
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
            </div>
        </div>
    </div>
</div>
<div id="detailsModal" class="modal">
  <div class="modal-content">
    <span class="close">&times;</span>
    <div class="container-fluid mt-5">
      <div class="card">
        <div class="card-header">
          <h5 class="modal-title">Trafik for <span id="modalUsername"></span></h5>
        </div>
        <div class="card-body">
          <div class="table-responsive mt-4">
            <table class="table table-bordered">
              <thead>
                <tr>
                <input type="hidden" id="interface" value="">
                  <th id="tabletx"><i class="fa fa-download"></i></th>
                  <th id="tablerx"><i class="fa fa-upload"></i></th>
                </tr>
              </thead>
            </table>
          </div>
          <div id="chart" class="mt-3"></div>
          <div id="dailyChart" class="mt-3"></div>
        </div>
      </div>
    </div>
  </div>
</div>
<div id="donationPopup" class="modalsupport">
  <div class="modalsupport-content">
    <span class="modalsupport-close">&times;</span>
    <div class="container-fluid mt-5">
      <div class="card">
        <div class="card-header">
          <h5 class="modal-title">Support Us</h5>
        </div>
        <div class="card-body">
          <p>Your support helps us maintain and improve our services. Consider donating today!</p>
          <button class="btn btn-primary donate-button">Donate Now</button>
          <p class="mt-3">Thank you for your support!</p>
          <img src="https://kodingku.my.id/bmc_qr.png" alt="QR Code">
        </div>
      </div>
    </div>
  </div>
</div>
<script>
var $j = jQuery.noConflict();

$j(document).ready(function() {
    var table = $j('#ppp-table').DataTable({
        responsive: true,
        columns: [
            { data: 'id', visible: false },
            { data: 'username' },
            { data: 'address' },
            { data: 'uptime' },
            { data: 'service' },
            { data: 'caller_id' },
            { data: 'tx', className: 'dataSize' },
            { data: 'rx', className: 'dataSize' },
            { data: 'total', className: 'dataSize' },
            {
                data: 'status',
                render: function(data) {
                    if (data === 'Connected') {
                        return '<small class="label bg-green">Connected</small>';
                    } else if (data === 'Disconnected') {
                        return '<small class="label bg-red">Disconnected</small>';
                    } else {
                        return '';
                    }
                }
            },
            {
                data: null,
                render: function(data, type, row) {
                return '<div class="action-icons" style="display: flex; align-items: center;">' +
                    '<i class="fa fa-area-chart view-details" style="color: blue; cursor: pointer;" title="View Traffic" data-username="' + row.username + '" data-id="' + row.id + '"></i> ' +
                    '<i class="fa fa-retweet reconnect-button" style="color: red; cursor: pointer;" title="Reconnect" data-username="' + row.username + '" data-id="' + row.id + '"></i> ' +
                    '</div>';
                }
            }
        ],
        order: [[0, 'asc']],
        pageLength: 10,
        lengthMenu: [[10, 25, 50, -1], [10, 25, 50, 'All']],
        dom: 'Bfrtip',
        buttons: ['reset', 'pageLength'],
        paging: true,
        info: true,
        searching: true, // Menonaktifkan pencarian
        ajax: {
            url: '{$_url}plugin/pppoe_monitor_router_get_ppp_online_users/{$router}',
            dataSrc: ''
        }
    });

    // Handle view details icon clicks
    $j('#ppp-table tbody').on('click', '.view-details', function(e) {
        e.preventDefault();
        var username = $j(this).data('username');
        var id = $j(this).data('id');

        viewDetails(id, username);
    });

    // Handle reconnect icon clicks
    $j('#ppp-table tbody').on('click', '.reconnect-button', function(e) {
        e.preventDefault();
        var username = $j(this).data('username');
        var id = $j(this).data('id');

        reconnect(id, username);
    });


// Function to handle view details
    function viewDetails(id, username) {
        console.log("Viewing details for:", username);
        $j('#modalUsername').text(username);

        $j.ajax({
            url: '{$_url}plugin/pppoe_monitor_router_get_ppp_online_users',
            method: 'GET',
            dataType: 'json',
            success: function(response) {
                var user = response.find(function(item) {
                    return (item.username && item.username.toString().toLowerCase() === username.toString().toLowerCase());
                });

                if (user) {
                    var interfaceValue = '<pppoe-' + user.username + '>';
                    $j('#interface').val(interfaceValue);
                    $j('#selectedInterface').text(interfaceValue);
                    $j('#detailsModal').css('display', 'block');
                    createChart();
                    createDailyChart(username);
                } else {
                    alert('User not found.');
                }
            },
            error: function(xhr, textStatus, errorThrown) {
                alert('Failed to retrieve user data.');
                console.error('AJAX error:', textStatus, errorThrown);
            }
        });
    }


    // Function to handle reconnect
    function reconnect(id, username) {
        if (confirm('Are you sure you want to disconnect user ' + username + '?')) {
            $j.ajax({
                url: '{$_url}plugin/pppoe_monitor_router_delete_ppp_user/{$router}',
                method: 'POST',
                data: { id: id, username: username },
                success: function(response) {
                    if (response.success) {
                        alert('User ' + username + ' has been disconnected.');
                        setTimeout(function() {
                            table.ajax.reload();
                        }, 2000);
                    } else {
                        alert('Failed to disconnect user ' + username + ': ' + response.message);
                    }
                },
                error: function(xhr, textStatus, errorThrown) {
                    alert('Failed to disconnect user ' + username + '.');
                    console.error('AJAX error:', textStatus, errorThrown);
                }
            });
        }
    }

    // Close modal on click of close button
    $j('.close').click(function() {
        $j('#detailsModal').css('display', 'none');
    });

    // Close modal on click outside the modal
    $j(window).click(function(event) {
        if (event.target == document.getElementById('detailsModal')) {
            $j('#detailsModal').css('display', 'none');
        }
    });

    // Handle advanced search form submission
    $j(document).ready(function() {
        $j('#advancedSearchForm').on('submit', function(e) {
            e.preventDefault(); // Mencegah pengiriman form secara default

            // Mendapatkan nilai dari input
            var username = $j('#searchUsername').val();
            var status = $j('#searchStatus').val();

            // Melakukan pencarian dan menggambar ulang tabel
            table.column(1).search(username).draw(); // Kolom 1 untuk username
            table.column(9).search(status).draw(); // Kolom 9 untuk status
        });

        // Menambahkan ikon search ke dalam tombol
        var searchButton = $j('<button type="submit" class="btn btn-primary"><i class="fas fa-search"></i></button>');
        $j('#advancedSearchForm').append(searchButton);
    });

});

    var chart;
    var chartData = {
        txData: [],
        rxData: []
    };

    function createChart() {
        var options = {
            chart: {
                height: 350,
                type: 'area',
                animations: {
                    enabled: true,
                    easing: 'linear',
                    speed: 200,
                    animateGradually: {
                        enabled: true,
                        delay: 150
                    },
                    dynamicAnimation: {
                        enabled: true,
                        speed: 200
                    }
                },
                events: {
                    mounted: function() {
                        updateTrafficValues();
                        setInterval(updateTrafficValues, 3000);
                    }
                }
            },
            stroke: {
                curve: 'smooth'
            },
            series: [
                { name: 'Download', data: chartData.txData },
                { name: 'Upload', data: chartData.rxData }
            ],
            xaxis: {
                type: 'datetime',
                labels: {
                    formatter: function(value) {
                        return new Date(value).toLocaleTimeString();
                    }
                }
            },
            yaxis: {
                title: {
                    text: 'Trafik Real Time'
                },
                labels: {
                    formatter: function(value) {
                        return formatBytes(value);
                    }
                }
            },
            tooltip: {
                x: {
                    format: 'HH:mm:ss'
                },
                y: {
                    formatter: function(value) {
                        return formatBytes(value) + 'ps';
                    }
                }
            },
            dataLabels: {
                enabled: true,
                formatter: function(value) {
                    return formatBytes(value);
                }
            }
        };

        chart = new ApexCharts(document.querySelector("#chart"), options);
        chart.render();
    }
// ========================GRAFIK BAR HARIAN======================================//

var dailyChart; // Declare dailyChart variable globally
var startOfPreviousDay, endOfPreviousDay; // Global variables to store start and end times of the previous day
var startOfMonth, endOfMonth; // Declare startOfMonth and endOfMonth globally

// Function to retrieve data from MikroTik graphs/iface
function retrieveDataFromMikroTik(username, startDate, endDate) {
    // Example: Using AJAX to fetch data from your PHP endpoint
    return new Promise((resolve, reject) => {
        $.ajax({
            url: '{$_url}plugin/pppoe_monitor_router_daily_data_usage/{$router}',
            data: {
                username: username,
                start_date: new Date(startDate).toISOString(),
                end_date: new Date(endDate).toISOString()
            },
            dataType: 'json',
            success: function(data) {
                resolve(data); // Assume data is already in the expected format
            },
            error: function(xhr, textStatus, errorThrown) {
                reject(errorThrown);
            }
        });
    });
}

// Function to process MikroTik data and convert it to daily data format
function processMikroTikData(mikrotikData) {
    var dailyData = {
        download: [],
        upload: []
    };

    // Process mikrotikData and push into dailyData.download and dailyData.upload arrays
    mikrotikData.forEach(entry => {
        var timestamp = new Date(entry.timestamp).getTime(); // Convert timestamp to milliseconds
        var download = entry.download; // Assume download data in bytes
        var upload = entry.upload; // Assume upload data in bytes

        // Push data into dailyData arrays
        dailyData.download.push({ x: timestamp, y: download });
        dailyData.upload.push({ x: timestamp, y: upload });
    });

    return dailyData;
}

// Function to generate daily data for a specific username within a date range
function generateDailyData(username, startDate, endDate) {
    return new Promise((resolve, reject) => {
        retrieveDataFromMikroTik(username, startDate, endDate)
            .then(mikrotikData => {
                var dailyData = processMikroTikData(mikrotikData);
                historicalDailyData.push(dailyData); // Store in historical data array
                resolve(dailyData); // Resolve promise with processed daily data
            })
            .catch(error => {
                console.error('Error retrieving data from MikroTik:', error);
                reject(error);
            });
    });
}

// Function to create daily chart
function createDailyChart(username) {
    // Set initial start and end dates for the current month
    var currentDate = new Date();
    startOfMonth = new Date(currentDate.getFullYear(), currentDate.getMonth(), 1).getTime();
    endOfMonth = new Date(currentDate.getFullYear(), currentDate.getMonth() + 1, 0).getTime();

    // Call generateDailyData with initial start and end dates
    generateDailyData(username, startOfMonth, endOfMonth)
        .then(dailyData => {
            startOfPreviousDay = startOfMonth;
            endOfPreviousDay = endOfMonth;

            var dailyTotals = dailyData.download.map((item, index) => ({
                x: item.x,
                y: item.y + dailyData.upload[index].y
            }));

            if (dailyChart) {
                dailyChart.destroy();
            }

            var options = {
                chart: {
                    height: 350,
                    type: 'bar',
                    animations: {
                        enabled: true,
                        easing: 'linear',
                        speed: 800,
                        animateGradually: {
                            enabled: true,
                            delay: 150
                        },
                        dynamicAnimation: {
                            enabled: true,
                            speed: 200
                        }
                    },
                    toolbar: {
                        show: true,
                    }
                },
                plotOptions: {
                    bar: {
                        horizontal: false,
                        columnWidth: '15%',
                        endingShape: 'rounded'
                    },
                },
                dataLabels: {
                    enabled: false
                },
                stroke: {
                    show: true,
                    width: 2,
                    colors: ['transparent']
                },
                series: [{
                    name: 'Download',
                    data: dailyData.upload
                }, {
                    name: 'Upload',
                    data: dailyData.download
                }, {
                    name: 'Daily Totals',
                    data: dailyTotals
                }],
                xaxis: {
                    type: 'datetime',
                    min: startOfMonth,
                    max: endOfMonth,
                    labels: {
                        formatter: function(value) {
                            return new Date(value).toLocaleDateString();
                        }
                    }
                },
                yaxis: {
                    title: {
                        text: 'Total Usage'
                    },
                    labels: {
                        formatter: function(value) {
                            return formatBytesPerSecond(value);
                        }
                    }
                },
                fill: {
                    opacity: 1
                },
                tooltip: {
                    y: {
                        formatter: function(value) {
                            return formatBytesPerSecond(value);
                        }
                    }
                },
                responsive: [{
                    breakpoint: 480,
                    options: {
                        plotOptions: {
                            bar: {
                                columnWidth: '100%'
                            }
                        }
                    }
                }]
            };

            dailyChart = new ApexCharts(document.querySelector("#dailyChart"), options);
            dailyChart.render();

            // Update dailyChart every day at 00:00:00
            setInterval(function() {
                generateDailyData(username, startOfMonth, endOfMonth).then(function(dailyData) {
                    dailyTotals = dailyData.download.map((item, index) => ({
                        x: item.x,
                        y: item.y + dailyData.upload[index].y
                    }));
                    dailyChart.updateSeries([{
                        name: 'Download',
                        data: dailyData.download
                    }, {
                        name: 'Upload',
                        data: dailyData.upload
                    }, {
                        name: 'Daily Totals',
                        data: dailyTotals
                    }]);
                });
            }, 86400000); // 86400000 ms = 24 hours

            // Update startOfMonth and endOfMonth every day at 00:00:00
            setInterval(updateMonthRange, 86400000); // 86400000 ms = 24 hours
        })
        .catch(error => {
            console.error("Failed to fetch daily usage data:", error);
        });
}

// Function to update startOfMonth and endOfMonth every day at 00:00:00
function updateMonthRange() {
    var currentDate = new Date();
    startOfMonth = new Date(currentDate.getFullYear(), currentDate.getMonth(), 1).getTime();
    endOfMonth = new Date(currentDate.getFullYear(), currentDate.getMonth() + 1, 0).getTime();
}

// ========================================== NEW FITUR ==========================================//
    // Function to generate daily data for a specific username within a date range
    function generateDailyData(username, startDate, endDate) {
        return new Promise((resolve, reject) => {
            // Prepare AJAX request
            $j.ajax({
                url: '{$_url}plugin/pppoe_monitor_router_daily_data_usage/{$router}',
                data: {
                    username: username,
                    start_date: new Date(startDate).toISOString(),
                    end_date: new Date(endDate).toISOString()
                },
                dataType: 'json',
                success: function(data) {
                    var dailyData = {
                        download: [],
                        upload: []
                    };

                    Object.keys(data).forEach(date => {
                        var users = data[date].users;

                        // Handle username as number case
                        var userData = users.find(user => user.username === username || user.username == parseInt(username));

                        if (userData) {
                            var rxBytes = convertToBytes(userData.rx);
                            var txBytes = convertToBytes(userData.tx);

                            // Store data in dailyData based on date
                            dailyData.download.push({ x: new Date(date).getTime(), y: rxBytes });
                            dailyData.upload.push({ x: new Date(date).getTime(), y: txBytes });
                        }
                    });

                    console.log("Filtered daily data for username", username, ":", dailyData);
                    resolve(dailyData);
                },
                error: function(xhr, textStatus, errorThrown) {
                    console.error("AJAX Error in generateDailyData:", textStatus, errorThrown);
                    console.log("Status:", xhr.status);
                    console.log("Response Text:", xhr.responseText);
                    reject(errorThrown);
                }
            });
        });
    }


    // Function to convert usage string to bytes
    function convertToBytes(usage) {
        var unit = usage.slice(-2).toUpperCase(); // Get unit (GB or MB)
        var value = parseFloat(usage.slice(0, -3)); // Get value without unit

        switch (unit) {
            case 'GB':
                return value * 1024 * 1024 * 1024;
            case 'MB':
                return value * 1024 * 1024;
            default:
                return 0;
        }
    }



    function renderHistoricalDailyChart() {
    // Combine historical daily data for rendering
    var combinedData = historicalDailyData.reduce((acc, data) => {
        acc.download.push(...data.download);
        acc.upload.push(...data.upload);
        return acc;
    }, { download: [], upload: [] });

    if (dailyChart) {
        // Update existing chart with combined data
        dailyChart.updateSeries([
            { name: 'Download', data: combinedData.download },
            { name: 'Upload', data: combinedData.upload }
        ]);
    } else {
        // Create a new chart instance with combined data
        dailyChart = new ApexCharts(document.querySelector("#dailyChart"), {
            chart: {
                type: 'line',
                height: 350,
                stacked: false,
            },
            series: [
                { name: 'Download', data: combinedData.download },
                { name: 'Upload', data: combinedData.upload }
            ],
            xaxis: {
                type: 'datetime',
                categories: combinedData.categories  // Assuming you have categories for x-axis
            },
            tooltip: {
                shared: false,
                intersect: true,
                y: {
                    formatter: function (val) {
                        return val.toFixed(2) + " GB";
                    }
                }
            }
        });

        // Render the new chart instance
        dailyChart.render();
    }
}
// ========================================== NEW FITUR ==========================================//

    // Function to format bytes per second
    function formatBytesPerSecond(bytes) {
        if (bytes === 0) {
            return '0 Bps';
        }
        var k = 1024;
        var sizes = ['Bps', 'KBps', 'MBps', 'GBps', 'TBps', 'PBps', 'EBps', 'ZBps', 'YBps'];
        var i = Math.floor(Math.log(bytes) / Math.log(k));
        var formattedValue = parseFloat((bytes / Math.pow(k, i)).toFixed(2));
        return formattedValue + ' ' + sizes[i];
    }

    // Function to format bytes
    function formatBytes(bytes) {
        if (bytes === 0) {
            return '0 B';
        }
        var k = 1024;
        var sizes = ['B', 'KB', 'MB', 'GB', 'TB', 'PB', 'EB', 'ZB', 'YB'];
        var i = Math.floor(Math.log(bytes) / Math.log(k));
        var formattedValue = parseFloat((bytes / Math.pow(k, i)).toFixed(2));
        return formattedValue + ' ' + sizes[i];
    }

    // Function to update traffic values
    function updateTrafficValues() {
        var username = $j('#modalUsername').text().trim();
        var interfaceValue = $j('#interface').val();

        if (!username || !interfaceValue) {
            console.error("Username or interface is undefined or empty.");
            return;
        }

        $j.ajax({
            url: '{$_url}plugin/pppoe_monitor_router_traffic/{$router}',
            dataType: 'json',
            data: { username: username, interface: interfaceValue },
            success: function(data) {
                var timestamp = new Date().getTime();
                var txData = parseInt(data.rows.tx[0]) || 0;
                var rxData = parseInt(data.rows.rx[0]) || 0;

                chartData.txData.push({ x: timestamp, y: txData });
                chartData.rxData.push({ x: timestamp, y: rxData });

                var maxDataPoints = 10;
                if (chartData.txData.length > maxDataPoints) {
                    chartData.txData.shift();
                    chartData.rxData.shift();
                }

                chart.updateSeries([
                    { name: 'Download', data: chartData.txData },
                    { name: 'Upload', data: chartData.rxData }
                ]);

                document.getElementById("tabletx").innerHTML = '<i class="fa fa-download"></i>&nbsp;&nbsp;' + formatBytes(txData);
                document.getElementById("tablerx").innerHTML = '<i class="fa fa-upload"></i>&nbsp;&nbsp;' + formatBytes(rxData);
            },
            error: function(xhr, textStatus, errorThrown) {
                console.error("Status: " + textStatus);
                console.error("Error: " + errorThrown);
            }
        });
    }


// Donation Popup
document.addEventListener('DOMContentLoaded', function() {
    setTimeout(function() {
        document.getElementById('donationPopup').style.display = 'flex';
    }, 1000);
});

document.getElementById('donationPopup').querySelector('.modalsupport-close').addEventListener('click', function() {
    document.getElementById('donationPopup').style.display = 'none';
});

window.addEventListener('click', function(event) {
    if (event.target === document.getElementById('donationPopup')) {
        document.getElementById('donationPopup').style.display = 'none';
    }
});

document.getElementById('donationPopup').querySelector('.donate-button').addEventListener('click', function() {
    window.open('https://buymeacoffee.com/kevindonisaputra', '_blank');
});

</script>



{include file="sections/footer.tpl"}
