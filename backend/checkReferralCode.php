<?php

// Menerima data referral_code dari body permintaan GET
$referral_code = $_GET['referral_code'];

$response = array();

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

// Membuat query untuk mencari referral_code pada tabel user
$sql = "SELECT * FROM user WHERE referral_code = '$referral_code'";
$result = $conn->query($sql);

if ($result->num_rows > 0) {
    // Mendapatkan hasil query dalam bentuk array asosiatif
    $data = $result->fetch_assoc();

    // Menyimpan data dalam array response
    $response['success'] = true;
    $response['message'] = "Referral code ditemukan";
    $response['data'] = $data;
} else {
    // Jika referral_code tidak ditemukan
    $response['success'] = false;
    $response['message'] = "Referral code tidak ditemukan";
}

// Mengirim respons dalam format JSON
header('Content-Type: application/json');
echo json_encode($response);

// Menutup koneksi database
$conn->close();

?>
