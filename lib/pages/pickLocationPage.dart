import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:provider/provider.dart';
import 'package:tratour/globalVar.dart';
import 'package:tratour/pages/createOrderPage.dart';
import 'package:url_launcher/url_launcher.dart';

class PickLocationPage extends StatefulWidget {
  PickLocationPage({Key? key}) : super(key: key);

  @override
  _PickLocationPageState createState() => _PickLocationPageState();
}

class _PickLocationPageState extends State<PickLocationPage> {
  late TextEditingController _addressUpdateController;
  late TextEditingController _usernameUpdateController;
  late TextEditingController _phoneUpdateController;
  late TextEditingController _postalUpdateCodeController;

  @override
  void initState() {
    super.initState();
    _addressUpdateController = TextEditingController();
    _usernameUpdateController = TextEditingController();
    _phoneUpdateController = TextEditingController();
    _postalUpdateCodeController = TextEditingController();
  }

  @override
  void dispose() {
    _addressUpdateController.dispose();
    _usernameUpdateController.dispose();
    _phoneUpdateController.dispose();
    _postalUpdateCodeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    GlobalVar globalVar = Provider.of<GlobalVar>(context);
    Map<String, dynamic> userData = globalVar.userLoginData ?? {};

    _usernameUpdateController.text = userData['username'] ?? '';
    _phoneUpdateController.text = userData['phone'] ?? '';
    _addressUpdateController.text = userData['address'] ?? '';
    _postalUpdateCodeController.text = userData['postal_code'] ?? '';

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Tentukan Lokasi Pengambilan',
          style: TextStyle(fontSize: 18),
        ),
      ),
      body: Center(
        child: Consumer<GlobalVar>(
          builder: (context, globalVar, child) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('${globalVar.userLocation}'),
                SizedBox(height: 20),
                TextButton(
                  onPressed: () {
                    _getCurrentPosition(context);
                  },
                  child: Text('Gunakan Lokasimu'),
                ),
                SizedBox(width: 20),
                ElevatedButton(
                  onPressed: globalVar.userLocation.isEmpty
                      ? null
                      : () {
                          _openGoogleMaps(context);
                        },
                  child: const Text('Periksa Lokasi'),
                ),
                SizedBox(height: 20),
                Text("Alamat Anda"),
                TextFormField(
                  controller: _addressUpdateController,
                  decoration: const InputDecoration(
                    contentPadding: EdgeInsets.all(10),
                    border: OutlineInputBorder(),
                    labelText: 'Alamat',
                  ),
                  onChanged: (value) {
                    setState(() {
                      userData['address'] = value;
                    });
                  },
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: globalVar.userLocation.isEmpty
                      ? null
                      : () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => CreateOrderPage(),
                              fullscreenDialog: true,
                            ),
                          );
                        },
                  child: const Text('Buat Pesanan'),
                )
              ],
            );
          },
        ),
      ),
    );
  }

  Future<bool> _handlePermission(BuildContext context) async {
    bool serviceEnabled;
    LocationPermission permission;

    // Test if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("GPS Nonaktif"),
            content:
                Text("Aktifkan GPS pada perangkat Anda untuk melanjutkan."),
            actions: <Widget>[
              TextButton(
                child: Text("Tutup"),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
      return false;
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        Provider.of<GlobalVar>(context, listen: false).userLocation =
            'Izin akses lokasi ditolak.';
        return false;
      }
    }

    if (permission == LocationPermission.deniedForever) {
      Provider.of<GlobalVar>(context, listen: false).userLocation =
          'Izin akses lokasi ditolak selamanya.';
      return false;
    }

    return true;
  }

  Future<void> _getCurrentPosition(BuildContext context) async {
    bool hasPermission = await _handlePermission(context);

    if (!hasPermission) {
      return;
    }

    try {
      Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );

      Provider.of<GlobalVar>(context, listen: false).userLocation =
          'Latitude: ${position.latitude}, Longitude: ${position.longitude}';
      print(
          'location:  ${Provider.of<GlobalVar>(context, listen: false).userLocation}');
    } catch (e) {
      Provider.of<GlobalVar>(context, listen: false).userLocation = 'Error: $e';
    }
  }

  Future<void> _openGoogleMaps(BuildContext context) async {
    String userLocation =
        Provider.of<GlobalVar>(context, listen: false).userLocation;
    List<String> coordinates = userLocation.split(', ');
    double latitude = double.parse(coordinates[0]
        .substring(9)); // Mengambil nilai latitude setelah "Latitude: "
    double longitude = double.parse(coordinates[1]
        .substring(10)); // Mengambil nilai longitude setelah "Longitude: "

    final Uri googleMapsUrl = Uri.parse(
        'https://www.google.com/maps/search/?api=1&query=$latitude,$longitude' /*'https://www.google.com/maps/dir/?api=1&origin=-6.1754,106.8272&destination=-6.2009,106.8276'  // ini rute*/);

    if (await launchUrl(googleMapsUrl)) {
      await launchUrl(googleMapsUrl);
    } else {
      throw 'Tidak dapat membuka Google Maps';
    }
  }
}
