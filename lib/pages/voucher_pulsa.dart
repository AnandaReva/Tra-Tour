import 'package:flutter/material.dart';
import 'package:tratour_application/components/widgets/box_price_list.dart';
import 'package:tratour_application/components/widgets/custom_button.dart';

import '../components/widgets/point.dart';

class VoucherPulsa extends StatelessWidget {
  const VoucherPulsa({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppbar(context),
      body: _buildBody(),
    );
  }

  _buildAppbar(BuildContext context) {
    return AppBar(
      title: Text(
        'Voucher',
        style: TextStyle(
          fontWeight: FontWeight.w700,
          fontSize: 14,
        ),
      ),
      backgroundColor: Color(0xffA1A1A1),
      elevation: 0,
    );
  }

  _buildBody() {
    return ListView(
      children: [
        Padding(
          padding: EdgeInsets.all(20),
          child: Column(
            children: [
              point(),
              Divider(
                thickness: 1,
              ),
              inputNomor(),
              optionPulsa(),
              buttonKonfirmasi(),
            ],
          ),
        ),
      ],
    );
  }

  Widget point() {
    return Point(
      text: '2000',
      margin: EdgeInsets.only(bottom: 24),
    );
  }

  Widget inputNomor() {
    return Container(
      margin: EdgeInsets.only(top: 30, bottom: 30),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Nomor Ponsel',
            style: TextStyle(
              fontWeight: FontWeight.w700,
            ),
          ),
          SizedBox(height: 6,),
          Row(
            children: [
              Expanded(child: TextFormField(decoration: InputDecoration(
                hintText: "Masukkan nomor ponsel anda di sini",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                contentPadding: EdgeInsets.symmetric(vertical: 5, horizontal: 10)
              ),),),
              SizedBox(width: 16,),
              Icon(Icons.perm_contact_calendar_rounded),
            ],
          )
        ],
      ),
    );
  }

  Widget optionPulsa() {
    return Container(
      margin: EdgeInsets.only(top: 30, bottom: 30),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              BoxPriceList(item: '3000', harga: '5.000'),
              SizedBox(width: 16,),
              BoxPriceList(item: '5000', harga: '10.000'),
            ],
          ),
          SizedBox(height: 24,),
          Row(
            children: [
              BoxPriceList(item: '10000', harga: '25.000'),
              SizedBox(width: 16,),
              BoxPriceList(item: '20000', harga: '50.000'),
            ],
          ),
          SizedBox(height: 24,),
          Row(
            children: [
              BoxPriceList(item: '35000', harga: '100.000'),
              SizedBox(width: 16,),
              BoxPriceList(item: '50000', harga: '150.000'),
            ],
          ),
        ],
      ),
    );
  }

  Widget buttonKonfirmasi(){
    return Align(
      alignment: Alignment.bottomCenter,
      child: CustomButton(onPressed: (){}, text: "Konfirmasi", margin: EdgeInsets.only(bottom: 12, top: 30),),
    );
  }

}
