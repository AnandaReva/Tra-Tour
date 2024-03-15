import 'dart:convert';
import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:http/http.dart' as http;
import 'package:tratour/globalVar.dart';

class UpdateUser {
  GlobalVar globalVar = GlobalVar.instance;

  String? profileImageUpdateUrl;

  Future<bool> uploadImageFirebaseStorage(File file) async {
    try {
      String? id = globalVar.userLoginData['id'].toString();
      String? path = id + "/assets/profileImage";
      final fileName = file.path.split("/").last;
      final timeStamp = DateTime.now().microsecondsSinceEpoch;
      final storageRef =
          FirebaseStorage.instance.ref("$path/$timeStamp-$fileName");

      await storageRef.putFile(file);

      profileImageUpdateUrl = await storageRef.getDownloadURL();

      print('path: $profileImageUpdateUrl');

      // Memanggil updateUserToDatabase setelah uploadImageFirebaseStorage selesai
      /*  await updateUserToDatabase(
        globalVar.userLoginData['username'],
        globalVar.userLoginData['phone'],
        globalVar.userLoginData['address'],
        globalVar.userLoginData['postal_code'],
        profileImageUpdateUrl!,
      ); */

      return true;
    } catch (e) {
      print('Error Upload Firebase Storage: $e');
      return false;
    }
  }

  Future<void> updateUserToDatabase(
    String userEmail,
    String username_update,
    String phone_update,
    String address_update,
    String postal_code_update,
    String? profileImageUpdateUrl,
  ) async {
    try {
      String url = 'https://tratour.000webhostapp.com/cobaUpdateUser.php';

      Map<String, dynamic> updatedUserdata = {
        'email': userEmail,
        'username': username_update,
        'phone': phone_update,
        'address': address_update,
        'postal_code': postal_code_update,
      };

      if (profileImageUpdateUrl != "" ) {
        updatedUserdata['profile_image'] = profileImageUpdateUrl;
      }

      print('check 1 udpdate: $updatedUserdata');

      String body = json.encode(updatedUserdata);

      print('check 2 udpdate: $body');

      final response = await http.post(
        Uri.parse(url),
        headers: <String, String>{
          'Content-Type': 'application/json',
        },
        body: body,
      );

      if (response.statusCode == 200) {
        // Only print success message after confirming successful update
        print('User Updated successfully.');

        // Update userLoginData after successful update

        globalVar.userLoginData['username'] = updatedUserdata['username'];
        globalVar.userLoginData['phone'] = updatedUserdata['phone'];
        globalVar.userLoginData['address'] = updatedUserdata['address'];
        globalVar.userLoginData['postal_code'] = updatedUserdata['postal_code'];

        if (profileImageUpdateUrl != null || profileImageUpdateUrl != "") {
            print('profileImageUpdateUrl tidak null: $profileImageUpdateUrl');
          globalVar.userLoginData['profile_image'] =
              updatedUserdata['profile_image'];
        }

        print('debug m3: $globalVar.userLoginData');
        print('Response Type: ${response.body.runtimeType}');

        // Print the response body which contains the echoed message from PHP
        print('PHP Response: ${response.body}');
      } else {
        print('Failed to update user: ${response.statusCode}');
        // Handle the error appropriately, e.g., notify the user or retry
      }
    } catch (e) {
      print('Error updating user: $e');
      // Provide a user-friendly error message or try to recover
    }
  }

  /* Future<void> updateUserToDatabase(
    String username_update,
    String phone_update,
    String address_update,
    String postal_code_update,
    String profileImageUpdateUrl,
  ) async {
    try {
      String url = 'https://tratour.000webhostapp.com/updateUser.php';

      Map<String, dynamic> updatedUserdata = {
        'username': username_update,
        'phone': phone_update,
        'address': address_update,
        'profile_image': profileImageUpdateUrl,
      };

      String body = json.encode(updatedUserdata);

      final response = await http.post(
        Uri.parse(url),
        headers: <String, String>{
          'Content-Type': 'application/json',
        },
        body: body,
      );

      if (response.statusCode == 200) {
        print('User Updated successfully.');

        // Update userLoginData setelah berhasil mengupdate pengguna
        globalVar.userLoginData = updatedUserdata;

        print('debug m3: $globalVar.userLoginData');
        print('Response Type: ${response.body.runtimeType}');
      } else {
        print('Failed to update user: ${response.statusCode}');
      }
    } catch (e) {
      print('Error updating user: $e');
    }
  } */
}
