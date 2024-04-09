import 'package:flutter/material.dart';
import 'package:tratour/components/appBar.dart';
import 'package:tratour/globalVar.dart';
import 'package:tratour/pages/editprofilepage.dart';

class FindOrderPage extends StatelessWidget {
  final GlobalVar globalVar;

  FindOrderPage({Key? key, required this.globalVar}) : super(key: key);

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
      // Tambahkan logika yang sesuai di sini
      return Scaffold(
        appBar: MyAppBar(),
        body: Center(
          child: Text('Tampilkan widget sesuai dengan kebutuhan'),
        ),
      );
    }
  }

  Widget buildWideLayout() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          width: 140,
          height: 140,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/images/address_logo.png'),
              fit: BoxFit.cover,
            ),
          ),
        ),
        SizedBox(width: 30),
        Expanded(
          child: Text(
            'Data alamat harus diisi sebelum mencari pesanan',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 14, fontWeight: FontWeight.w700),
          ),
        ),
      ],
    );
  }

  Widget buildNormalLayout(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          width: 140,
          height: 140,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/images/address_logo.png'),
              fit: BoxFit.cover,
            ),
          ),
        ),
        SizedBox(height: 30),
        Text(
          'Data alamat harus diisi sebelum mencari pesanan!',
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
