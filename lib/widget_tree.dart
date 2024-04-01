import 'package:tratour/pages/login_register_page.dart';
import 'package:tratour/database/auth.dart';
import 'package:tratour/globalVar.dart';
import 'package:tratour/main.dart';

import 'package:flutter/material.dart';

class WidgetTree extends StatefulWidget {
  const WidgetTree({Key? key, required GlobalVar globalVar}) : super(key: key);

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
          globalVar.isLogin = true;

          return MainPage();
        } else {
          return LoginPage(
            globalVar: globalVar,
          );
        }
      },
    );
  }
}
