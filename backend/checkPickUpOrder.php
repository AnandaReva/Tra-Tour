<?php

if(isset($_GET['order_id'])){
    $order_id = $_GET['order_id'];

    $servername = "localhost";
    $username = "id21953977_anandareva";
    $password = "Empatlimaenam456!";
    $database = "id21953977_tratour";

    $conn = new mysqli($servername, $username, $password, $database);

    if ($conn->connect_error) {
        die("Koneksi gagal: " . $conn->connect_error);
    }

    $response = array();

    $sql = "SELECT pickup_id FROM orders WHERE id = $order_id AND pickup_id IS NOT NULL";
    $result = $conn->query($sql);

    if ($result->num_rows > 0) {
        $response['status'] = 'success';
        $response['data'] = $result->fetch_assoc();
    
        $pickup_id = $response['data']['pickup_id'];

        if (!empty($pickup_id)) {
            $sql_pickup = "SELECT * FROM pickup WHERE id = '$pickup_id'";
            $result_pickup = $conn->query($sql_pickup);
            
            if ($result_pickup->num_rows > 0) {
                $pickup_data = $result_pickup->fetch_assoc();
                $response['pickup_data'] = $pickup_data;
                
                // Mengambil data sweeper dari tabel user
                $pickuper_id = $pickup_data['pickuper_id']; // Perbaikan disini
                $sql_pickuper_data = "SELECT * FROM user WHERE id = '$pickuper_id'";
                $result_pickuper_data = $conn->query($sql_pickuper_data);

                if ($result_pickuper_data->num_rows > 0) {
                    $sweeper_data = $result_pickuper_data->fetch_assoc();
                    $response['sweeper_data'] = $sweeper_data; // Ubah nama variabel menjadi sweeper_data

                    // Cek pembaruan order
                    $sql_order_data_update = "SELECT * FROM orders WHERE id = $order_id ";
                    $result_order_data_update = $conn->query($sql_order_data_update);
                    
                    if ($result_order_data_update->num_rows > 0) {
                        $order_data_update = $result_order_data_update->fetch_assoc();
                        $response['order_data_update'] = $order_data_update;
                    } else {
                        $response['status'] = 'failed';
                        $response['message'] = 'Data order tidak ditemukan';
                    }
                } else {
                    $response['status'] = 'failed';
                    $response['message'] = 'Data pickuper tidak ditemukan';
                }
            } else {
                $response['status'] = 'failed';
                $response['message'] = 'Data pickup tidak ditemukan';
            }
        } else {
            $response['status'] = 'failed';
            $response['message'] = 'Pickup ID kosong';
        }
    } else {
        $response['status'] = 'failed';
        $response['message'] = 'Pickup ID is NULL';
    }

    header('Content-Type: application/json');
    echo json_encode($response);

    $conn->close();
} else {
    $response['status'] = 'failed';
    $response['message'] = 'Order ID is not defined';
    echo json_encode($response);
}

?>
