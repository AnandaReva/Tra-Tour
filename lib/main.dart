//import 'dart:convert';
import 'package:aplikasi_sampah/components/drawer.dart';
import 'package:aplikasi_sampah/globalVar.dart';
import 'package:flutter/material.dart';
//import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:aplikasi_sampah/components/appBar.dart';

//import 'package:aplikasi_sampah/profile.dart';

void main() {
  // Menggunakan instance Singleton
  GlobalVar globalVar = GlobalVar.instance;
  // Lakukan pengecekan isLogin saat aplikasi dimulai
  if (!globalVar.isLogin) {
    print('user Belum Login');
  }

  //var loginDatabase = LoginMonggoDatabase(globalVar: globalVar);

  runApp(MyApp(globalVar: globalVar));
}

class MyApp extends StatelessWidget {
  final GlobalVar globalVar; // Deklarasi instance globalVar
  const MyApp({Key? key, required this.globalVar}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Aplikasi Sampah',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      // Kirim instance globalVar ke HomePage
      home: HomePage(globalVar: globalVar),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({Key? key, required GlobalVar globalVar}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    GlobalVar globalVar = GlobalVar.instance;

    return Scaffold(
      appBar: const MyAppBar(),
      body: SingleChildScrollView(
        child: SizedBox(
            //  width: 500,
            height: MediaQuery.of(context).size.height -
                MediaQuery.of(context).padding.top,
            child: Column(
              children: [
                const SizedBox(
                  height: 10,
                ),
                Container(
                  padding: const EdgeInsets.all(5),
                  margin: const EdgeInsets.symmetric(horizontal: 5),
                  height: 100,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey),
                    borderRadius: BorderRadius.circular(10),
                    color: GlobalVar.mainColor,
                  ),
                  child: Column(
                    children: [
                      Text(
                        'Poin Kamu',
                        style: TextStyle(
                          color: Colors.white,
                          fontFamily: 'Poppins-Bold',
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        'Child 1',
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                      Text(
                        'Child 2',
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Container(
                  padding: const EdgeInsets.all(5),
                  margin: const EdgeInsets.symmetric(horizontal: 5),
                  width: double.infinity,
                  height: 200,
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey),
                      borderRadius: BorderRadius.circular(10),
                      color: GlobalVar.mainColor),
                  child: const Text(
                    'Voucher',
                    style: TextStyle(
                      color: Colors.white,
                      fontFamily: 'Poppins-Bold',
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                Container(
                  padding: const EdgeInsets.all(5),
                  margin: const EdgeInsets.symmetric(horizontal: 5),
                  width: double.infinity,
                  height: 200,
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey),
                      borderRadius: BorderRadius.circular(10),
                      color: GlobalVar.mainColor),
                  child: const Text(
                    'Voucher',
                    style: TextStyle(
                      color: Colors.white,
                      fontFamily: 'Poppins-Bold',
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ], // <--
            )),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.white,
        onPressed: () {},
        child: const Icon(Icons.add, color: GlobalVar.mainColor),
      ),
    );
  }
}
