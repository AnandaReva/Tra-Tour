import 'package:flutter/material.dart';
import 'package:tratour/globalVar.dart';

class IntroPage3 extends StatefulWidget {
  const IntroPage3({Key? key, required this.globalVar}) : super(key: key);
  final GlobalVar globalVar;

  @override
  _IntroPage3State createState() => _IntroPage3State();
}

class _IntroPage3State extends State<IntroPage3> {
  @override
  Widget build(BuildContext context) {
    print("awal : ${widget.globalVar.selected_role_onboarding}");

    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 29, 121, 72),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            // Logo
            Container(
              width: 137,
              padding: const EdgeInsets.all(20),
              child: Image.asset("assets/images/logo.png"),
            ),
            const SizedBox(
              height: 60,
            ),
            // opsi
            const Center(
              child: Text(
                "Masuk Sebagai",
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Center(
              child: GestureDetector(
                onTap: () {
                  setState(() {
                    widget.globalVar.selected_role_onboarding = '3';
                    print(
                        "Pengepul : ${widget.globalVar.selected_role_onboarding}");
                  });
                },
                child: Column(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        border: Border.all(
                          color:
                              widget.globalVar.selected_role_onboarding == '3'
                                  ? Colors.black
                                  : Colors.transparent,
                          width: 2,
                        ),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Image.asset("assets/images/User Pengepul.png"),
                    ),
                    const Text(
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
            const SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                GestureDetector(
                  onTap: () {
                    setState(() {
                      widget.globalVar.selected_role_onboarding = '2';
                      print(
                          "Pengangkut : ${widget.globalVar.selected_role_onboarding}");
                    });
                  },
                  child: Column(
                    children: [
                      Container(
                        child: Image.asset("assets/images/User Pickuper.png"),
                        decoration: BoxDecoration(
                          border: Border.all(
                            color:
                                widget.globalVar.selected_role_onboarding == '2'
                                    ? Colors.black
                                    : Colors.transparent,
                            width: 2,
                          ),
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      const Text(
                        "Pengangkut",
                        style: TextStyle(
                          fontSize: 32,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 20),
                GestureDetector(
                  onTap: () {
                    setState(() {
                      widget.globalVar.selected_role_onboarding = '1';
                      print(
                          "Pengguna : ${widget.globalVar.selected_role_onboarding}");
                    });
                  },
                  child: Column(
                    children: [
                      Container(
                        child: Image.asset("assets/images/User User.png"),
                        decoration: BoxDecoration(
                          border: Border.all(
                            color:
                                widget.globalVar.selected_role_onboarding == '1'
                                    ? Colors.black
                                    : Colors.transparent,
                            width: 2,
                          ),
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      const Text(
                        "Pengguna",
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
          ],
        ),
      ),
    );
  }
}
