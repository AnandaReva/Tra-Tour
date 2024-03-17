import 'package:flutter/material.dart';
import 'package:tratour/components/appBar.dart';

class SocialPage extends StatefulWidget {
  const SocialPage({Key? key}) : super(key: key);

  @override
  State<SocialPage> createState() => _SocialPageState();
}

class _SocialPageState extends State<SocialPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(), // Tambahkan appbar di sini
      body: Builder(
        builder: (BuildContext context) {
          return Center(
            child: SingleChildScrollView(
              child: MediaQuery.of(context).size.width > 600
                  ? buildWideLayout()
                  : buildNormalLayout(),
            ),
          );
        },
      ),
    );
  }

  Widget buildWideLayout() {
  return Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      // Your content here
      Container(
        width: 140,
        height: 140,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/socialIcon.png'), // Assuming your image is in this path
            fit: BoxFit.cover,
          ),
        ),
      ),
      SizedBox(width: 30),
      const Text(
        'Fitur sosial saat ini belum tersedia, ayo bantu pengembang untuk mengembangkan fitur ini!',
        textAlign: TextAlign.center,
        style: TextStyle(fontSize: 14, fontWeight: FontWeight.w700),
      ),
      // Add more content as needed
    ],
  );
}

Widget buildNormalLayout() {
  return Column(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      // Your content here
      Container(
        width: 140,
        height: 140,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/socialIcon.png'), // Assuming your image is in this path
            fit: BoxFit.cover,
          ),
        ),
      ),
      SizedBox(height: 30),
      const Text(
        'Fitur sosial saat ini belum tersedia, ayo bantu pengembang untuk mengembangkan fitur ini!',
        textAlign: TextAlign.center,
        style: TextStyle(fontSize: 14, fontWeight: FontWeight.w700),
      ),
      // Add more content as needed
    ],
  );
}
}
