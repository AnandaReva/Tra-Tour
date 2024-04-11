<?php


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

// Membuat query untuk memilih 10 data dengan status 'open' yang diurutkan berdasarkan updated_at secara descending
$sql = "SELECT * FROM orders WHERE status = 'open' ORDER BY updated_at DESC LIMIT 10";
$result = $conn->query($sql);

$response = array();

if ($result->num_rows > 0) {
    // Mendapatkan hasil query dalam bentuk array asosiatif
    $data = array();
    while ($row = $result->fetch_assoc()) {
        $data[] = $row;
    }

    // Menyimpan data dalam array response
    $response['success'] = true;
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
