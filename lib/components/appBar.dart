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

    // Mendapatkan data pengguna
    List<dynamic> userDataList = globalVar.userLoginData;

    // Atur nilai default untuk username dan profile image
    String username = '';
    String profile_image = '';

    // Periksa apakah userDataList tidak kosong sebelum mengakses indeksnya
    if (userDataList.isNotEmpty) {
      username = userDataList[0]['username'] ?? '';
      profile_image = userDataList[0]['profile_image'] ?? '';
    }

    return AppBar(
      backgroundColor: GlobalVar.mainColor,
      title: const Padding(
      title: Padding(
        padding: EdgeInsets.only(top: 15, bottom: 15),
        child: Row(
          children: [
            Padding(
              padding: EdgeInsets.only(right: 8.0),
              child: CircleAvatar(
                radius: 24,
                // Gunakan profile_image
                backgroundImage: NetworkImage(profile_image),
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  // Gunakan username
                  username,
                  style: TextStyle(
                      fontSize: 14.0,
                      color: GlobalVar.baseColor,
                      fontWeight: FontWeight.bold),
                ),
                Text(
                  'Newcomer',
                  style: TextStyle(
                      fontSize: 10.0,
                      color: GlobalVar.baseColor,
                      fontWeight: FontWeight.bold),
                ),
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
          ),
        ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
