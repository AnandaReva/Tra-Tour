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
                    Opacity(
                      opacity: widget.globalVar.selected_role_onboarding == '3'
                          ? 0.5
                          : 1.0,
                      child: Image.asset("assets/images/User Pengepul.png"),
                    ),
                    Text(
                      "Pengepul",
                      style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                        color: widget.globalVar.selected_role_onboarding == '3'
                            ? GlobalVar.secondaryColor
                            : Colors.white,
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
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      setState(() {
                        widget.globalVar.selected_role_onboarding = '2';
                        print(
                            "Pengangkut : ${widget.globalVar.selected_role_onboarding}");
                      });
                    },
                    child: Column(
                      children: [
                        Opacity(
                          opacity:
                              widget.globalVar.selected_role_onboarding == '2'
                                  ? 0.5
                                  : 1.0,
                          child: Image.asset("assets/images/User Pickuper.png"),
                        ),
                        Text(
                          "Pengangkut",
                          style: TextStyle(
                            fontSize: 30,
                            fontWeight: FontWeight.bold,
                            color:
                                widget.globalVar.selected_role_onboarding == '2'
                                    ? GlobalVar.secondaryColor
                                    : Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      setState(() {
                        widget.globalVar.selected_role_onboarding = '1';
                        print(
                            "Pengguna : ${widget.globalVar.selected_role_onboarding}");
                      });
                    },
                    child: Column(
                      children: [
                        Opacity(
                          opacity:
                              widget.globalVar.selected_role_onboarding == '1'
                                  ? 0.5
                                  : 1.0,
                          child: Image.asset("assets/images/User User.png"),
                        ),
                        Text(
                          "Pengguna",
                          style: TextStyle(
                            fontSize: 30,
                            fontWeight: FontWeight.bold,
                            color:
                                widget.globalVar.selected_role_onboarding == '1'
                                    ? GlobalVar.secondaryColor
                                    : Colors.white,
                          ),
                        ),
                      ],
                    ),
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
