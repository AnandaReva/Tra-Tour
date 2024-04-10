import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import 'package:tratour/components/appBar.dart';
import 'package:tratour/components/customCheckBox.dart';

import 'package:tratour/globalVar.dart';
import 'package:tratour/pages/editprofilepage.dart';
import 'package:tratour/pages/sweeper/findOrderAvailable.dart';


// ignore: must_be_immutable
class SortTrashPage extends StatelessWidget {
  SortTrashPage({Key? key, required GlobalVar globalVar}) : super(key: key);

  GlobalVar globalVar = GlobalVar.instance;

  @override
  Widget build(BuildContext context) {
    if (globalVar.userLoginData == null ||
        globalVar.userLoginData['address'] == null ||
        globalVar.userLoginData['address'] == '') {
      // Tampilkan widget jika data login belum tersedia atau alamat kosong
      return Scaffold(
        appBar: MyAppBar(),
        body: Builder(
          builder: (BuildContext context) {
            return Center(
              child: SingleChildScrollView(
                child: MediaQuery.of(context).size.width > 600
                    ? buildWideLayout()
                    : buildNormalLayout(context),
              ),
            );
          },
        ),
      );
    } else {
      // Tampilkan widget jika data login sudah tersedia dan alamat tidak kosong
      if (globalVar.userLoginData['user_type'] == '1') {
        //user
        return ChangeNotifierProvider<CheckboxProvider>(
          create: (context) => CheckboxProvider(),
          child: Scaffold(
            appBar: const MyAppBar(),
            body: SingleChildScrollView(
              padding: const EdgeInsets.all(20),
              child: SizedBox(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                child: ChecBoxImages(),
              ),
            ),
          ),
        );
      } else if (globalVar.userLoginData['user_type'] == '2') {
        //sweeper
        return Scaffold(
          appBar: MyAppBar(),
          body: Container(
            height: MediaQuery.of(context)
                .size
                .height, // Set the height to the full height of the screen
            child: SingleChildScrollView(
              physics: AlwaysScrollableScrollPhysics(),
              child:  Text('Saat Ini Belum Ada'),
              
              /* FindOrderAvailabales(), */
            ),
          ),
        );
      } else if (globalVar.userLoginData['user_type'] == '3') {
        //waste collector
        return const Scaffold(
          appBar: const MyAppBar(),
          body: Center(
            child: Text('Saat Ini Belum Ada'),
          ),
        );
      } else {
        //not known
        // tampilkan pesan 'Terjadi Kesalahan'
        return const Scaffold(
          appBar: const MyAppBar(),
          body: Center(
            child: Text('Terjadi Kesalahan'),
          ),
        );
      }
    }
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
              image: AssetImage('assets/images/address_logo.png'),
              fit: BoxFit.cover,
            ),
          ),
        ),
        SizedBox(width: 30),
        const Text(
          'Data alamat harus diisi sebelum membuat pesanan',
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 14, fontWeight: FontWeight.w700),
        ),
        // Add more content as needed
      ],
    );
  }

  Widget buildNormalLayout(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        // Your content here
        Container(
          width: 140,
          height: 140,
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage(
                  'assets/images/address_logo.png'), // Assuming your image is in this path
              fit: BoxFit.cover,
            ),
          ),
        ),
        SizedBox(height: 30),
        const Text(
          'Data alamat harus diisi sebelum membuat pesanan!',
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 14, fontWeight: FontWeight.w700),
        ),
        SizedBox(height: 30),

        TextButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => EditProfilePage(),
              ),
            );
          },
          child: Text('Ubah Alamat'),
        ),
      ],
    );
  }
}
