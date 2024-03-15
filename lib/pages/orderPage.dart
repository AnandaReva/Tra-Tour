// ignore_for_file: prefer_const_constructors
import 'package:flutter/material.dart';
import 'package:tratour/pages/orderDetail.dart';

class OrderPage extends StatefulWidget {
  const OrderPage({Key? key}) : super(key: key);

  @override
  State<OrderPage> createState() => _OrderPage();
}

class _OrderPage extends State<OrderPage> {
  @override
  Widget build(BuildContext context) {
    // satu baris pesanan
    Widget pesanan() {
      return Container(
        margin: EdgeInsets.only(top: 16),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 68.42,
              height: 66,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                color: Colors.grey,
              ),
            ),
            SizedBox(
              width: 10,
            ),
            Expanded(
                child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Lokasi',
                  style: TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: 14,
                  ),
                ),
                Text(
                  'Date',
                  style: TextStyle(
                    fontSize: 10,
                    color: Colors.grey,
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Container(
                          width: 12,
                          height: 12,
                          decoration: BoxDecoration(
                              image: DecorationImage(
                            image: AssetImage('assets/images/check.png'),
                            fit: BoxFit.cover,
                          )),
                        ),
                        SizedBox(
                          width: 6,
                        ),
                        Text(
                          'Status Peangkutan',
                          style: TextStyle(fontSize: 10),
                        ),
                      ],
                    ),
                    TextButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const OrderDetail()),
                          );
                        },
                        child: Text(
                          'Rincian Pesanan >',
                          style: TextStyle(
                            fontSize: 10,
                            color: Colors.blue,
                          ),
                        ))
                  ],
                )
              ],
            ))
          ],
        ),
      );
    }

    // ini buat banyakin tampilan pesanan jadi ada 10 pesanan
    List<Widget> listPesanan = [];
    for (int i = 0; i < 10; i++) {
      listPesanan.add(pesanan());
    }

    return DefaultTabController(
        length: 2,
        child: Scaffold(
            body: Column(
          children: [
            // Tab bar
            Container(
              height: 50,
              width: double.infinity,
              color: Color(0xffE6E6E6),
              child: TabBar(
                tabs: [
                  Tab(
                    text: 'Sedang Berlangsung',
                  ),
                  Tab(
                    text: 'Telah Selesei',
                  )
                ],
              ),
            ),

            // TabBar view nya
            Expanded(  
              child: TabBarView(
                children: [
                  // sedang berlangsung
                  Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          width: 140,
                          height: 140,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: AssetImage('assets/images/trash.png'),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      
                          // Tambahkan widget SingleChildScrollView di sini
                        Text(
                            'Sampah dan barang bekas kamu mulai\nmenumpuk nih! Ayo ubah sampah dan\nbarang bekasmu menjadi barang\nberharga',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                       
                      ],
                    ),
                  ),

                  // Telah selesei page view nya
                  Center(
                    child: Padding(
                      padding: EdgeInsets.all(20),
                      child: ListView(
                        children: listPesanan,
                      ),
                    ),
                  )
                ],
              ),
            ),
          ],
        )));
  }
}
