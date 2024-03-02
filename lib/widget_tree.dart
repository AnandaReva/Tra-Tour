import 'package:aplikasi_sampah/login_register_page.dart';
import 'package:aplikasi_sampah/components/profilePage.dart';
import 'package:aplikasi_sampah/firebase/auth.dart';
import 'package:aplikasi_sampah/globalVar.dart';
import 'package:aplikasi_sampah/main.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class WidgetTree extends StatefulWidget {
  const WidgetTree({Key? key}) : super(key: key);

  @override
  State<WidgetTree> createState() => _WidgetTreeState();
}

class _WidgetTreeState extends State<WidgetTree> {
  @override
  Widget build(BuildContext context) {
    GlobalVar globalVar = GlobalVar.instance;

    return StreamBuilder(
      stream: Auth().authStateChanges,
      builder: (context, snapshot) {
        // Perbaiki sintaks di sini
        if (snapshot.hasData) {
          return HomePage(globalVar: globalVar); // Perbaiki sintaks di sini
        } else {
          return LoginPage(globalVar: globalVar,); // Perbaiki sintaks di sini
        }
      },
    );
  }
}
