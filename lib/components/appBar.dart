import 'package:provider/provider.dart';
import 'package:tratour/globalVar.dart';
import 'package:flutter/material.dart';

class MyAppBar extends StatelessWidget implements PreferredSizeWidget {
  const MyAppBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<GlobalVar>(
      builder: (context, globalVar, _) {
        Map<String, dynamic> userData = globalVar.userLoginData ?? {};

        String user_type = userData['user_type'] ?? '';
        String role = getUserRole(user_type);
        print("Role: $role");

        return AppBar(
          toolbarHeight: 80,
          leadingWidth: 75,
          leading: Padding(
            padding: EdgeInsets.only(left: 20),
            child: CircleAvatar(
              radius: 24,
              backgroundImage: NetworkImage(userData['profile_image'] ??
                  'https://firebasestorage.googleapis.com/v0/b/tra-tour.appspot.com/o/default_profile_image.png?alt=media&token=83bb623d-473f-4c5e-93c3-ecc3fc5f915b'),
            ),
          ),
          title: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(userData['username'] ?? '',
                  style: const TextStyle(
                      fontSize: 16, fontWeight: FontWeight.bold)),
              Text(role,
                  style: const TextStyle(
                      fontSize: 12, color: Color.fromRGBO(0, 0, 0, 0.6))),
            ],
          ),
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 20),
              child: IconButton(
                onPressed: () {},
                icon: const Icon(
                  Icons.notifications,
                  size: 28,
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  String getUserRole(String user_type) {
    switch (user_type) {
      case "1":
        return "Pengguna";
      case "2":
        return "Petugas pengangkut";
      case "3":
        return "Pengepul";
      default:
        return "Role tidak diketahui";
    }
  }
}
