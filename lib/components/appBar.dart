// ignore: file_names
import 'package:aplikasi_sampah/components/imageViewer.dart';
import 'package:aplikasi_sampah/components/loginPage.dart';
import 'package:aplikasi_sampah/components/profilePage.dart';
import 'package:aplikasi_sampah/globalVar.dart';
import 'package:flutter/material.dart';

class MyAppBar extends StatelessWidget implements PreferredSizeWidget {
  const MyAppBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    GlobalVar globalVar =
        GlobalVar.instance; // Mendapatkan instance dari GlobalVar
    var username = 'Rakesh Braman';//globalVar.userLogindata?[0]['username'];
    var biography = globalVar.userLogindata?[0]['biography'];
    var profilePhotoUrl = 'cth';
    // globalVar.userLogindata?[0]['profilePhoto'];

    print('status login2222: ${globalVar.isLogin}');
    print('Welcome222   ${globalVar.userLogindata}');

    return AppBar(
      backgroundColor: GlobalVar.mainColor,
      title:  Text(
       username,
        style: const TextStyle(
          color: Colors.white,
          fontFamily: 'Poppins-Bold',
          fontWeight: FontWeight.bold,
        ),
      ),
      actions: <Widget>[
        InkWell(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) =>
                      MyImageViewer(profilePhoto: profilePhotoUrl)),
            );
          },
          child: CircleAvatar(
            radius: 50,
            backgroundImage: NetworkImage(
              profilePhotoUrl,
            ),
          ),
        ),
      
      ],
      iconTheme: const IconThemeData(color: Colors.white),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
