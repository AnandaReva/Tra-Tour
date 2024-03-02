import 'package:aplikasi_sampah/components/imageViewer.dart';
import 'package:aplikasi_sampah/firebase/auth.dart';
import 'package:flutter/material.dart';
import 'package:aplikasi_sampah/components/appBar.dart';
import 'package:aplikasi_sampah/globalVar.dart';
import 'package:aplikasi_sampah/main.dart';

class ProfilePage extends StatelessWidget {
   ProfilePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    GlobalVar globalVar = GlobalVar.instance;

    var profilePhotoUrl =
        'https://firebasestorage.googleapis.com/v0/b/tra-tour.appspot.com/o/admin%2Fadmin_profile_picture.png?alt=media&token=2f101f86-e0d6-4cbb-aebe-faa4d37479d0';

    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          MyImageViewer(profilePhoto: profilePhotoUrl)),
                );
              },
              child: CircleAvatar(
                radius: 50,
                backgroundImage: NetworkImage(
                  'https://firebasestorage.googleapis.com/v0/b/tra-tour.appspot.com/o/admin%2Fadmin_profile_picture.png?alt=media&token=2f101f86-e0d6-4cbb-aebe-faa4d37479d0',
                ),
              ),
            ),
            const SizedBox(height: 20),
            Text(
              'Rakesh',
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            Container(
              padding: const EdgeInsets.all(10),
              margin: const EdgeInsets.symmetric(horizontal: 20),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey),
                borderRadius: BorderRadius.circular(10),
                color: GlobalVar.mainColor,
              ),
              child: Text(
                'ini Bio',
                style: const TextStyle(
                  fontSize: 15,
                  fontFamily: 'Poppins-Regular',
                  color: Colors.white,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            const SizedBox(height: 20),
            

            // Panggil _signoutButton di sini
            _signoutButton(context),
          
          ],
        ),
      ),
    );
  }

  final Auth _signOut = Auth(); // Buat instance dari kelas Auth
 Widget _signoutButton(BuildContext context) {
  return ElevatedButton(
    onPressed: () {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Konfirmasi'),
            content: Text('Apakah Anda yakin ingin keluar?'),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop(); // Tutup dialog
                },
                child: Text('Batal'),
              ),
              ElevatedButton(
                onPressed: () {
                  _signOut.signOut(context); // Panggil metode signOut dari instance Auth
                  Navigator.of(context).pop(); // Tutup dialog
                },
                child: Text('Keluar'),
              ),
            ],
          );
        },
      );
    },
    child: const Text('Keluar'),
  );
}
}
