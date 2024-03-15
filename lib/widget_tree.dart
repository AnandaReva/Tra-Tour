import 'package:tratour/pages/login_register_page.dart';
import 'package:tratour/database/auth.dart';
import 'package:tratour/globalVar.dart';
import 'package:tratour/main.dart';

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

/*             User? user = FirebaseAuth.instance.currentUser;
  if (user != null) {
    String userEmail = user.email ?? "";
    print("User email firebase: $userEmail");

    // Load user data
    await LoginPageState().findUserDataFromDB(userEmail);
    print('debug m1: ${globalVar.userLoginData}');

    // Build the app passing user data to RootPage
    runApp(MyApp(globalVar: globalVar, userData: globalVar.userLoginData));
  } */
          globalVar.isLogin = true;


          return MainPage(globalVar: globalVar);
        } else {
          return LoginPage(
            globalVar: globalVar,
          );
        }
      },
    );
  }
}
