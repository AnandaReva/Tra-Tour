//import 'package:aplikasi_sampah/dbHelper/mysql.dart';
import 'package:aplikasi_sampah/globalVar.dart';
import 'package:aplikasi_sampah/login_register_page.dart';
import 'package:aplikasi_sampah/main.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

import 'package:http/http.dart' as http;
//import 'package:intl/intl.dart';
import 'dart:convert';
//import 'package:mysql1/mysql1.dart';

//import 'package:mysql1/mysql1.dart';

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

      globalVar.isLogin = true;
    } catch (e) {
      globalVar.isLoading = false;
      print('Error creating user: $e');
      throw e;
    }
  }

  Future<void> signOut(BuildContext context) async {
    await _firebaseAuth.signOut();

    globalVar.userLoginData = [];
    globalVar.isLogin = false;

    // List<dynamic> userDataList = globalVar.userLoginData;
    //  print('SignoutData: $userDataList');

    // Navigate to LoginPage
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => LoginPage(globalVar: globalVar)),
      (route) => false, // Predicate: hapus semua halaman di atasnya
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

  Future<void> addUserToDatabase(
    String username,
    String password,
    String email,
    String phone,
    String role,
    String initial_user_point,
    String initial_profile_image,
    String referral_code,
  ) async {
    try {
      String url = 'https://tratour.000webhostapp.com/createUser.php';

      Map<String, dynamic> newUserData = {
        'username': username,
        'email': email,
        'phone': phone,
        'password': password,
        'user_type': role,
        'user_point': initial_user_point,
        'profile_image': initial_profile_image,
        'referral_code': referral_code,
      };

      String body = json.encode(newUserData);

      print('debug 5: $newUserData ');

      final response = await http.post(
        Uri.parse(url),
        headers: <String, String>{
          'Content-Type': 'application/json',
        },
        body: body,
      );

      if (response.statusCode == 200) {
        print('New user added successfully.');

        // Memperbarui userLoginData setelah menambahkan pengguna baru
        GlobalVar globalVar = GlobalVar.instance;

        globalVar.userLoginData = newUserData;

        print('debig m3: $globalVar.userLoginData');

        // Cetak tipe data respons
        print('Response Type: ${response.body.runtimeType}');
      } else {
        print('Failed to create user: ${response.statusCode}');
        // Lakukan sesuatu jika gagal menambahkan pengguna
      }
    } catch (e) {
      print('Error adding user: $e');
      // Lakukan sesuatu jika terjadi kesalahan
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