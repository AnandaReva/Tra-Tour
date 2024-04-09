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
      String? email = globalVar.userLoginData['email'].toString();
      String? path = "users/$email/assets/images/profile_images";
      final fileName = file.path.split("/").last;
      final timeStamp = DateTime.now().microsecondsSinceEpoch;
      final storageRef =
          FirebaseStorage.instance.ref("$path/$timeStamp-$fileName");

      await storageRef.putFile(file);

      profileImageUpdateUrl = await storageRef.getDownloadURL();

      print('path: $profileImageUpdateUrl');

      //setelah upload hapus yang lama
      if (globalVar.userLoginData['profile_image'] != null) {
        await deletePastImageFromFirebaseStorage();
      }

      return true;
    } catch (e) {
      print('Error Upload Firebase Storage: $e');
      return false;
    }
  }

  Future<bool> deletePastImageFromFirebaseStorage() async {
    try {
      String? currentProfileUrl =
          globalVar.userLoginData['profile_image'].toString();
      // Get reference to the image file
      Reference ref = FirebaseStorage.instance.refFromURL(currentProfileUrl);

      // Delete the file
      await ref.delete();

      print('Image deleted successfully');
      return true;
    } catch (e) {
      print('Error deleting image from Firebase Storage: $e');
      return false;
    }
  }

  Future<void> updateUserToDatabase(
      String userEmail,
      String username_update,
      String phone_update,
      String address_update,
      String postal_code_update,
      String? profileImageUpdateUrl) async {
    try {
      String url = 'https://tratour.000webhostapp.com/updateUser.php';

      Map<String, dynamic> updatedUserdata = {
        'email': userEmail,
        'username': username_update,
        'phone': phone_update,
        'address': address_update,
        'postal_code': postal_code_update,
      };

      print('check 1 udpdate: $updatedUserdata');
      print('check 1A udpdate: ${globalVar.userLoginData['username']}');
      print('check 1B: $profileImageUpdateUrl');

      if (profileImageUpdateUrl != null) {
        updatedUserdata['profile_image'] = profileImageUpdateUrl;
        print('check 2 udpdate: $updatedUserdata');
      }

      String body = json.encode(updatedUserdata);

      print('check 3 udpdate: $body');

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

        if (profileImageUpdateUrl != null) {
          print('profileImageUpdateUrl tidak null: $profileImageUpdateUrl');
          globalVar.userLoginData['profile_image'] =
              updatedUserdata['profile_image'];

          print('check 4A: $globalVar.userLoginData');
        }

        print('check 4: $globalVar.userLoginData');
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
}
