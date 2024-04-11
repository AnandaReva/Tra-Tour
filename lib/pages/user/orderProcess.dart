import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:provider/provider.dart';
import 'package:tratour/main.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:tratour/globalVar.dart';

import 'package:tratour/database/order.dart';
import 'package:http/http.dart' as http;

String errorMessage = "";

class OrderProcess extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => GlobalVar.instance,
      child: OrderProcessContent(),
    );
  }
}

class OrderProcessContent extends StatefulWidget {
  @override
  _OrderProcessContentState createState() => _OrderProcessContentState();
}

class _OrderProcessContentState extends State<OrderProcessContent> {
  String _distanceText = '';
  // Fungsi untuk mendapatkan nama tipe sampah
  String _getWasteTypeName(int wasteType) {
    switch (wasteType) {
      case 0:
        return 'Plastik';
      case 1:
        return 'Limbah Rumah Tangga';
      case 2:
        return 'Minyak';
      case 3:
        return 'Kardus dan Kertas';
      case 4:
        return 'Limbah Elektronik';
      case 5:
        return 'Pakaian';
      default:
        return 'Tidak Diketahui';
    }
  }

  

  Order order = Order();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance!.addPostFrameCallback((_) {
      // Panggil calculateDistance di sini
      calculateDistance(context);
    });

    checkAndHandlePickupOrder(context);
  }

  

  @override
  Widget build(BuildContext context) {
    return Consumer<GlobalVar>(
      builder: (context, globalVar, _) {
        // Ambil data dari globalVar
        Map<String, dynamic> currentOrderData =
            globalVar.currentOrderData ?? {};
        Map<String, dynamic> currentPickUpData =
            globalVar.currentPickUpData ?? {};
        Map<String, dynamic> currentSweeperData =
            globalVar.currentSweeperData ?? {};
          
        

        /*    return Scaffold(
          appBar: AppBar(
            title: const Text(
              'Sweeper Ditemukan',
              style: TextStyle(fontSize: 18),
            ),
            automaticallyImplyLeading: false,
            actions: [
              IconButton(
                onPressed: () {
                  // Logika refresh di sini
                },add
                icon: Icon(Icons.refresh),
              ),
            ],
          ),
          body: SingleChildScrollView(
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'Order Data:',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  Text('ID: ${currentOrderData['id'] ?? ''}'),
                  Text('User ID: ${currentOrderData['user_id'] ?? ''}'),
                  Text('Pickup ID: ${currentOrderData['pickup_id'] ?? ''}'),
                  Text('Waste Types: ${currentOrderData['waste_types'] ?? ''}'),
                  Text(
                      'User Coordinate: ${currentOrderData['user_coordinate'] ?? ''}'),
                  Text(
                      'Sweeper Coordinate: ${currentOrderData['sweeper_coordinate'] ?? ''}'),
                  Text('Address: ${currentOrderData['address'] ?? ''}'),
                  Text('Cost: ${currentOrderData['cost'] ?? ''}'),
                  Text(
                      'Payment Method: ${currentOrderData['payment_method'] ?? ''}'),
                  Text('Created At: ${currentOrderData['created_at'] ?? ''}'),
                  Text('Updated At: ${currentOrderData['updated_at'] ?? ''}'),
                  Text('Status: ${currentOrderData['status'] ?? ''}'),
                  // Tampilkan data dari pickup_data
                  const Text(
                    'Pickup Data:',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  Text('ID: ${currentPickUpData['id'] ?? ''}'),
                  Text('Order ID: ${currentPickUpData['order_id'] ?? ''}'),
                  Text(
                      'Pickuper ID: ${currentPickUpData['pickuper_id'] ?? ''}'),
                  Text('Reward: ${currentPickUpData['reward'] ?? ''}'),
                  // Tampilkan data dari sweeper_data
                  const Text(
                    'Sweeper Data:',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  Text('ID: ${currentSweeperData['id'] ?? ''}'),
                  Text('Username: ${currentSweeperData['username'] ?? ''}'),
                  Text('Email: ${currentSweeperData['email'] ?? ''}'),
                  Text('Phone: ${currentSweeperData['phone'] ?? ''}'),
                  Text('User Type: ${currentSweeperData['user_type'] ?? ''}'),
                  const Text(
                    'Jarak:',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  Text('Distance: $_distanceText meters'), // Memperbaiki ini

                  CircleAvatar(
                    radius: 42,
                    backgroundImage: NetworkImage(
                      currentSweeperData != null
                          ? currentSweeperData['profile_image'] ??
                              'https://firebasestorage.googleapis.com/v0/b/tra-tour.appspot.com/o/default_profile_image.png?alt=media&token=83bb623d-473f-4c5e-93c3-ecc3fc5f915b'
                          : 'https://firebasestorage.googleapis.com/v0/b/tra-tour.appspot.com/o/default_profile_image.png?alt=media&token=83bb623d-473f-4c5e-93c3-ecc3fc5f915b',
                    ),
                  ),

                  SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () {
                      _openRouteGoogleMaps(context,
                          currentOrderData); // Menambah parameter currentOrderData
                    },
                    child: const Text('Lihat Posisi Sweeper'),
                  ),
                  SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () async {
                      // Memperbaiki pemanggilan showDialog
                      _showCancelOrderDialog(
                          context, globalVar, currentOrderData);
                    },
                    child: Text('Batal'),
                  ),
                ],
              ),
            ),
          ),
        ); */

        return Scaffold(
          appBar: AppBar(
            backgroundColor: GlobalVar.mainColor,
            title: Text(
              'Pilih Lokasi Penjemputan',
              style: TextStyle(
                fontSize: 18,
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
            automaticallyImplyLeading: false,
            actions: [
              IconButton(
                onPressed: () {
                  // Logic to refresh here
                },
                icon: Icon(Icons.refresh),
              ),
            ],
          ),
          body: SingleChildScrollView(
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                SizedBox(height: 20),

             
               _buildOrderDataRowWasteTypes('Waste Types', currentOrderData['waste_types']),
                _buildOrderDataRow(
                    'Address', currentOrderData['address'] ?? ''),
                _buildOrderDataRow('Cost', currentOrderData['cost'] ?? ''),
                _buildOrderDataRowpayment(
                    'Payment Method', currentOrderData['payment_method'] ?? ''),
                SizedBox(height: 20),
                _buildDivider(),
                SizedBox(height: 20),
                _buildPickupDataRow(
                    'Reward', currentPickUpData['reward'] ?? ''),
                SizedBox(height: 20),
                _buildDivider(),
                SizedBox(height: 20),
                _buildSweeperDataRow(
                    'Username', currentSweeperData['username'] ?? ''),
                SizedBox(height: 20),
                _buildDivider(),
                SizedBox(height: 20),
                _buildDistanceRow('Distance', _distanceText),
                SizedBox(height: 20),
                CircleAvatar(
                  radius: 42,
                  backgroundImage: NetworkImage(
                    currentSweeperData != null
                        ? currentSweeperData['profile_image'] ??
                             'https://firebasestorage.googleapis.com/v0/b/tra-tour.appspot.com/o/default_profile_image.png?alt=media&token=83bb623d-473f-4c5e-93c3-ecc3fc5f915b'
                        :   'https://firebasestorage.googleapis.com/v0/b/tra-tour.appspot.com/o/default_profile_image.png?alt=media&token=83bb623d-473f-4c5e-93c3-ecc3fc5f915b'
                  ),
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    _openRouteGoogleMaps(context, currentOrderData);
                  },
                  child: Text('Lihat Posisi Sweeper'),
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () async {
                    _showCancelOrderDialog(
                        context, globalVar, currentOrderData);
                  },
                  child: Text('Batal'),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

Widget _buildOrderDataRowpayment(String label, String value) {
  if (label == 'Payment Method') {
    String paymentMethodText = '';
    switch (value) {
      case '1':
        paymentMethodText = 'Tunai';
        break;
      // Tambahkan percabangan lain jika ada metode pembayaran lain
      default:
        paymentMethodText = 'Metode Pembayaran Lainnya';
        break;
    }
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          flex: 2,
          child: Text(
            label,
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
        ),
        Expanded(
          flex: 3,
          child: Text(paymentMethodText),
        ),
      ],
    );
  } else {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          flex: 2,
          child: Text(
            label,
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
        ),
        Expanded(
          flex: 3,
          child: Text(value),
        ),
      ],
    );
  }
}


 Widget _buildOrderDataRow(String label, String value) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          flex: 2,
          child: Text(
            label,
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
        ),
        Expanded(
          flex: 3,
          child: Text(value),
        ),
      ],
    );
  }
  Widget _buildOrderDataRowWasteTypes(String label, String wasteType) {
  List<String> wasteTypes = wasteType.split(',');

  List<String> wasteTypeNames = wasteTypes.map((type) {
    int index = int.tryParse(type.trim()) ?? -1;
    return _getWasteTypeName(index);
  }).toList();

  return Row(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Expanded(
        flex: 2,
        child: Text(
          label,
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
      ),
      Expanded(
        flex: 3,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: wasteTypeNames
              .map((name) => Text(name))
              .toList(), // Menampilkan nama tipe sampah dalam list
        ),
      ),
    ],
  );
}




  Widget _buildPickupDataRow(String label, String value) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          flex: 2,
          child: Text(
            label,
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
        ),
        Expanded(
          flex: 3,
          child: Text(value),
        ),
      ],
    );
  }

  Widget _buildSweeperDataRow(String label, String value) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          flex: 2,
          child: Text(
            label,
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
        ),
        Expanded(
          flex: 3,
          child: Text(value),
        ),
      ],
    );
  }

  Widget _buildDistanceRow(String label, String value) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          flex: 2,
          child: Text(
            label,
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
        ),
        Expanded(
          flex: 3,
          child: Text(value + ' meters'),
        ),
      ],
    );
  }

  Widget _buildDivider() {
    return Divider(
      color: Colors.grey,
      thickness: 1,
      height: 20,
    );
  }

  Future<void> _openRouteGoogleMaps(
      BuildContext context, Map<String, dynamic> currentOrderData) async {
    GlobalVar globalVar = GlobalVar.instance;
    print(
        'coordinate sweeper ${globalVar.currentOrderData['sweeper_coordinate']}');
    print('coordinate user ${globalVar.currentOrderData['user_coordinate']}');

    String? sweeperCoordinate =
        globalVar.currentOrderData['sweeper_coordinate'];
    String? userCoordinate = globalVar.currentOrderData['user_coordinate'];

    if ((sweeperCoordinate != null && sweeperCoordinate.isNotEmpty) &&
        (userCoordinate != null && userCoordinate.isNotEmpty)) {
      List<String> sweeperCoordinates = sweeperCoordinate.split(',');
      List<String> userCoordinates = userCoordinate.split(',');

      double sweeperLatitude = double.parse(sweeperCoordinates[0]);
      double sweeperLongitude = double.parse(sweeperCoordinates[1]);

      double userLatitude = double.parse(userCoordinates[0]);
      double userLongitude = double.parse(userCoordinates[1]);
      final Uri googleMapsUrl = Uri.parse(
          'https://www.google.com/maps/dir/?api=1&origin=$userLatitude,$userLongitude&destination=$sweeperLatitude,$sweeperLongitude');

      if (await launchUrl(googleMapsUrl)) {
        await launchUrl(googleMapsUrl);
      } else {
        throw 'Could not open Google Maps';
      }
    } else {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Error'),
            content: Text('Sweeper coordinate or user coordinate is missing.'),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop(); // Close dialog
                },
                child: Text('OK'),
              ),
            ],
          );
        },
      );
    }
  }

  Future<void> calculateDistance(BuildContext context) async {
    GlobalVar globalVar = GlobalVar.instance;

    String? sweeperCoordinate =
        globalVar.currentOrderData['sweeper_coordinate'];
    String? userCoordinate = globalVar.currentOrderData['user_coordinate'];

    if (sweeperCoordinate != null &&
        sweeperCoordinate.isNotEmpty &&
        userCoordinate != null &&
        userCoordinate.isNotEmpty) {
      List<String> sweeperCoordinates = sweeperCoordinate.split(',');
      List<String> userCoordinates = userCoordinate.split(',');

      double sweeperLatitude = double.parse(sweeperCoordinates[0]);
      double sweeperLongitude = double.parse(sweeperCoordinates[1]);
      double userLatitude = double.parse(userCoordinates[0]);
      double userLongitude = double.parse(userCoordinates[1]);

      double distanceInMeters = await Geolocator.distanceBetween(
          userLatitude, userLongitude, sweeperLatitude, sweeperLongitude);

      setState(() {
        _distanceText =
            '$distanceInMeters'; // Update with your preferred format
      });

      print('distance: $distanceInMeters ');
      double distanceInKm = distanceInMeters / 1000;
      print('Distance: $distanceInKm km');
    } else {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Error'),
            content: Text('Terjadi Kesalahan, mohon refresh.'),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop(); // Close dialog
                },
                child: Text('OK'),
              ),
            ],
          );
        },
      );
    }
  }

  Future<void> _showCancelOrderDialog(BuildContext context, GlobalVar globalVar,
      Map<String, dynamic> currentOrderData) async {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Batal Pesanan'),
          content: Text('Apakah Anda yakin ingin membatalkan pesanan ini?'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close dialog
              },
              child: Text('Tidak'),
            ),
            TextButton(
              onPressed: () async {
                // Memanggil cancelOrderFromDB di sini
                bool success = await order.cancelOrderFromDB(
                    currentOrderData['id'], 'cancelled');
                if (success) {
                  Navigator.of(context).pop(); // Close dialog
                  // Jika pembatalan pesanan berhasil, lakukan tindakan tambahan di sini
                } else {
                  Navigator.of(context).pop(); // Close dialog
                  // Jika pembatalan pesanan gagal, tampilkan Snackbar
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Gagal membatalkan pesanan'),
                      duration: Duration(seconds: 2),
                    ),
                  );
                }
              },
              child: Text('Ya'),
            ),
          ],
        );
      },
    );
  }

  Future<void> checkAndHandlePickupOrder(BuildContext context) async {
    while (true) {
      GlobalVar globalVar = GlobalVar.instance;
      String orderId = globalVar.currentOrderData['id'];

      Order order = Order();
      bool pickupOrderResult = await order.checkPickUpOrder(orderId);

      if (pickupOrderResult) {
        // Pickup order found, check the status
        if (globalVar.currentOrderData['status'] == 'cancelled' ||
            globalVar.currentOrderData['status'] == 'completed') {
          print('Pickup status change.');

          // Navigates to the OrderResult screen
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => OrderResult()),
          );
          break; // Break out of the loop
        }
      } else {
        // Pickup order not found, handle failure
        print('Failed to find pickup order.');

        // Show dialog and continue loop
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text('Error'),
              content: Text(
                  'Tidak bisa memperbarui data, periksa koneksi internet.'),
              actions: <Widget>[
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop(); // Close dialog
                  },
                  child: Text('OK'),
                ),
              ],
            );
          },
        );
      }

      await Future.delayed(Duration(seconds: 9));
    }
  }

// Call the function to start checking the pickup order status
}

class OrderResult extends StatelessWidget {
  GlobalVar globalVar = GlobalVar.instance;

  OrderResult({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white, // Set background color to white
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (globalVar.currentOrderData['status'] == 'cancelled')
              Column(
                children: [
                  // Gambar logo for cancelled order
                  Image.asset(
                    'assets/images/orderCancelled.png',
                    width: 200,
                    height: 200,
                  ),
                  SizedBox(height: 20), // Spasi antara logo dan tombol
                ],
              ),
            if (globalVar.currentOrderData['status'] == 'completed')
              Column(
                children: [
                  // Gambar logo for completed order
                  Image.asset(
                    'assets/images/orderCompleted.png',
                    width: 200,
                    height: 200,
                  ),
                  SizedBox(height: 20), // Spasi antara logo dan tombol
                ],
              ),
            ElevatedButton(
              onPressed: () {
                // Close the current screen
                Navigator.of(context).pop();

                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(
                    builder: (context) => MainPage(),
                  ),
                  (route) => false,
                );
              },
              child: Text('Tutup'),
            ),
          ],
        ),
      ),
    );
  }
}
