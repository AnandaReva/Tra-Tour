// ignore_for_file: prefer_const_constructors
import 'package:flutter/material.dart';

class IntroPage3 extends StatelessWidget {
  const IntroPage3({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 29, 121, 72),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            // Logo
            Container(
              width: 137,
              padding: EdgeInsets.all(20),
              child: Image.asset("assets/images/Logo.png"),
            ),
            SizedBox(
              height: 60,
            ),
            // opsi
            Center(
              child: Text(
                "Masuk Sebagai",
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Center(
              child: SizedBox(
                child: GestureDetector(
                  onTap: () {
                    print("Pengepul Tap");
                  },
                  child: Column(
                    children: [
                      Image.asset("assets/images/User Pengepul.png"),
                      Text(
                        "Pengepul",
                        style: TextStyle(
                          fontSize: 32,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            SizedBox(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  GestureDetector(
                    onTap: () {
                      print("Pickuper Tap");
                    },
                    child: Column(
                      children: [
                        Image.asset("assets/images/User Pickuper.png"),
                        Text(
                          "Pickuper",
                          style: TextStyle(
                            fontSize: 32,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      print("User Tap");
                    },
                    child: Column(
                      children: [
                        Image.asset("assets/images/User User.png"),
                        Text(
                          "Warga",
                          style: TextStyle(
                            fontSize: 32,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
