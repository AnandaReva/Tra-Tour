<?php

// Ambil ID dari input POST
$order_id = $_POST['order_id'];

// Koneksi ke database
$servername = "localhost";
$username = "id21953977_anandareva";
$password = "Empatlimaenam456!";
$database = "id21953977_tratour";

// Membuat koneksi
$conn = new mysqli($servername, $username, $password, $database);

// Mengecek koneksi
if ($conn->connect_error) {
    die("Koneksi gagal: " . $conn->connect_error);
}

// Membuat query untuk memeriksa pickup_id
$sql = "SELECT pickup_id FROM orders WHERE id = $order_id AND pickup_id IS NOT NULL";
$result = $conn->query($sql);

$response = array();

if ($result->num_rows > 0) {
    // Jika pickup_id tidak null, kembalikan status success
    $response['status'] = 'success';
    $response['data'] = $result->fetch_assoc();
} else {
    // Jika pickup_id null, kembalikan status failed
    $response['status'] = 'failed';
    $response['message'] = 'Pickup ID is NULL';
}

// Mengirim respons dalam format JSON
header('Content-Type: application/json');
echo json_encode($response);

// Menutup koneksi database
$conn->close();

?>
