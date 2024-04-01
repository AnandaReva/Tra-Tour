<?php

// Menerima data dari body permintaan GET
$email = $_GET['email'];

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

// Membuat query untuk mengambil data user berdasarkan email
$sql = "SELECT * FROM user WHERE email = '$email'";
$result = $conn->query($sql);

$response = array();

if ($result->num_rows > 0) {
    // Mendapatkan hasil query dalam bentuk array asosiatif
    $data = $result->fetch_assoc();

    // Menyimpan data dalam array response
    $response['data'] = $data;
} else {
    // Jika tidak ada data yang ditemukan
    $response['success'] = false;
    $response['message'] = "Data tidak ditemukan";
}

// Mengirim respons dalam format JSON
header('Content-Type: application/json');
echo json_encode($response);

// Menutup koneksi database
$conn->close();

?>
