import 'package:flutter/material.dart';
import 'package:tratour/components/custom_button.dart';
import 'package:tratour/components/box_kategori.dart';

class SortTrash extends StatelessWidget {
  const SortTrash({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _buildBody(),
    );
  }

  _buildBody() {
    return Padding(
      padding: EdgeInsets.all(20),
      child: ListView(
        children: [
          subTitle(),
          kategori(),
          CustomButton(
            onPressed: () {

              
            },
            text: 'Atur Lokasi Pengambilan',
            margin: EdgeInsets.only(top: 30),
          )
        ],
      ),
    );
  }

  Widget subTitle() {
    return Container(
      margin: EdgeInsets.only(bottom: 24),
      child: Text(
        "Pilih jenis sampah dari kategori di bawah ini!",
        style: TextStyle(
          fontWeight: FontWeight.w600,
          fontSize: 11,
        ),
      ),
    );
  }

  Widget kategori() {
    return SingleChildScrollView(
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              BoxKategori(
                imageUrl: "assets/images/plastik.png",
                label: "Plastik",
                color: Color(0xff90CAF9),
                width: 101,
                height: 70,
              ),
              SizedBox(
                width: 16,
              ),
              BoxKategori(
                imageUrl: "assets/images/organik.png",
                label: "Organik",
                color: Color(0xff80B118),
                width: 90,
                height: 79,
              )
            ],
          ),
          SizedBox(
            height: 16,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              BoxKategori(
                imageUrl: "assets/images/minyak.png",
                label: "Minyak Goreng",
                color: Color(0xffFDD300),
                width: 29,
                height: 88,
              ),
              SizedBox(
                width: 16,
              ),
              BoxKategori(
                imageUrl: "assets/images/kardus.png",
                label: "Kardus",
                color: Color(0xffE47304),
                width: 88,
                height: 61,
              )
            ],
          ),
          SizedBox(
            height: 16,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              BoxKategori(
                imageUrl: "assets/images/elektronik.png",
                label: "Elektronik",
                color: Color(0xffBEBEBE),
                width: 84,
                height: 84,
              ),
              SizedBox(
                width: 16,
              ),
              BoxKategori(
                imageUrl: "assets/images/pakaian.png",
                label: "Pakaian",
                color: Color(0xff409B81),
                width: 109,
                height: 76,
              )
            ],
          ),
        ],
      ),
    );
  }
}
