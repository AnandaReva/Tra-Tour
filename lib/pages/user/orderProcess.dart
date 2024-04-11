// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:provider/provider.dart';
import 'package:tratour/components/custom_button.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:tratour/globalVar.dart';
import 'package:tratour/database/auth.dart';
import 'package:tratour/database/order.dart';

class OrderProcess extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => GlobalVar.instance,
      child: OrderProcessContent(),
    );
  }
}

class OrderProcessContent extends StatelessWidget {
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

        return Scaffold(
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
                },
                icon: Icon(Icons.refresh),
              ),
            ],
          ),
          // Text(
          //   'Jarak:',
          //   style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          // ),
          // Text('Distance: $_distanceText meters'), // Memperbaiki ini

          // CircleAvatar(
          //   radius: 42,
          //   backgroundImage: NetworkImage(
          //     currentSweeperData != null
          //         ? currentSweeperData['profile_image'] ??
          //             'https://firebasestorage.googleapis.com/v0/b/tra-tour.appspot.com/o/default_profile_image.png?alt=media&token=83bb623d-473f-4c5e-93c3-ecc3fc5f915b'
          //         : 'https://firebasestorage.googleapis.com/v0/b/tra-tour.appspot.com/o/default_profile_image.png?alt=media&token=83bb623d-473f-4c5e-93c3-ecc3fc5f915b',
          //   ),
          // ),

          //         SizedBox(height: 20),
          // ElevatedButton(
          //   onPressed: () {
          //     _openRouteGoogleMaps(context,
          //         currentOrderData); // Menambah parameter currentOrderData
          //   },
          //   child: const Text('Lihat Posisi Sweeper'),
          // ),
          // SizedBox(height: 20),
          // ElevatedButton(
          //   onPressed: () async {
          //     // Memperbaiki pemanggilan showDialog
          //     _showCancelOrderDialog(
          //         context, globalVar, currentOrderData);
          //   },
          //   child: Text('Batal'),
          //         // ),
          //       ],
          //     ),
          //   ),
          // ),

          body: DapatSweeper(
              currentOrderData, currentPickUpData, currentSweeperData),
        );
      },
    );
  }

  Future<void> _openRouteGoogleMaps(
      BuildContext context, Map<String, dynamic> currentOrderData) async {
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

  Future<void> _showCancelOrderDialog(BuildContext context, GlobalVar globalVar,
      Map<String, dynamic> currentOrderData) async {
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

class DapatSweeper extends StatelessWidget {
  final Map<String, dynamic> currentOrderData;
  final Map<String, dynamic> currentPickUpData;
  final Map<String, dynamic> currentSweeperData;

  const DapatSweeper(this.currentOrderData,  this.currentPickUpData,this.currentSweeperData,{super.key});
  
  @override
  Widget build(BuildContext context) {
    Widget hero() {
      return Container(
        margin: EdgeInsets.only(bottom: 133),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset('assets/images/icon_sweeper.png'),
            SizedBox(
              height: 16,
            ),
            Text(
              'Sweeper Telah Ditemukan',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      );
    }

    Widget profileTile() {
      return Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.asset(
            'assets/images/sutejo.png',
            width: 56,
            height: 56,
            fit: BoxFit.cover,
          ),
          SizedBox(
            width: 8,
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Text(
                //   'Sutejo',
                //   style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
                // ),
                Text(
                  '${currentSweeperData['username'] ?? ''}',
                  style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 8,
                ),
                Text(
                  '${currentSweeperData['phone'] ?? ''}',
                  style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
                ),
                // Text(
                //   '08230698586',
                //   style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
                // ),
              ],
            ),
          ),
          Image.asset(
            'assets/images/logo.png',
            width: 80,
            height: 39,
            fit: BoxFit.cover,
          )
        ],
      );
    }

    Widget infoSweeper() {
      return Align(
        alignment: Alignment.bottomCenter,
        child: Container(
          height: 246,
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 26),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(26), topRight: Radius.circular(26)),
            border: Border(top: BorderSide(width: 2)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              profileTile(),
              SizedBox(
                height: 20,
              ),
              // Text(
              //   'Tipe Sampah: Organik dan Plastik',
              //   style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold),
              // ),
              Text(
                'Waste Types: ${currentOrderData['waste_types'] ?? ''}',
                style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 4,
              ),
              Text(
                'Reward: ${currentPickUpData['reward'] ?? ''}',
                style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold),
              ),
              // Text(
              //   'Reward: 2000',
              //   style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold),
              // ),
              SizedBox(
                height: 14,
              ),
              CustomButton(onPressed: () {}, text: 'Lihat Posisi Sweeper'),
            ],
          ),
        ),
      );
    }

    return Scaffold(
      body: Center(
        child: Stack(
          children: [
            hero(),
            infoSweeper(),
          ],
        ),
      ),
    );
  }
}
