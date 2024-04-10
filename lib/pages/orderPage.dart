import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tratour/components/appBar.dart';
import 'package:tratour/globalVar.dart';
import 'package:tratour/pages/orderDataList.dart';

// ignore: must_be_immutable
class OrderPage extends StatelessWidget {
  OrderPage({Key? key}) : super(key: key);
  GlobalVar globalVar = GlobalVar.instance;

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: GlobalVar.instance,
      child: Scaffold(
        appBar: const MyAppBar(),
        body: _buildBody(context),
      ),
    );
  }

  Widget _buildBody(BuildContext context) {
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
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 6,
                          ),
                          Text(
                            'Status Pengangkutan',
                            style: TextStyle(fontSize: 10),
                          ),
                        ],
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => const OrderListDetail(),
                            ),
                          );
                        },
                        child: Text(
                          'Rincian Pesanan >',
                          style: TextStyle(
                            fontSize: 10,
                            color: Colors.blue,
                          ),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
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
      child: Column(
        children: [
          // Tab bar
          Container(
            height: 50,
            width: double.infinity,
            color: Color(0xffE6E6E6),
            child: const TabBar(
              tabs: [
                Tab(
                  text: 'Sedang Berlangsung',
                ),
                Tab(
                  text: 'Telah Selesai',
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
                        decoration: const BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage('assets/images/trash.png'),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      // Tambahkan widget SingleChildScrollView di sini

                      SingleChildScrollView(
                        child: Consumer<GlobalVar>(
                          builder: (context, globalVar, child) {
                            return globalVar.currentOrderData != null
                                ? Column(
                                    children: [
                                      Text('${globalVar.currentPickUpData}'),
                                      Text('${globalVar.currentOrderData}'),
                                      Text('${globalVar.currentSweeperData}'),
                                    ],
                                  )
                                : const Text(
                                    'Sampah dan barang bekas kamu mulai\nmenumpuk nih! Ayo ubah sampah dan\nbarang bekasmu menjadi barang\nberharga',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  );
                          },
                        ),
                      ),
                    ],
                  ),
                ),

                // Telah selesai page view nya
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
      ),
    );
  }
}
