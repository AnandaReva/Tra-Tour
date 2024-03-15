import 'package:flutter/material.dart';
import 'package:tratour_application/components/widgets/icon_tabs.dart';

import '../components/widgets/point.dart';

class VoucherPage extends StatelessWidget {
  const VoucherPage({super.key});

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
    return Padding(
      padding: EdgeInsets.all(20),
      child: Column(
        children: [
          point(),
          Divider(
            thickness: 1,
          ),
          isiUlang(),
          Divider(
            thickness: 1,
          ),
          bayarTagihan(),
          Divider(
            thickness: 1,
          ),
        ],
      ),
    );
  }

  Widget point() {
    return Point(
      text: '2000',
      margin: EdgeInsets.only(bottom: 24),
    );
  }

  Widget isiUlang() {
    return Container(
      margin: EdgeInsets.only(top: 30, bottom: 30),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Isi Ulang',
            style: TextStyle(
              fontWeight: FontWeight.w700,
            ),
          ),
          Row(
            children: [
              IconTabs(
                  icon: 'assets/images/icon_pulsa.png',
                  label: 'Pulsa\nPrabayar'),
              SizedBox(
                width: 48,
              ),
              IconTabs(
                  icon: 'assets/images/icon_data.png', label: 'Paket\nData'),
              SizedBox(
                width: 48,
              ),
              IconTabs(
                  icon: 'assets/images/icon_listrik.png',
                  label: 'Voucher\nlistrik'),
            ],
          )
        ],
      ),
    );
  }

  Widget bayarTagihan() {
    return Container(
      margin: EdgeInsets.only(top: 30, bottom: 30),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Bayar Tagihan',
            style: TextStyle(
              fontWeight: FontWeight.w700,
            ),
          ),
          Row(
            children: [
              IconTabs(
                  icon: 'assets/images/icon_pln.png',
                  label: 'Tagihan\nPLN'),
              SizedBox(
                width: 48,
              ),
              IconTabs(
                  icon: 'assets/images/icon_bpjs.png', label: 'Tagihan\nBPJS'),
              SizedBox(
                width: 48,
              ),
              IconTabs(
                  icon: 'assets/images/icon_pdam.png',
                  label: 'Tagihan\nPDAM'),
            ],
          )
        ],
      ),
    );
  }

}
