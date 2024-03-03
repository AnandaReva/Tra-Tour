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
