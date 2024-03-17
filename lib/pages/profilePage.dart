import 'package:provider/provider.dart';
import 'package:tratour/components/imageViewer.dart';
import 'package:tratour/database/auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:tratour/globalVar.dart';
import 'package:tratour/pages/editprofilepage.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<GlobalVar>(
      builder: (context, globalVar, _) {

        return ProfilePageContent();
        // The rest of your code remains the same
      },
    );
  }
}

class ProfilePageContent extends StatelessWidget {
  ProfilePageContent({Key? key}) : super(key: key);

  final Auth _signOut = Auth();

  @override
  Widget build(BuildContext context) {
    return Consumer<GlobalVar>(
      builder: (context, globalVar, _) {
        Map<String, dynamic> userData = globalVar.userLoginData ?? {};

        return Scaffold(
       
          body: SingleChildScrollView(
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Container(
                    padding: EdgeInsets.all(20),
                    height: 120,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        // Profile Picture
                        Row(
                          children: [
                            InkWell(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => MyImageViewer(
                                      profilePhoto: userData['profile_image'] ??
                                          'https://firebasestorage.googleapis.com/v0/b/tra-tour.appspot.com/o/default_profile_image.png?alt=media&token=83bb623d-473f-4c5e-93c3-ecc3fc5f915b',
                                    ),
                                  ),
                                );
                              },
                              child: CircleAvatar(
                                radius: 42,
                                backgroundImage: NetworkImage(
                                  userData['profile_image'] ??
                                      'https://firebasestorage.googleapis.com/v0/b/tra-tour.appspot.com/o/default_profile_image.png?alt=media&token=83bb623d-473f-4c5e-93c3-ecc3fc5f915b',
                                ),
                              ),
                            ),
                            const SizedBox(
                              width: 20,
                            ),
                            // Name

                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  userData['username'] ?? '',
                                  style: const TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold),
                                ),
                                Text(
                                  userData['email'] ?? '',
                                  style: const TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w400),
                                ),
                              ],
                            ),
                          ],
                        ),
                        Container(
                          height: 28,
                          width: 28,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(50),
                              color: GlobalVar.baseColor),
                          child: IconButton(
                            padding: EdgeInsets.zero,
                            constraints: BoxConstraints(),
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => EditProfilePage(),
                                ),
                              );
                            },
                            icon: Icon(
                              Icons.edit,
                              size: 14,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "Referral Code & Point",
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: Container(
                                height: 155,
                                decoration: BoxDecoration(
                                  color: GlobalVar.baseColor,
                                  borderRadius: const BorderRadius.all(
                                    Radius.circular(15),
                                  ),
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(10),
                                      child: Container(
                                        width: 25,
                                        height: 25,
                                        decoration: BoxDecoration(
                                          color: GlobalVar.secondaryColor,
                                          shape: BoxShape.circle,
                                        ),
                                        child: Center(
                                          child: Text(
                                            "P",
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ),
                                      ),
                                    ),
                                    Center(
                                      child: Text(
                                        userData['user_point'] ??
                                            'Terjadi kesalahan',
                                        style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                    Center(
                                      child: Text(
                                        "Poin",
                                        style: TextStyle(
                                          fontSize: 12,
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            SizedBox(width: 10), // Spacer
                            Expanded(
                              child: Container(
                                height: 155,
                                decoration: BoxDecoration(
                                  color: GlobalVar.baseColor,
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(15),
                                  ),
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(10),
                                      child: Container(
                                        child: Icon(Icons.confirmation_number),
                                      ),
                                    ),
                                    GestureDetector(
                                      onTap: () async {
                                        await Clipboard.setData(ClipboardData(
                                            text: userData['referral_code'] ??
                                                ''));
                                        // copied successfully
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(
                                          SnackBar(
                                            content: Text(
                                                'Referral code copied to clipboard'),
                                          ),
                                        );
                                      },
                                      child: Center(
                                        child: Text(
                                          userData['referral_code'] ?? '',
                                          style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                    ),
                                    Center(
                                      child: Text(
                                        "Referral Code",
                                        style: TextStyle(
                                          fontSize: 12,
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 10,
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

                  // General Section
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "General",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                          ),
                        ),
                        GestureDetector(
                          onTap: () {},
                          child: Container(
                            height: 45,
                            decoration: const BoxDecoration(
                              color: GlobalVar.baseColor,
                              borderRadius: BorderRadius.all(
                                Radius.circular(12),
                              ),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: const [
                                Row(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 8),
                                      child: Icon(Icons.notifications_outlined),
                                    ),
                                    Text(
                                      "Notifikasi",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ],
                                ),
                                Padding(
                                  padding:
                                      const EdgeInsets.symmetric(horizontal: 8),
                                  child: Icon(Icons.navigate_next),
                                ),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        GestureDetector(
                          onTap: () {},
                          child: Container(
                            height: 45,
                            decoration: BoxDecoration(
                              color: GlobalVar.baseColor,
                              borderRadius: BorderRadius.all(
                                Radius.circular(12),
                              ),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: const [
                                Row(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 8),
                                      child: Icon(Icons.settings),
                                    ),
                                    Text(
                                      "Pengaturan",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ],
                                ),
                                Padding(
                                  padding:
                                      const EdgeInsets.symmetric(horizontal: 8),
                                  child: Icon(Icons.navigate_next),
                                ),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        GestureDetector(
                          onTap: () {},
                          child: Container(
                            height: 45,
                            decoration: BoxDecoration(
                              color: GlobalVar.baseColor,
                              borderRadius: BorderRadius.all(
                                Radius.circular(12),
                              ),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: const [
                                Row(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 8),
                                      child: Icon(Icons.info_outline),
                                    ),
                                    Text(
                                      "Bantuan",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ],
                                ),
                                Padding(
                                  padding:
                                      const EdgeInsets.symmetric(horizontal: 8),
                                  child: Icon(Icons.navigate_next),
                                ),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        GestureDetector(
                          onTap: () {},
                          child: Container(
                            height: 45,
                            decoration: BoxDecoration(
                              color: GlobalVar.baseColor,
                              borderRadius: BorderRadius.all(
                                Radius.circular(12),
                              ),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: const [
                                Row(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 8),
                                      child: Icon(Icons.star),
                                    ),
                                    Text(
                                      "Beri Bintang",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ],
                                ),
                                Padding(
                                  padding:
                                      const EdgeInsets.symmetric(horizontal: 8),
                                  child: Icon(Icons.navigate_next),
                                ),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        GestureDetector(
                          onTap: () {
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  title: Text('Konfirmasi'),
                                  content:
                                      Text('Apakah Anda yakin ingin keluar?'),
                                  actions: <Widget>[
                                    TextButton(
                                      onPressed: () {
                                        Navigator.of(context)
                                            .pop(); // Tutup dialog
                                      },
                                      child: Text('Batal'),
                                    ),
                                    ElevatedButton(
                                      onPressed: () {
                                        _signOut.signOut(
                                            context); // Panggil metode signOut dari instance Auth
                                        Navigator.of(context)
                                            .pop(); // Tutup dialog
                                      },
                                      child: Text('Keluar'),
                                    ),
                                  ],
                                );
                              },
                            );
                          },
                          child: Container(
                            height: 45,
                            decoration: BoxDecoration(
                              color: GlobalVar.baseColor,
                              borderRadius: BorderRadius.all(
                                Radius.circular(12),
                              ),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: const [
                                Row(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 8),
                                      child: Icon(
                                        Icons.logout,
                                        color: Colors.red,
                                      ),
                                    ),
                                    Text(
                                      "Keluar",
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
