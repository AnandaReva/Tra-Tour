<?php
// Koneksi ke database
$servername = "localhost";
$username = "id21953977_anandareva";
$password = "Empatlimaenam456!";
$database = "id21953977_tratour"; // Anda menggunakan variabel ini untuk koneksi ke database

// Buat koneksi
$conn = new mysqli($servername, $username, $password, $database);

// Periksa koneksi
if ($conn->connect_error) {
  die("Koneksi gagal: " . $conn->connect_error);
}

// Ambil nilai order_id dari body request
$order_id = $_POST['order_id'];

// Buat dan jalankan query SQL untuk mengupdate status pesanan
$sql = "UPDATE orders SET status = 'updated' WHERE id = '$order_id'";

if ($conn->query($sql) === TRUE) {
  $response = array("status" => "success", "message" => "Berhasil update data order");
  echo json_encode($response);
} else {
  $response = array("status" => "error", "message" => "Gagal update data order: " . $conn->error);
  echo json_encode($response);
}

// Tutup koneksi
$conn->close();
?>
