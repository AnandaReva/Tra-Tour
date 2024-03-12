import 'package:flutter/material.dart';

import 'package:tratour_application/pages/my_home_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'TraTour Application',
      theme: ThemeData(fontFamily: 'PlusJakartaSans'),
      home: MyHomePage(),
    );
  }
}
