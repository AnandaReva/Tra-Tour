

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

import 'package:provider/provider.dart';
import 'package:tratour/components/appBar.dart';

import 'package:tratour/globalVar.dart';
import 'package:url_launcher/url_launcher.dart';

class CustomCheckbox extends StatelessWidget {
  final int index;
  final String title;

  const CustomCheckbox({required this.index, required this.title, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final checkboxProvider = Provider.of<CheckboxProvider>(context);
    return GestureDetector(
      onTap: () {
        checkboxProvider.updateCheckbox(index);
      },
      child: Stack(
        alignment: Alignment.center,
        children: [
          Container(
            width: 100,
            height: 100,
            decoration: BoxDecoration(
              border: Border.all(
                color: checkboxProvider.isChecked[index]
                    ? Colors.black
                    : Colors.transparent,
                width: 3,
              ),
            ),
          ),
          Image.asset(
            checkboxProvider.checkboxImages[index],
            width: 100,
            height: 100,
          ),
        ],
      ),
    );
  }
}

class ChecBoxImages extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<CheckboxProvider>(
        builder: (context, checkboxProvider, _) {
          List<int> selectedTrashIndexes = [];
          for (int i = 0; i < checkboxProvider.checkboxImages.length; i++) {
            if (checkboxProvider.isChecked[i]) {
              selectedTrashIndexes.add(i);
            }
          }
          return SingleChildScrollView(
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  for (int i = 0;
                      i < checkboxProvider.checkboxImages.length;
                      i++)
                    CustomCheckbox(title: 'pilihan ${i + 1}', index: i),
                  ElevatedButton(
                    onPressed: selectedTrashIndexes.isEmpty
                        ? null // Nonaktifkan tombol jika tidak ada pilihan yang dipilih
                        : () {
                            // Gunakan GlobalVar untuk mengakses selectedTrashIndexes
                            GlobalVar.instance.selectedTrashIndexes =
                                selectedTrashIndexes;
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) => PickUpLocationPage(),
                              ),
                            );
                          },
                    child: const Text('Atur lokasi pengangkutan'),
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

class CheckboxProvider with ChangeNotifier {
  final List<bool> _isChecked = [
    false,
    false,
    false,
    false,
    false,
    false
  ]; // Update panjang list menjadi 6
  final List<String> _checkboxImages = [
    'assets/images/plastik.png',
    'assets/images/organik.png',
    'assets/images/minyak.png',
    'assets/images/kardus.png', // Tambahkan gambar baru
    'assets/images/elektronik.png', // Tambahkan gambar baru
    'assets/images/pakaian.png', // Tambahkan gambar baru
  ];

  List<bool> get isChecked => _isChecked;
  List<String> get checkboxImages => _checkboxImages;

  void updateCheckbox(int index) {
    _isChecked[index] = !_isChecked[index];
    notifyListeners();
  }
}

class SortTrashPage extends StatelessWidget {
  const SortTrashPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<CheckboxProvider>(
      create: (context) => CheckboxProvider(),
      child: Scaffold(
        appBar: const MyAppBar(),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: SizedBox(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            child: ChecBoxImages(),
          ),
        ),
      ),
    );
  }
}

class PickUpLocationPage extends StatelessWidget {
  const PickUpLocationPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Tentukan Lokasi Pengambilan',
          style: TextStyle(fontSize: 18), // Atur ukuran font di sini
        ),
      ),
      body: Center(
        child: Consumer<GlobalVar>(
          builder: (context, globalVar, child) {
            List<int> selectedTrashIndexes = globalVar.selectedTrashIndexes;
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
                      ? null // Nonaktifkan tombol jika tidak ada pilihan yang dipilih
                      : () {
                          _openGoogleMaps(context);
                        },
                  child: const Text('Periksa Lokasi'),
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
        'https://www.google.com/maps/search/?api=1&query=$latitude,$longitude');

    if (await launchUrl(googleMapsUrl)) {
      await launchUrl(googleMapsUrl);
    } else {
      throw 'Tidak dapat membuka Google Maps';
    }
  }
}

class PickUpSchedule extends StatefulWidget {
  PickUpSchedule({Key? key}) : super(key: key);

  @override
  _PickUpScheduleState createState() => _PickUpScheduleState();
}

class _PickUpScheduleState extends State<PickUpSchedule> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Pilih Jadwal Pengangkutan',
          style: TextStyle(fontSize: 18), // Atur ukuran font di sini
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            /*  ElevatedButton(
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => ConfirmationPage(),
                  ),
                );
              },
              child: const Text('Konfirmasi'),
            ) */
          ],
        ),
      ),
    );
  }
}
