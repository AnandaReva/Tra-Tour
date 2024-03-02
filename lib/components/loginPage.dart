<<<<<<< HEAD
/* // Page Login
import 'package:aplikasi_sampah/components/footer.dart';

import 'package:aplikasi_sampah/firebase/auth.dart';
import 'package:aplikasi_sampah/globalVar.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
//import 'package:loading_animation_widget/loading_animation_widget.dart';


class LoginPage extends StatelessWidget {
  LoginPage({Key? key}) : super(key: key);

  final User? user = Auth().currentUser;

  Future<void> signOut() async {
    await Auth().signOut();
  }

  @override
    Widget build(BuildContext context) {
=======
// Page Login
import 'package:aplikasi_sampah/components/footer.dart';
import 'package:aplikasi_sampah/dbHelper/authentication.dart';
import 'package:aplikasi_sampah/globalVar.dart';
import 'package:aplikasi_sampah/main.dart';
import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';


class LoginPage extends StatelessWidget {
  const LoginPage({Key? key}) : super(key: key);

  

  @override
  Widget build(BuildContext context) {
    TextEditingController emailController = TextEditingController();
    TextEditingController passwordController = TextEditingController();

    // Inisialisasi loginDatabase di dalam build()
    LoginMysqlDatabase loginDatabase =
        LoginMysqlDatabase(globalVar: GlobalVar.instance);

>>>>>>> 2bb67d4f0c9f7250b5c17d73d1a8710e413026af
    return Scaffold(
      appBar: AppBar(
        backgroundColor: GlobalVar.mainColor,
        title: const Text(
          'Login',
          style: TextStyle(
            color: Colors.white,
            fontFamily: 'Poppins-Bold',
            fontWeight: FontWeight.bold,
          ),
        ),
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(height: 20),
<<<<<<< HEAD
            Text(user?.email ?? 'User email'),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: signOut,
              child: const Text('Sign Out'),
=======
            TextField(
              controller: emailController,
              decoration: const InputDecoration(
                labelText: 'Email',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 20),
            TextField(
              obscureText: true,
              controller: passwordController,
              decoration: const InputDecoration(
                labelText: 'Password',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                String email = emailController.text;
                String password = passwordController.text;

                // Menampilkan animasi loading
                showDialog(
                  context: context,
                  barrierDismissible: false,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      content: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          LoadingAnimationWidget.threeRotatingDots(
                            size: 100,
                            color: GlobalVar.mainColor,
                          ), // Tampilkan ind
                        ],
                      ),
                    );
                  },
                );

                loginDatabase.connect(email, password).then((result) {
                  // Tutup dialog animasi loading
                  Navigator.of(context).pop();

                  // Handle hasil autentikasi di sini
                  if (result) {
                    // Jika autentikasi berhasil, lanjutkan ke halaman berikutnya
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => HomePage(
                          globalVar: GlobalVar.instance,
                        ),
                      ),
                    );
                  } else {
                    // Jika autentikasi gagal, tampilkan pesan kesalahan
                    print('Welcome   ${GlobalVar.instance.userLogindata}');
                    print(
                        'Data Posts   ${GlobalVar.instance.userLoginPostsData}');
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text(
                            'Login failed. Please check your email and password.'),
                      ),
                    );
                  }
                });
              },
              child: const Text('Login'),
>>>>>>> 2bb67d4f0c9f7250b5c17d73d1a8710e413026af
            ),
          ],
        ),
      ),
      bottomNavigationBar: const MyBottomNavigationBar(),
    );
<<<<<<< HEAD






/*   Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: GlobalVar.mainColor,
        title: const Text(
          'Login',
          style: TextStyle(
            color: Colors.white,
            fontFamily: 'Poppins-Bold',
            fontWeight: FontWeight.bold,
          ),
        ),
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(height: 20),
            Text(user?.email ?? 'User email'),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: signOut,
              child: const Text('Sign Out'),
            ),
          ],
        ),
      ),
      bottomNavigationBar: const MyBottomNavigationBar(),
    );
 */













  }
}
 */
=======
  }
}
>>>>>>> 2bb67d4f0c9f7250b5c17d73d1a8710e413026af
