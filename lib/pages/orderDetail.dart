import 'package:flutter/material.dart';
import 'package:tratour/components/stepper.dart';

class OrderDetail extends StatelessWidget {
  const OrderDetail({super.key});

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
        'Rincian Pesanan',
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
      child: ListView(
        children: <Widget>[
          profile(),
          SizedBox(
            height: 15,
          ),
          Divider(
            thickness: 1,
            color: Colors.black,
          ),
          contact(),
          Divider(
            thickness: 1,
            color: Colors.black,
          ),
          StepperPickUp(),
          Divider(
            thickness: 1,
            color: Colors.black,
          ),
          detailPendapatan(),
        ],
      ),
    );
  }

  Widget profile() {
    return Row(
      children: [
        Container(
          width: 42,
          height: 42,
          decoration: BoxDecoration(
            color: Colors.grey,
          ),
        ),
        SizedBox(
          width: 6,
        ),
        Text(
          'Logo',
          style: TextStyle(
            fontWeight: FontWeight.w700,
            fontSize: 14,
          ),
        ),
        Expanded(
            child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(
              'Date',
              style: TextStyle(
                fontWeight: FontWeight.w400,
                fontSize: 10,
              ),
            ),
            SizedBox(
              height: 11,
            ),
            Text(
              'Kode Pesanan',
              style: TextStyle(
                fontWeight: FontWeight.w400,
                fontSize: 10,
              ),
            )
          ],
        ))
      ],
    );
  }

  Widget contact() {
    return Padding(
      padding: EdgeInsets.only(top: 20, bottom: 20),
      child: Container(
        child: Row(
          children: [
            Container(
              width: 56,
              height: 56,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(100),
                color: Colors.grey,
              ),
            ),
            SizedBox(
              width: 8,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Wawan',
                  style: TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: 14,
                  ),
                ),
                SizedBox(
                  height: 12,
                ),
                Text(
                  'Truck | B01293',
                  style: TextStyle(
                    fontWeight: FontWeight.w400,
                    fontSize: 14,
                  ),
                )
              ],
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: <Widget>[
                  Icon(
                    Icons.chat_bubble,
                    color: Color(0xff6FD73E),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget detailPendapatan() {
    Widget listPendapatan(String label, String price) {
      return Padding(
        padding: EdgeInsets.all(5),
        child: Row(
          children: [
            Container(
              width: 24,
              height: 24,
              decoration: BoxDecoration(
                  color: Color(0xffFBBC05),
                  borderRadius: BorderRadius.circular(100)),
              child: Center(
                child: Text(
                  'P',
                  style: TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: 12,
                  ),
                ),
              ),
            ),
            SizedBox(
              width: 16,
            ),
            Expanded(
                child: Flex(
              direction: Axis.horizontal,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  label,
                  style: TextStyle(fontWeight: FontWeight.w600, fontSize: 12),
                ),
                Text(
                  price,
                  style: TextStyle(fontWeight: FontWeight.w600, fontSize: 12),
                )
              ],
            )),
          ],
        ),
      );
    }

    List<Widget> Pendapatans = [
      listPendapatan("Akumulasi Sampah", "2.000"),
      listPendapatan("Biaya Admin", "-1.000"),
      listPendapatan("Biaya Admin", "-500"),
    ];

    return Padding(
      padding: EdgeInsets.only(top: 20, bottom: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Detail Pendapatan',
            style: TextStyle(
              fontWeight: FontWeight.w700,
              fontSize: 14,
            ),
          ),
          SizedBox(
            height: 15,
          ),
          Column(
            children: Pendapatans,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Icon(
                Icons.add,
                size: 12,
              ),
              Divider(
                thickness: 2,
                color: Colors.black,
              )
            ],
          ),
          listPendapatan("Total Pendapatan", "500"),
        ],
      ),
    );
  }
}
