import 'dart:convert';

import 'package:tratour/globalVar.dart';
import 'package:http/http.dart' as http;

class Order {
  GlobalVar globalVar = GlobalVar.instance;



  Future<void> addOrderToDatabase(
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
      } else {
        print('Failed to create order 1: ${response.body}');
      }
    } catch (e) {
      // Tangani kesalahan yang terjadi selama proses HTTP request
      print('Error adding order: $e');
      // Lakukan sesuatu jika terjadi kesalahan
    }
  }


/*   Future<void> findSweeper(
    String order_id,

  ) async {
    try {
      String url = 'https://tratour.000webhostapp.com/findSweeper.php';

      Map<String, dynamic> newOrderData = {
        'user_id': user_id,
     
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
      } else {
        print('Failed to create order 1: ${response.body}');
      }
    } catch (e) {
      // Tangani kesalahan yang terjadi selama proses HTTP request
      print('Error adding order: $e');
      // Lakukan sesuatu jika terjadi kesalahan
    }
  } */
}
