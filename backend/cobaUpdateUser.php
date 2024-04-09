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
    isset($input['username']) && // Menambahkan pengecekan untuk username
    isset($input['phone']) &&
    isset($input['address']) &&
    isset($input['postal_code'])
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
    $email = $input['email'];
    $new_username = $input['username']; // Menggunakan nama variabel yang berbeda
    $phone = $input['phone'];
    $address = $input['address'];
    $postal_code = $input['postal_code'];

    // Mendapatkan waktu sekarang
    $updated_at = date("Y-m-d H:i:s");

    // Inisialisasi variabel profile_image dengan NULL


    // Jika profile_image ada dalam data yang diterima, gunakan nilainya
    if (isset($input['profile_image']) && $input['profile_image'] !== "") {
        $profile_image = $input['profile_image'];
        $sql = "UPDATE user SET username='$new_username', phone='$phone', address='$address', postal_code='$postal_code', updated_at='$updated_at', profile_image='$profile_image' WHERE email='$email'";
        echo "Profile Image tidak kosong: ";
    } else {
        echo "Profile Image kosong: ";
        $sql = "UPDATE user SET username='$new_username', phone='$phone', address='$address', postal_code='$postal_code', updated_at='$updated_at' WHERE email='$email'";
    }



    // Query untuk melakukan update data


    if ($conn->query($sql) === TRUE) {
        echo "Data berhasil diperbarui";
    } else {
        echo "Error: " . $sql . "<br>" . $conn->error;
    }

    // Menutup koneksi
    $conn->close();
} else {
    // Jika data yang diterima tidak lengkap atau tidak sesuai
    echo "Data yang diterima tidak lengkap atau tidak sesuai";
}
