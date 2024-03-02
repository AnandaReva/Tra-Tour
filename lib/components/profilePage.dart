<<<<<<< HEAD
import 'package:aplikasi_sampah/components/imageViewer.dart';
import 'package:aplikasi_sampah/firebase/auth.dart';
import 'package:flutter/material.dart';
import 'package:aplikasi_sampah/components/appBar.dart';
=======
//import 'dart:convert';

import 'package:flutter/material.dart';
//import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:aplikasi_sampah/components/appBar.dart';
import 'package:aplikasi_sampah/components/footer.dart';
import 'package:aplikasi_sampah/components/imageViewer.dart';


//import 'package:aplikasi_sampah/dbhelper/mongodb.dart';
//import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
//import 'package:photo_view/photo_view.dart';

>>>>>>> 2bb67d4f0c9f7250b5c17d73d1a8710e413026af
import 'package:aplikasi_sampah/globalVar.dart';
import 'package:aplikasi_sampah/main.dart';

class ProfilePage extends StatelessWidget {
<<<<<<< HEAD
   ProfilePage({Key? key}) : super(key: key);
=======
  const ProfilePage({super.key});
  static const mainColor = Color.fromRGBO(21, 16, 38, 1.0);
  static const baseColor = Color.fromRGBO(240, 240, 240, 1.0);
>>>>>>> 2bb67d4f0c9f7250b5c17d73d1a8710e413026af

  @override
  Widget build(BuildContext context) {
    GlobalVar globalVar = GlobalVar.instance;

<<<<<<< HEAD
    var profilePhotoUrl =
        'https://firebasestorage.googleapis.com/v0/b/tra-tour.appspot.com/o/admin%2Fadmin_profile_picture.png?alt=media&token=2f101f86-e0d6-4cbb-aebe-faa4d37479d0';

    return Scaffold(
=======
    var username = globalVar.userLogindata[0]['username'];
    var biography = globalVar.userLogindata[0]['biography'];
    var profilePhotoUrl = globalVar.userLogindata[0]['profilePhoto'];

    return Scaffold(
      appBar: const MyAppBar(),
>>>>>>> 2bb67d4f0c9f7250b5c17d73d1a8710e413026af
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
<<<<<<< HEAD
                  'https://firebasestorage.googleapis.com/v0/b/tra-tour.appspot.com/o/admin%2Fadmin_profile_picture.png?alt=media&token=2f101f86-e0d6-4cbb-aebe-faa4d37479d0',
=======
                  profilePhotoUrl,
>>>>>>> 2bb67d4f0c9f7250b5c17d73d1a8710e413026af
                ),
              ),
            ),
            const SizedBox(height: 20),
            Text(
<<<<<<< HEAD
              'Rakesh',
=======
              username,
>>>>>>> 2bb67d4f0c9f7250b5c17d73d1a8710e413026af
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            Container(
              padding: const EdgeInsets.all(10),
              margin: const EdgeInsets.symmetric(horizontal: 20),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey),
                borderRadius: BorderRadius.circular(10),
<<<<<<< HEAD
                color: GlobalVar.mainColor,
              ),
              child: Text(
                'ini Bio',
                style: const TextStyle(
                  fontSize: 15,
                  fontFamily: 'Poppins-Regular',
                  color: Colors.white,
=======
                color: mainColor,
              ),
              child: Text(
                biography,
                style: const TextStyle(
                  fontSize: 15,
                  fontFamily: 'Poppins-Regular',
                  color: Colors.white, // Warna teks hitam
>>>>>>> 2bb67d4f0c9f7250b5c17d73d1a8710e413026af
                ),
                textAlign: TextAlign.center,
              ),
            ),
            const SizedBox(height: 20),
<<<<<<< HEAD
            

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
=======
            ElevatedButton(
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: Text('Logout Confirmation'),
                      content:
                          Text('Are you sure to logout from this account?'),
                      actions: <Widget>[
                        TextButton(
                          onPressed: () {
                            Navigator.of(context).pop(
                                false); // Menutup dialog dan memberikan nilai false
                          },
                          child: Text('No'),
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.of(context).pop(
                                true); // Menutup dialog dan memberikan nilai true
                          },
                          child: Text('Yes'),
                        ),
                      ],
                    );
                  },
                ).then((value) {
                  if (value == true) {
                    // hapus data login
                    globalVar.userLogindata = [];
                    globalVar.userLoginPostsData = [];
                    globalVar.isLogin = false;
                    // Navigasi ke halaman login
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => HomePage(
                            globalVar:
                                GlobalVar.instance), // Sertakan globalVar
                      ),
                    );
                  } else {
                    // do nothing
                  }
                });
              },
              child: const Text('Logout'),
            ),
          ],
        ),
      ),
      bottomNavigationBar: const MyBottomNavigationBar(),
    );
  }
>>>>>>> 2bb67d4f0c9f7250b5c17d73d1a8710e413026af
}
