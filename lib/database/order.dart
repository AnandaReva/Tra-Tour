import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:tratour/globalVar.dart';
import 'package:http/http.dart' as http;
import 'package:tratour/pages/orderProcess.dart';

class Order {
  GlobalVar globalVar = GlobalVar.instance;

  Future<bool> addOrderToDatabase(
    String user_id,
    String pickup_id,
    String waste_types,
    String user_coordinate,
    String sweeper_coordinate,
    String address,
    String cost,
    String payment_method,
    String formattedDate,
    String initial_status,
    BuildContext context,
  ) async {
    try {
      String url = 'https://tratour.000webhostapp.com/createOrder.php';

      Map<String, dynamic> newOrderData = {
        'user_id': user_id,
        'pickup_id': pickup_id,
        'waste_types': waste_types,
        'user_coordinate': user_coordinate,
        'sweeper_coordinate': sweeper_coordinate,
        'address': address,
        'cost': cost,
        'payment_method': payment_method,
        'created_at': formattedDate,
        'updated_at': formattedDate,
        'status': initial_status,
      };

      String body = json.encode(newOrderData);

      final response = await http.post(
        Uri.parse(url),
        headers: <String, String>{
          'Content-Type': 'application/json',
        },
        body: body,
      );

      print('Data sent: $body');
      final responseData = json.decode(response.body);
      if (response.statusCode == 200 && responseData['status'] == 'success') {
        print('New order added successfully.');
        GlobalVar globalVar = GlobalVar.instance;
        globalVar.orderData = newOrderData;
        print('Response Message: ${responseData['message']}');

        // Return true to indicate success
        return true;
      } else {
        print('Failed to create order: ${response.body}');
        print('Response Message: ${responseData['message']}');

        // Return false to indicate failure
        return false;
      }
    } catch (e) {
      // Tangani kesalahan yang terjadi selama proses HTTP request
      print('Error adding order: $e');
      // Lakukan sesuatu jika terjadi kesalahan

      // Return false to indicate failure
      return false;
    }
  }

/*   Future<void> findSweeperFromDB(
    String email,
  ) async {
    String url = 'https://tratour.000webhostapp.com/findUser.php?email=$email';

    try {
      // Melakukan HTTP GET request
      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        // Berhasil mendapatkan respon dari server
        GlobalVar globalVar = GlobalVar.instance;
        Map<String, dynamic> data = json.decode(response.body);

        // Memperbarui userLoginData dengan data yang diperoleh
        globalVar.userLoginData = data['data'];

        // Set isLogin menjadi true
        globalVar.isLogin = true;
      } else {
        if (globalVar.isLoading == true) {
          setState(() {
            globalVar.isLoading = false; // Menampilkan animasi loading
          });
        }

        // Gagal mendapatkan respon dari server
        print('Failed to load data: ${response.statusCode}');
      }
    } catch (e) {
      // Terjadi kesalahan saat melakukan permintaan HTTP
      print('Error Find: $e');
    }
  } */
}
