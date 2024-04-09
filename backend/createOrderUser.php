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
if (
    isset($input['email']) &&
    isset($input['phone']) &&

    isset($input['user_location']) &&
    isset($input['cost']) &&
    isset($input['status']) &&
    isset($input['user_id']) &&
    isset($input['referral_code'])
) {
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
    $username = $input['username'];
    $email = $input['email'];
    $phone = intval($input['phone']); // Mengonversi ke integer
    $password = $input['password'];
    $user_point = intval($input['user_point']); // Mengonversi ke integer
    $user_type = intval($input['user_type']); // Mengonversi ke integer
    $referral_code = $input['referral_code'];
    $profile_image = $input['profile_image']; // Anda dapat menyesuaikan ini jika perlu
    $address = $input['address'];
    $postal_code = $input['postal_code'];
    //
    $created_at = date("Y-m-d H:i:s");
    $updated_at = date("Y-m-d H:i:s");

    // Query untuk melakukan insert data
    //$sql = "INSERT INTO user (username, email, phone, password, user_point, user_type, referral_code, profile_image)
    // VALUES ('$username', '$email', $phone, '$password', $user_point, $user_type, '$referral_code', '$profile_image';
    $sql = "INSERT INTO user (username, email, phone, password, user_point, user_type, referral_code, profile_image, address, postal_code , created_at, updated_at)
    VALUES ('$username', '$email', $phone, '$password', $user_point, $user_type, '$referral_code', NULL , NULL , NULL , '$created_at', '$updated_at')";
    if ($conn->query($sql) === TRUE) {
        echo "Data baru berhasil ditambahkan";
    } else {
        echo "Error: " . $sql . "<br>" . $conn->error;
    }

    // Menutup koneksi
    $conn->close();
} else {
    // Jika data yang diterima tidak lengkap atau tidak sesuai
    echo "Data yang diterima tidak lengkap atau tidak sesuai";
}
