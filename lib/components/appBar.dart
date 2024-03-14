import 'package:tratour/globalVar.dart';
import 'package:flutter/material.dart';

class MyAppBar extends StatelessWidget implements PreferredSizeWidget {
  const MyAppBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    GlobalVar globalVar =
        GlobalVar.instance; // Mendapatkan instance dari GlobalVar

    Map<String, dynamic> userData = globalVar.userLoginData ?? {};

    String user_type = userData['user_type'] ?? '';
    String getUserRole(String user_type) {
      switch (user_type) {
        case "1":
          return "Pemakai";
        case "2":
          return "Petugas pengangkut";
        case "3":
          return "Pengepul";
        default:
          return "Role tidak diketahui";
      }
    }

    String role = getUserRole(user_type);
    print("Role: $role");

   
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
                backgroundImage: NetworkImage(userData['profile_image'] ??
        'https://firebasestorage.googleapis.com/v0/b/tra-tour.appspot.com/o/default_profile_image.png?alt=media&token=83bb623d-473f-4c5e-93c3-ecc3fc5f915b'),
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  // Gunakan username
                  userData['username'] ?? '',
                  style: const TextStyle(
                      fontSize: 14.0,
                      color: GlobalVar.baseColor,
                      fontWeight: FontWeight.bold),
                ),
                Text(
                  role,
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
