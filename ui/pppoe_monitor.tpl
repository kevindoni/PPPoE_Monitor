{include file="sections/header.tpl"}

<style>
    /* Style untuk modal */
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
    padding: 20px;
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
    /* Style untuk modal */

    /* Style untuk card-body di dalam modal */
    .card-body {
    padding: 1rem;
    }

    .card-header {
    padding: .75rem 1.25rem;
    margin-bottom: 0;
    background-color: #f5f5f5;
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
    /* Custom styling for the table */
    .container {
        padding-top: 20px;
    }
    #ppp-table_wrapper {
        padding: 15px;
    }
    #ppp-table th, #ppp-table td {
        text-align: center;
        padding: 6px; /* Adjust padding for better spacing */
    }
    .table-striped tbody tr:nth-of-type(odd) {
        background-color: #f9f9f9; /* Alternating row background color */
    }
    /* New styles for enhanced look */
    .panel-default {
        border-color: #ddd; /* Lighter border for panels */
    }
    .panel-heading {
        background-color: #f5f5f5; /* Light gray background for panel heading */
        border-color: #ddd;
    }
    .nav-tabs {
        margin-bottom: 15px; /* Margin below tabs */
    }
    .nav-tabs > li > a {
        border-radius: 0;
        color: #555; /* Text color */
        background-color: #f9f9f9; /* Background color */
        border-color: #ddd; /* Border color */
    }
    .nav-tabs > li.active > a,
    .nav-tabs > li.active > a:focus,
    .nav-tabs > li.active > a:hover {
        background-color: #fff; /* Active tab background color */
        color: #333; /* Active tab text color */
        border: 1px solid #ddd; /* Active tab border color */
        border-bottom-color: transparent; /* Prevent doubling of border */
        cursor: default;
    }
    .table-striped tbody tr:nth-of-type(odd) {
        background-color: #f9f9f9; /* Alternating row background color */
    }
    .table th {
        background-color: #f5f5f5; /* Header background color */
        color: #333; /* Header text color */
        font-weight: bold; /* Bold header text */
        padding: 8px; /* Adjust padding for better spacing */
    }
    .table-striped > tbody > tr > td {
        background-color: #fff; /* Table cell background color */
    }
    .dropdown-menu {
        min-width: 100px; /* Set minimum width for dropdown menu */
    }
    .status-connect {
        color: #5cb85c; /* Green color for connected status */
    }
    .status-disconnect {
        color: #d9534f; /* Red color for disconnected status */
    }
    .dropdown-menu .btn {
    width: 70%; /* Menetapkan lebar penuh untuk tombol di dropdown */
    }
      /* Gaya untuk popup banner */
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
      padding: 20px;
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
      background-color: #f7f7f7;
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
</style>

<!-- Tambahkan ikon dan perbaikan lainnya pada HTML -->
<!-- Tabel PPPoE -->
<div class="container">
    <div class="row">
        <div class="col-sm-12 col-md-12">
            <!-- Form dan navigasi tabs -->
            <form class="form-horizontal" method="post" role="form" action="{$_url}plugin/pppoe_monitor_ui">
                <ul class="nav nav-tabs">
                    {foreach $routers as $r}
                    <li role="presentation" {if $r['id']==$router}class="active"{/if}>
                        <a href="{$_url}plugin/pppoe_monitor_ui/{$r['id']}">{$r['name']}</a>
                    </li>
                    {/foreach}
                </ul>
            </form>
            <!-- Panel untuk tabel PPPoE -->
            <div class="panel panel-default">
                <div class="panel-heading">PPPoE Monitor</div>
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
<!-- MODAL DETAILS -->
    <!-- Modal -->
<div id="detailsModal" class="modal">
  <div class="modal-content">
    <span class="close">&times;</span>
    <div class="container-fluid mt-5">
      <div class="card">
        <div class="card-header">
          <h5 class="modal-title">Details for <span id="modalUsername"></span></h5>
        </div>
        <div class="card-body">
          <div class="table-responsive mt-4">
            <table class="table table-bordered">
              <thead>
                <tr>
                <input type="hidden" id="interface" value="">
                <span id="selectedInterface" style="display:none;"></span>
                  <th id="tabletx"><strong>TX:</strong> 0 B</th>
                  <th id="tablerx"><strong>RX:</strong> 0 B</th>
                </tr>
              </thead>
            </table>
          </div>
          <div id="chart" class="mt-3"></div>
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
<!-- MODAL DETAILS END -->
<!-- Memuat jQuery terlebih dahulu -->
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/apexcharts"></script>
<!-- Kemudian memuat DataTables dan plugin terkait -->
<script src="https://cdn.datatables.net/1.11.3/js/jquery.dataTables.min.js"></script>
<script src="https://cdn.datatables.net/1.11.3/js/dataTables.bootstrap5.min.js"></script>

<script>

var $j = jQuery.noConflict();

$j(document).ready(function() {
    var table = $j('#ppp-table').DataTable({
        columns: [
            { data: 'id' }, // Kolom .id
            { data: 'username' },
            { data: 'address' },
            { data: 'uptime' },
            { data: 'service' },
            { data: 'caller_id' },
            { data: 'tx' },
            { data: 'rx' },
            { data: 'total' },
            {
                data: 'status',
                render: function(data, type, row) {
                    if (data === 'Connected') {
                        return '<small class="label bg-green">Connected</small>';
                    } else if (data === 'Disconnected') {
                        return '<small class="label bg-red">Disconnected</small>';
                    } else {
                        return ''; // Handle other cases if necessary
                    }
                }
            },
            {
                data: null,
                render: function(data, type, row) {
                    return '<div class="dropdown">' +
                                '<button class="btn btn-default dropdown-toggle btn-xs" type="button" data-toggle="dropdown">Action <span class="caret"></span></button>' +
                                '<ul class="dropdown-menu">' +
                                    '<button class="btn btn-warning btn-xs disconnect-button" data-username="' + row.username + '" data-id="' + row.id + '">Reconnect</button>' +
                                    '<button class="btn btn-info btn-xs view-details" data-username="' + row.username + '" data-id="' + row.id + '">Details</button>' +
                                '</ul>' +
                            '</div>';
                }
            }
        ],
        columnDefs: [
            {
                targets: 0,
                visible: false
            }
        ],
        order: [[0, 'asc']], // Default sorting by .id column
        pageLength: 10,
        lengthMenu: [[10, 25, 50, -1], [10, 25, 50, 'All']],
        dom: 'Bfrtip',
        buttons: [
           'reset',
            'pageLength'
        ],
        paging: true,
        searching: true,
        ordering: true,
        info: true,
        ajax: {
            url: '{$_url}plugin/pppoe_monitor_get_ppp_online_users/{$router}',
            dataSrc: '',
        }
    });

    // Handle disconnect button clicks
    $j('#ppp-table tbody').on('click', '.disconnect-button', function(e) {
        e.preventDefault(); // Prevent default action of anchor tag

        var username = $j(this).data('username');
        var id = $j(this).data('id'); // Ambil .id dari tombol

        if (confirm('Are you sure you want to disconnect user ' + username + '?')) {
            $j.ajax({
                url: '{$_url}plugin/pppoe_monitor_delete_ppp_user/{$router}',
                method: 'POST',
                data: { id: id, username: username },
                success: function(response) {
                    if (response.success) {
                        alert('User ' + username + ' has been disconnected.');
                        setTimeout(function() {
                            table.ajax.reload(); // Refresh table data
                        }, 2000); // Tunda pembaruan tabel selama 2 detik
                    } else {
                        alert('Failed to disconnect user ' + username + ': ' + response.message);
                    }
                },
                error: function(xhr, error, thrown) {
                    alert('Failed to disconnect user ' + username + '.');
                    console.log('AJAX error:', error);
                }
            });
        }
    });

});

var chart;
var chartData = {
  txData: [],
  rxData: []
};

$j(document).ready(function() {
    // Menampilkan modal saat tombol "Details" diklik
    $j('#ppp-table tbody').on('click', '.view-details', function(e) {
        e.preventDefault();
        var username = $j(this).data('username');
        var id = $j(this).data('id'); // Ambil .id dari tombol data: { id: id, username: username }

        // Mengisi modal dengan informasi yang sesuai
        $j('#modalUsername').text(username.toString());

        // Memuat data interface terkait untuk username yang dipilih
        $j.ajax({
            url: '{$_url}plugin/pppoe_monitor_get_ppp_online_users', // Sesuaikan dengan URL endpoint Anda
            method: 'GET',
            dataType: 'json',
            success: function(response) {
                if (response.length > 0) {
                    // Filter interfaces based on username
                    var user = response.find(function(item) {
                        return (item.username && item.username.toString().toLowerCase() === username.toString().toLowerCase());
                    });

                    if (username !== null && user !== null && user.username !== null) {
                        var interfaceValue = '<pppoe-' + user.username + '>';

                        // Menetapkan nilai interface pada elemen input tersembunyi
                        $j('#interface').val(interfaceValue.toString());

                        // Menampilkan nama interface pada span
                        $j('#selectedInterface').text(interfaceValue);

                        // Menampilkan modal
                        $j('#detailsModal').css('display', 'block');

                        // Memanggil createChart setelah modal ditampilkan untuk memastikan elemen #chart tersedia
                        createChart();
                    } else {
                        alert('User not found.');
                    }
                } else {
                    alert('Failed to retrieve user data.');
                }
            },
            error: function(xhr, error, thrown) {
                alert('Failed to retrieve user data.');
                console.log('AJAX error:', error);
            }
        });
    });

    // Menutup modal saat tombol close diklik
    $j('.close').click(function() {
        $j('#detailsModal').css('display', 'none');
    });

    // Menutup modal saat klik di luar area modal
    $j(window).click(function(event) {
        if (event.target == document.getElementById('detailsModal')) {
            $j('#detailsModal').css('display', 'none');
        }
    });
});


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
        mounted: function(chartContext, config) {
          // Initially load data and set up refresh interval
          updateTrafficValues();
          setInterval(updateTrafficValues, 3000);
        }
      }
    },
    stroke: {
      curve: 'smooth'
    },
    series: [{
      name: 'Upload',
      data: chartData.txData
    }, {
      name: 'Download',
      data: chartData.rxData
    }],
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
        text: 'Lalu Lintas Langsung'
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

function updateTrafficValues() {
    var username = $j('#modalUsername').text().trim(); // Get username from modal
    var interface = $j('#interface').val(); // Get selected interface

    if (!username || !interface) {
        console.error("Username or interface is undefined or empty.");
        return;
    }

    $j.ajax({
        url: '{$_url}plugin/pppoe_monitor_traffic/{$router}',
        dataType: 'json',
        data: {
            username: username,
            interface: interface // Include interface in data payload
        },
        success: function(data) {
            var timestamp = new Date().getTime();
            var txData = data.rows.tx;
            var rxData = data.rows.rx;
            if (txData.length > 0 && rxData.length > 0) {
                var TX = parseInt(txData[0]);
                var RX = parseInt(rxData[0]);
                chartData.txData.push({ x: timestamp, y: TX });
                chartData.rxData.push({ x: timestamp, y: RX });
                var maxDataPoints = 10;
                if (chartData.txData.length > maxDataPoints) {
                    chartData.txData.shift();
                    chartData.rxData.shift();
                }
                chart.updateSeries([{
                    name: 'Upload',
                    data: chartData.txData
                }, {
                    name: 'Download',
                    data: chartData.rxData
                }]);
                document.getElementById("tabletx").textContent = formatBytes(TX);
                document.getElementById("tablerx").textContent = formatBytes(RX);
            } else {
                document.getElementById("tabletx").textContent = "0";
                document.getElementById("tablerx").textContent = "0";
            }
        },
        error: function(XMLHttpRequest, textStatus, errorThrown) {
            console.error("Status: " + textStatus + " request: " + XMLHttpRequest);
            console.error("Error: " + errorThrown);
        }
    });
}
</script>
</script>
<script>
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
