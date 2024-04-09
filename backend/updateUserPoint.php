<?php
$inputJSON = file_get_contents('php://input');
echo "Received data: " . $inputJSON; // Cetak data yang diterima

// Memeriksa apakah data yang diterima adalah JSON
if (strpos($inputJSON, '{') === 0) {
    $input = json_decode($inputJSON, TRUE);
} else {
    // Jika bukan JSON, lakukan dekode sebagai x-www-form-urlencoded
    parse_str($inputJSON, $input);
}

// Tambahkan kode untuk mencetak nilai-nilai dari $input di sini
print_r($input);

// Memeriksa apakah data yang diterima sesuai dengan yang diharapkan
if (isset($input['id']) && isset($input['user_point'])) {
    // Koneksi ke database
    $servername = "localhost";
    $username = "id21953977_anandareva";
    $password = "Empatlimaenam456!";
    $database = "id21953977_tratour";

    // Membuat koneksi
    $conn = new mysqli($servername, $username, $password, $database);

    // Memeriksa koneksi
    if ($conn->connect_error) {
        die("Koneksi gagal: " . $conn->connect_error);
    }

    // Mendapatkan data dari permintaan POST
    $id = $input['id']; 
    $user_point = $input['user_point'];

    // Mendapatkan waktu sekarang
    $updated_at = date("Y-m-d H:i:s");

    // Query untuk melakukan update data
    $sql = "UPDATE user SET user_point='$user_point', updated_at='$updated_at' WHERE id='$id'";

    if ($conn->query($sql) === TRUE) {
        echo "Data berhasil diperbarui";
    } else {
        echo "Error: " . $sql . "<br>" . $conn->error;
    }

    // Menutup koneksi
    $conn->close();
} else {
    // Jika data yang diterima tidak lengkap atau tidak sesuai
    echo "Data yang diterima tidak lengkap atau tidak sesuai. Pastikan parameter 'id' dan 'user_point' tersedia.";
}
?>
