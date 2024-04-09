import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:tratour/globalVar.dart';

/* // ignore: must_be_immutable
class OrderProcess extends StatelessWidget {
  GlobalVar globalVar = GlobalVar.instance;
  late Map<String, dynamic>
      currentOrderData; // Menyimpan currentOrderData sebagai variabel kelas

  OrderProcess({Key? key, required GlobalVar globalVar}) : super(key: key) {
    // Inisialisasi currentOrderData
    currentOrderData = {
      'id': '51',
      'user_id': '64',
      'pickup_id': '1',
      'waste_types': '0,1,2,5',
      'user_coordinate': '-6.2126044,106.8688975',
      'sweeper_coordinate': '-6.175392,106.827153',
      'address': 'Jalan Kemana saja',
      'cost': '30000',
      'payment_method': '1',
      'created_at': '2024-04-09 00:00:00',
      'updated_at': '2024-04-09 00:00:00',
      'status': 'inprogress'
    };
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text('Konfirmasi'),
              content: Text('Apakah Anda yakin ingin membatalkan pesanan?'),
              actions: <Widget>[
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop(false); // Tutup dialog
                  },
                  child: Text('Tidak'),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop(true); // Tutup dialog
                    Navigator.of(context)
                        .pop(); // Kembali ke halaman sebelumnya
                  },
                  child: Text('Ya'),
                ),
              ],
            );
          },
        );
        return false; // Tidak membiarkan pengguna keluar dari halaman
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            'Sweeper Ditemukan',
            style: TextStyle(fontSize: 18), // Atur ukuran font di sini
          ),
          automaticallyImplyLeading: false, // Tambahkan baris ini
          actions: [
            IconButton(
              onPressed: () {
                // Tambahkan logika refresh di sini
                // Anda dapat menambahkan kode untuk memperbarui data atau melakukan tindakan lain saat tombol refresh ditekan
              },
              icon: Icon(Icons.refresh),
            ),
          ],
        ),
        body: SingleChildScrollView(
          child: Center(
            child: Consumer<GlobalVar>(
              builder: (context, globalVar, _) {
                Map<String, dynamic> currentPickUpData =
                    globalVar.currentPickUpData ?? {};
                Map<String, dynamic> sweeperData = globalVar.sweeperData ?? {};

                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Order Data:',
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    Text('ID: ${currentOrderData['id'] ?? ''}'),
                    Text('User ID: ${currentOrderData['user_id'] ?? ''}'),
                    Text('Pickup ID: ${currentOrderData['pickup_id'] ?? ''}'),
                    Text(
                        'Waste Types: ${currentOrderData['waste_types'] ?? ''}'),
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
                    Text(
                      'Pickup Data:',
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    Text('ID: ${currentPickUpData['id'] ?? ''}'),
                    Text('Order ID: ${currentPickUpData['order_id'] ?? ''}'),
                    Text(
                        'Pickuper ID: ${currentPickUpData['pickuper_id'] ?? ''}'),
                    Text('Reward: ${currentPickUpData['reward'] ?? ''}'),
                    // Tampilkan data dari sweeper_data
                    Text(
                      'Sweeper Data:',
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    Text('ID: ${sweeperData['id'] ?? ''}'),
                    Text('Username: ${sweeperData['username'] ?? ''}'),
                    Text('Email: ${sweeperData['email'] ?? ''}'),
                    Text('Phone: ${sweeperData['phone'] ?? ''}'),
                    Text('User Type: ${sweeperData['user_type'] ?? ''}'),
                    CircleAvatar(
                      radius: 42,
                      backgroundImage: NetworkImage(
                        globalVar.sweeperData['profile_image'] ??
                            'https://firebasestorage.googleapis.com/v0/b/tra-tour.appspot.com/o/default_profile_image.png?alt=media&token=83bb623d-473f-4c5e-93c3-ecc3fc5f915b',
                      ),
                    ),

                    SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: globalVar.userLocation.isEmpty
                          ? null
                          : () {
                              _openRouteGoogleMaps(context);
                            },
                      child: const Text('Lihat Posisi Sweeper'),
                    ),
                    SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: () {
                        // Logika untuk tombol batal
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: Text('Konfirmasi'),
                              content: Text(
                                  'Apakah Anda yakin ingin membatalkan pesanan?'),
                              actions: <Widget>[
                                TextButton(
                                  onPressed: () {
                                    Navigator.of(context)
                                        .pop(false); // Tutup dialog
                                  },
                                  child: Text('Tidak'),
                                ),
                                TextButton(
                                  onPressed: () {
                                    Navigator.of(context)
                                        .pop(true); // Tutup dialog
                                    Navigator.of(context)
                                        .pop(); // Kembali ke halaman sebelumnya
                                  },
                                  child: Text('Ya'),
                                ),
                              ],
                            );
                          },
                        );
                      },
                      child: Text('Batal'),
                    ),
                  ],
                );
              },
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _openRouteGoogleMaps(BuildContext context) async {
    String userLocation =
        Provider.of<GlobalVar>(context, listen: false).userLocation;
    List<String> coordinates = userLocation.split(', ');
    double userLatitude = 0.0;
    double userLongitude = 0.0;

    for (String coordinate in coordinates) {
      if (coordinate.contains('Latitude')) {
        userLatitude = double.parse(coordinate.substring(10));
      } else if (coordinate.contains('Longitude')) {
        userLongitude = double.parse(coordinate.substring(11));
      }
    }

    print('coordinate sweeper ${currentOrderData['sweeper_coordinate']}');

    String? sweeperCoordinate = currentOrderData['sweeper_coordinate'];

    if (sweeperCoordinate != null && sweeperCoordinate.isNotEmpty) {
      List<String> sweeperCoordinates = sweeperCoordinate.split(',');
      double sweeperLatitude = double.parse(sweeperCoordinates[0]);
      double sweeperLongitude = double.parse(sweeperCoordinates[1]);
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
            content: Text('Sweeper coordinate is missing.'),
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
    String? sweeperCoordinate = currentOrderData['sweeper_coordinate'];
    String? userCoordinate = currentOrderData['user_coordinate'];

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

      print('Distance: $distanceInMeters meters');
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
}
 */
class OrderProcess extends StatefulWidget {
  GlobalVar globalVar = GlobalVar.instance;

  @override
  _OrderProcessState createState() => _OrderProcessState();
}

class _OrderProcessState extends State<OrderProcess> {
  late Map<String, dynamic> currentOrderData;
  String _distanceText = '';

  @override
  void initState() {
    super.initState();
    // Panggil _calculateDistance saat widget diinisialisasi
    _initializeOrderData();
  }

  // Inisialisasi currentOrderData
  void _initializeOrderData() {
    currentOrderData = {
      'id': '51',
      'user_id': '64',
      'pickup_id': '1',
      'waste_types': '0,1,2,5',
      'user_coordinate': '-6.2126044,106.8688975',
      'sweeper_coordinate': '-6.175392,106.827153',
      'address': 'Jalan Kemana saja',
      'cost': '30000',
      'payment_method': '1',
      'created_at': '2024-04-09 00:00:00',
      'updated_at': '2024-04-09 00:00:00',
      'status': 'inprogress'
    };
    calculateDistance(context);
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text('Konfirmasi'),
              content: Text('Apakah Anda yakin ingin membatalkan pesanan?'),
              actions: <Widget>[
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop(false); // Tutup dialog
                  },
                  child: Text('Tidak'),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop(true); // Tutup dialog
                    Navigator.of(context)
                        .pop(); // Kembali ke halaman sebelumnya
                  },
                  child: Text('Ya'),
                ),
              ],
            );
          },
        );
        return false; // Tidak membiarkan pengguna keluar dari halaman
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            'Sweeper Ditemukan',
            style: TextStyle(fontSize: 18), // Atur ukuran font di sini
          ),
          automaticallyImplyLeading: false, // Tambahkan baris ini
          actions: [
            IconButton(
              onPressed: () {
                // Tambahkan logika refresh di sini
                // Anda dapat menambahkan kode untuk memperbarui data atau melakukan tindakan lain saat tombol refresh ditekan
              },
              icon: Icon(Icons.refresh),
            ),
          ],
        ),
        body: SingleChildScrollView(
          child: Center(
            child: Consumer<GlobalVar>(
              builder: (context, globalVar, _) {
                Map<String, dynamic> currentPickUpData =
                    globalVar.currentPickUpData ?? {};
                Map<String, dynamic> sweeperData = globalVar.sweeperData ?? {};

                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Order Data:',
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    Text('ID: ${currentOrderData['id'] ?? ''}'),
                    Text('User ID: ${currentOrderData['user_id'] ?? ''}'),
                    Text('Pickup ID: ${currentOrderData['pickup_id'] ?? ''}'),
                    Text(
                        'Waste Types: ${currentOrderData['waste_types'] ?? ''}'),
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
                    Text(
                      'Pickup Data:',
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    Text('ID: ${currentPickUpData['id'] ?? ''}'),
                    Text('Order ID: ${currentPickUpData['order_id'] ?? ''}'),
                    Text(
                        'Pickuper ID: ${currentPickUpData['pickuper_id'] ?? ''}'),
                    Text('Reward: ${currentPickUpData['reward'] ?? ''}'),
                    // Tampilkan data dari sweeper_data
                    Text(
                      'Sweeper Data:',
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    Text('ID: ${sweeperData['id'] ?? ''}'),
                    Text('Username: ${sweeperData['username'] ?? ''}'),
                    Text('Email: ${sweeperData['email'] ?? ''}'),
                    Text('Phone: ${sweeperData['phone'] ?? ''}'),
                    Text('User Type: ${sweeperData['user_type'] ?? ''}'),
                    Text(
                      'Jarak:',
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),

                    
                    Text('Distance: $_distanceText meters'),

                    
                    CircleAvatar(
                      radius: 42,
                      backgroundImage: NetworkImage(
                        globalVar.sweeperData['profile_image'] ??
                            'https://firebasestorage.googleapis.com/v0/b/tra-tour.appspot.com/o/default_profile_image.png?alt=media&token=83bb623d-473f-4c5e-93c3-ecc3fc5f915b',
                      ),
                    ),

                    SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: globalVar.userLocation.isEmpty
                          ? null
                          : () {
                              _openRouteGoogleMaps(context);
                            },
                      child: const Text('Lihat Posisi Sweeper'),
                    ),
                    SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: () {
                        // Logika untuk tombol batal
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: Text('Konfirmasi'),
                              content: Text(
                                  'Apakah Anda yakin ingin membatalkan pesanan?'),
                              actions: <Widget>[
                                TextButton(
                                  onPressed: () {
                                    Navigator.of(context)
                                        .pop(false); // Tutup dialog
                                  },
                                  child: Text('Tidak'),
                                ),
                                TextButton(
                                  onPressed: () {
                                    Navigator.of(context)
                                        .pop(true); // Tutup dialog
                                    Navigator.of(context)
                                        .pop(); // Kembali ke halaman sebelumnya
                                  },
                                  child: Text('Ya'),
                                ),
                              ],
                            );
                          },
                        );
                      },
                      child: Text('Batal'),
                    ),
                  ],
                );
              },
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _openRouteGoogleMaps(BuildContext context) async {
    String userLocation =
        Provider.of<GlobalVar>(context, listen: false).userLocation;
    List<String> coordinates = userLocation.split(', ');
    double userLatitude = 0.0;
    double userLongitude = 0.0;

    for (String coordinate in coordinates) {
      if (coordinate.contains('Latitude')) {
        userLatitude = double.parse(coordinate.substring(10));
      } else if (coordinate.contains('Longitude')) {
        userLongitude = double.parse(coordinate.substring(11));
      }
    }

    print('coordinate sweeper ${currentOrderData['sweeper_coordinate']}');

    String? sweeperCoordinate = currentOrderData['sweeper_coordinate'];

    if (sweeperCoordinate != null && sweeperCoordinate.isNotEmpty) {
      List<String> sweeperCoordinates = sweeperCoordinate.split(',');
      double sweeperLatitude = double.parse(sweeperCoordinates[0]);
      double sweeperLongitude = double.parse(sweeperCoordinates[1]);
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
            content: Text('Sweeper coordinate is missing.'),
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
    String? sweeperCoordinate = currentOrderData['sweeper_coordinate'];
    String? userCoordinate = currentOrderData['user_coordinate'];

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

      // Update _distanceText with the calculated distance
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
}
