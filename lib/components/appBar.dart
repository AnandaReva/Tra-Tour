import 'package:aplikasi_sampah/globalVar.dart';
import 'package:flutter/material.dart';

class MyAppBar extends StatelessWidget implements PreferredSizeWidget {
  const MyAppBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    GlobalVar globalVar =
        GlobalVar.instance; // Mendapatkan instance dari GlobalVar

    Map<String, dynamic> userData = globalVar.userLoginData ?? {};

    String username = userData['username'] ?? '';
   String? profileImage = userData['profile_image'];

    return AppBar(
      backgroundColor: GlobalVar.mainColor,
      title: Padding(
        padding: EdgeInsets.only(top: 15, bottom: 15),
        child: Row(
          children: [
            Padding(
              padding: EdgeInsets.only(right: 8.0),
              child: CircleAvatar(
                radius: 24,
                // Gunakan profile_image
                backgroundImage: profileImage != null
                    ? NetworkImage(profileImage)
                    : AssetImage('assets/default_profile_image.png')
                        as ImageProvider,
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  // Gunakan username
                  username,
                  style: const TextStyle(
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
