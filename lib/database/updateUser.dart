import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:tratour/globalVar.dart';

class UpdateUser {
  Future<void> updateUserToDatabase(
    String username_update,
    String phone_update,
    String address_update,
    String postal_code_update,
    String profile_image_update,
  ) async {
    try {
      String url = 'https://tratour.000webhostapp.com/updateUser.php';

      Map<String, dynamic> updatedUserdata = {
        'username': username_update,
        'phone': phone_update,
        'address': address_update,
        'profile_image': profile_image_update,
      };

      String body = json.encode(updatedUserdata);

      print('debug 5: $updatedUserdata ');

      final response = await http.post(
        Uri.parse(url),
        headers: <String, String>{
          'Content-Type': 'application/json',
        },
        body: body,
      );

      if (response.statusCode == 200) {
        print('User Updated successfully.');

        // Memperbarui userLoginData setelah menambahkan pengguna baru
        GlobalVar globalVar = GlobalVar.instance;

        globalVar.userLoginData = updatedUserdata;

        print('debig m3: $globalVar.userLoginData');

        // Cetak tipe data respons
        print('Response Type: ${response.body.runtimeType}');
      } else {
        print('Failed to update user: ${response.statusCode}');
        // Lakukan sesuatu jika gagal menambahkan pengguna
      }
    } catch (e) {
      print('Error updating user: $e');
      // Lakukan sesuatu jika terjadi kesalahan
    }
  }
}
