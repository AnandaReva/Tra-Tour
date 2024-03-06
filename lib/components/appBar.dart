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
    var username = 'Rakesh Braman'; //globalVar.userLogindata?[0]['username'];
    var biography = globalVar.userLogindata?[0]['biography'];
    var profilePhotoUrl;
    // globalVar.userLogindata?[0]['profilePhoto'];

    print('status login2222: ${globalVar.isLogin}');
    print('Welcome222   ${globalVar.userLogindata}');

    return AppBar(
      backgroundColor: GlobalVar.mainColor,
      title: const Padding(
        padding: EdgeInsets.only(top: 15, bottom: 15),
        child: Row(
          children: [
            Padding(
              padding: EdgeInsets.only(right: 8.0),
              child: CircleAvatar(
                radius: 24,
                backgroundImage: NetworkImage(
                  'https://firebasestorage.googleapis.com/v0/b/tra-tour.appspot.com/o/admin%2Fadmin_profile_picture.png?alt=media&token=2f101f86-e0d6-4cbb-aebe-faa4d37479d0',
                ),
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Hi, Rakesh Bramantyo',
                    style: TextStyle(
                        fontSize: 14.0,
                        color: GlobalVar.baseColor,
                        fontWeight: FontWeight.bold)),
                Text('Newcomer',
                    style: TextStyle(
                        fontSize: 10.0,
                        color: GlobalVar.baseColor,
                        fontWeight: FontWeight.bold)),
              ],
            ),
          ],
        ),
      ),
      toolbarHeight: 80.2,
      actions: <Widget>[
        IconButton(
            onPressed: () {},
            icon: const Icon(
              color: GlobalVar.baseColor,
              Icons.notifications,
              size: 24,
            )),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}



/* 


AppBar(
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
    ); */
