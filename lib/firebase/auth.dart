import 'package:aplikasi_sampah/dbHelper/mysql.dart';
import 'package:aplikasi_sampah/globalVar.dart';
import 'package:aplikasi_sampah/login_register_page.dart';
import 'package:aplikasi_sampah/main.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
//import 'package:mysql1/mysql1.dart';

import 'dart:math';

import 'package:mysql1/mysql1.dart';

class Auth {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  GlobalVar globalVar = GlobalVar.instance;

  // Create user with email and password

  User? get currentUser => _firebaseAuth.currentUser;

  Stream<User?> get authStateChanges => _firebaseAuth.authStateChanges();

  Future<void> signInWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    await _firebaseAuth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
  }

  Future<void> createUserWithEmailAndPassword(
    String email,
    String password,
  ) async {
    try {
      await _firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      /*   // Panggil method untuk menyimpan data user ke MySQL
       // sudah dipanggil di login_register_page.dart
        await addUserToDatabase(username, email,password , no_hp, kecamatan, kelurahan, kota ); */

      globalVar.isLogin = true;
    } catch (e) {
      print('Error creating user: $e');
      throw e;
    }
  }

  Future<void> signOut(BuildContext context) async {
    await _firebaseAuth.signOut();
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => LoginPage(globalVar: globalVar)),
    );
  }

  Future<void> signInWithGoogle(BuildContext context) async {
    try {
      // Inisialisasi Firebase jika belum dilakukan
      if (Firebase.apps.isEmpty) {
        await Firebase.initializeApp(
          options: const FirebaseOptions(
            apiKey: 'AIzaSyBxDijkEkT9meAuvaAPUIcM9NLW0S46O7w',
            appId: '1:525346093175:android:e0136e9c61854d9f0dee72',
            messagingSenderId: '525346093175',
            projectId: 'tra-tour',
          ),
        );
      }

      final GoogleSignIn googleSignIn = GoogleSignIn();
      print('cek auth 1');
      final GoogleSignInAccount? googleSignInAccount =
          await googleSignIn.signIn();

      print('cek auth 2');

      if (googleSignInAccount != null) {
        final GoogleSignInAuthentication googleSignInAuthentication =
            await googleSignInAccount.authentication;
        final AuthCredential credential = GoogleAuthProvider.credential(
          accessToken: googleSignInAuthentication.accessToken,
          idToken: googleSignInAuthentication.idToken,
        );

        print('cek auth 4');
        await _firebaseAuth.signInWithCredential(credential);

        // Redirect to home page or perform any necessary actions after successful sign-in
        globalVar.isLogin = true;
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => HomePage(globalVar: globalVar),
          ),
        );
      } else {
        // Handle case when user cancels the sign-in process
        print("Sign-in process cancelled");
      }
    } catch (e) {
      // Handle any errors that occur during sign-in process
      print("Error during sign-in with Google: $e");
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content:
              Text('Failed to sign in with Google. Please try again later.'),
        ),
      );
    }
  }

  Widget _title() {
    return const Text(
      'Login Page',
      style: TextStyle(
        color: Colors.white,
        fontFamily: 'Poppins-Bold',
        fontWeight: FontWeight.bold,
      ),
    );
  }

  Widget _emailField(TextEditingController emailController) {
    return TextField(
      controller: emailController,
      decoration: const InputDecoration(
        labelText: 'Email',
        border: OutlineInputBorder(),
      ),
    );
  }

  Widget _passwordField(TextEditingController passwordController) {
    return TextField(
      obscureText: true,
      controller: passwordController,
      decoration: const InputDecoration(
        labelText: 'Password',
        border: OutlineInputBorder(),
      ),
    );
  }

  Widget _loginButton(
    BuildContext context,
    TextEditingController emailController,
    TextEditingController passwordController,
  ) {
    return ElevatedButton(
      onPressed: () async {
        String email = emailController.text;
        String password = passwordController.text;

        try {
          await signInWithEmailAndPassword(email: email, password: password);
        } on FirebaseAuthException catch (e) {
          if (e.code == 'user-not-found') {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('No user found for that email.'),
              ),
            );
          } else if (e.code == 'wrong-password') {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Wrong password provided for that user.'),
              ),
            );
          }
        }
      },
      child: const Text('Login'),
    );
  }

  Widget _loginForm(
    BuildContext context,
    TextEditingController emailController,
    TextEditingController passwordController,
  ) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const SizedBox(height: 20),
          _emailField(emailController),
          SizedBox(height: 20),
          _passwordField(passwordController),
          SizedBox(height: 20),
          _loginButton(context, emailController, passwordController),
        ],
      ),
    );
  }

  Widget loginPage(BuildContext context) {
    TextEditingController emailController = TextEditingController();
    TextEditingController passwordController = TextEditingController();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: _title(),
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: _loginForm(context, emailController, passwordController),
    );
  }

  Widget _registerButton(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        Navigator.pushNamed(context, '/register');
      },
      child: const Text('Register'),
    );
  }

  Widget _registerForm(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const SizedBox(height: 20),
          _registerButton(context),
        ],
      ),
    );
  }

  Widget _signOutButton(BuildContext context) {
    return ElevatedButton(
      onPressed: () async {
        await signOut(
            context); // Panggil metode signOut dengan menyediakan context
      },
      child: const Text('Sign Out'),
    );
  }

  Widget loginPage2(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: _title(),
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: _signOutButton(context),
    );
  }

  // Metode untuk menambahkan data user ke database MySQL
  Future<void> addUserToDatabase(
      String username,
      String password,
      String email,
      String phone,
      String user_point,
      String user_type,
      profile_image,
      referral_code,
      createAndUpdateAt) async {
    try {
      await Mysql.connect();
      var results = await Mysql.connection.query(
        'INSERT INTO user (username, email, no_hp, password, user_point ,user_type, profile_image, referral_code, created_at, updated_at) '
        'VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?) '
        'ON DUPLICATE KEY UPDATE '
        'username = VALUES(username), '
        'no_hp = VALUES(no_hp), '
        'password = VALUES(password), '
        'user_point = VALUES(user_point), '
        'user_type = VALUES(user_type), '
        'profile_image = VALUES(profile_image), '
        'referral_code = VALUES(referral_code), '
        'created_at = VALUES(created_at), '
        'updated_at = VALUES(updated_at);',
        [
          username,
          email,
          phone,
          password,
          user_point,
          user_type,
          profile_image,
          referral_code,
          createAndUpdateAt,
          createAndUpdateAt // Menambahkan nilai createAndUpdateAt kedua


        ],

        // berhasil masukkan data user baru ke user Login
      );

      for (var row in results) {
        print('Akun Baru dimasukkan: $row');
      }
    } catch (e) {
      print('Error Insert Data MYSQL: $e');
    } finally {
      await Mysql.close();
    }
  }
}





/*  Future<void> signInWithGoogle(BuildContext context) async {
    try {
      final GoogleSignIn googleSignIn = GoogleSignIn();
        print('cek auth 1');
      final GoogleSignInAccount? googleSignInAccount =
          await googleSignIn.signIn();

            print('cek auth 2');

      if (googleSignInAccount != null) {
        final GoogleSignInAuthentication googleSignInAuthentication =
            await googleSignInAccount.authentication;
        final AuthCredential credential = GoogleAuthProvider.credential(
          accessToken: googleSignInAuthentication.accessToken,
          idToken: googleSignInAuthentication.idToken,
        );

        print('cek auth 4');
        await _firebaseAuth.signInWithCredential(credential);


        // Redirect to home page or perform any necessary actions after successful sign-in
        globalVar.isLogin = true;
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => HomePage(
                    globalVar: globalVar,
                  )),
        );
      } else {
        // Handle case when user cancels the sign-in process
        print("Sign-in process cancelled");
      }
    } catch (e) {
      // Handle any errors that occur during sign-in process
      print("Error during sign-in with Google: $e");
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content:
              Text('Failed to sign in with Google. Please try again later.'),
        ),
      );
    }
  } */