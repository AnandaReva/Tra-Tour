import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:tratour_application/model/articles_model.dart';

class Home extends StatefulWidget {
  Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _selectedIndex = 0;
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  List<ArticlesModel> articles = [];

  void _getInfo() {
    articles = ArticlesModel.getArticles();
  }

  @override
  Widget build(BuildContext context) {
    _getInfo();
    return Scaffold(
      appBar: appBar(),
      body: ListView(
        children: [
          // Poin kamu
          _poinSection(),

          // Voucher
          _voucherSection(),

          // Artikel Pilihan1
          _artikelPilihan(),

          // Artikel Pilihan2
          _artikelPilihan(),
        ],
      ),
      bottomNavigationBar: _bottomNavigationBar(),
    );
  }

  BottomNavigationBar _bottomNavigationBar() {
    return BottomNavigationBar(
      items: const <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: Icon(
            Icons.home,
            size: 25,
          ),
          label: 'Beranda',
        ),
        BottomNavigationBarItem(
          icon: Icon(
            Icons.reorder,
            size: 25,
          ),
          label: 'Pesanan',
        ),
        BottomNavigationBarItem(
          icon: Icon(
            Icons.add_circle,
            size: 25,
          ),
          label: 'Tambah',
        ),
        // BottomNavigationBarItem(
        //   icon: Icon(
        //     Icons.groups,
        //     size: 25,
        //   ),
        //   label: 'Social',
        // ),
        // BottomNavigationBarItem(
        //   icon: Icon(
        //     Icons.person,
        //     size: 25,
        //   ),
        //   label: 'Profil',
        // ),
      ],
      currentIndex: _selectedIndex,
      selectedItemColor: Colors.blue.shade900,
      unselectedItemColor: Colors.black,
      onTap: _onItemTapped,
    );
  }

  Padding _artikelPilihan() {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Text(
                  "Artikel Pilihan",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'PTSans',
                  ),
                ),
                Icon(
                  Icons.chevron_right,
                  size: 16,
                ),
              ],
            ),
          ),
          Container(
            height: 185,
            decoration: BoxDecoration(
              border: Border.all(color: Colors.red),
            ),
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                return Container(
                  width: 152,
                  decoration: BoxDecoration(
                    color: Colors.grey,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(15),
                      topRight: Radius.circular(15),
                    ),
                  ),
                  child: Column(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.all(
                          Radius.circular(10),
                        ),
                        child: Image.asset(
                          articles[index].articleImage,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              articles[index].title,
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 12,
                                fontFamily: 'PTSans',
                              ),
                            ),
                            Row(
                              children: [
                                Icon(
                                  Icons.calendar_month,
                                  size: 12,
                                ),
                                Text(
                                  articles[index].date,
                                  style: TextStyle(fontSize: 8),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 15,
                            ),
                            Text(
                              articles[index].description,
                              style: TextStyle(
                                fontSize: 10,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              },
              separatorBuilder: (context, index) => SizedBox(width: 25),
              itemCount: articles.length,
            ),
          ),
        ],
      ),
    );
  }

  Padding _voucherSection() {
    return Padding(
      padding: const EdgeInsets.only(left: 15, right: 15, bottom: 15),
      child: Container(
        width: 320,
        height: 149,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Voucher',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'PTSans',
                    ),
                  ),
                  Text(
                    'Total poin kamu dapat ditukarkan dengan voucher dibawah ini loh!',
                    style: TextStyle(
                      fontSize: 10,
                      fontFamily: 'PTSans',
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment
                    .spaceAround, // Memberikan ruang sekitar setiap child
                children: [
                  Column(
                    children: [
                      IconButton(
                        onPressed: () {},
                        icon: Icon(Icons.smartphone),
                      ),
                      RichText(
                        textAlign: TextAlign.center,
                        text: TextSpan(
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 10.0,
                            fontFamily: 'PTSans',
                          ),
                          children: <TextSpan>[
                            TextSpan(
                              text: 'Pulsa \n',
                            ),
                            TextSpan(
                              text: 'Prabayar',
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      IconButton(
                        onPressed: () {},
                        icon: Icon(Icons.wifi),
                      ),
                      RichText(
                        textAlign: TextAlign.center,
                        text: TextSpan(
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 10.0,
                            fontFamily: 'PTSans',
                          ),
                          children: <TextSpan>[
                            TextSpan(
                              text: 'Paket\n',
                            ),
                            TextSpan(
                              text: 'Data',
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      IconButton(
                        onPressed: () {},
                        icon: Icon(Icons.bolt),
                      ),
                      RichText(
                        textAlign: TextAlign.center,
                        text: TextSpan(
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 10.0,
                            fontFamily: 'PTSans',
                          ),
                          children: <TextSpan>[
                            TextSpan(
                              text: 'Voucher \n',
                            ),
                            TextSpan(
                              text: 'Listrik',
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      IconButton(
                        onPressed: () {},
                        icon: Icon(Icons.arrow_right_alt),
                      ),
                      RichText(
                        textAlign: TextAlign.center,
                        text: TextSpan(
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 10.0,
                            fontFamily: 'PTSans',
                          ),
                          children: <TextSpan>[
                            TextSpan(
                              text: 'Voucher \n',
                            ),
                            TextSpan(
                              text: 'Lainnya',
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
        decoration: BoxDecoration(
            color: Colors.amber,
            borderRadius: BorderRadius.all(Radius.circular(4))),
      ),
    );
  }

  Padding _poinSection() {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: Container(
        width: 320,
        height: 70,
        decoration: const BoxDecoration(
            color: Colors.amber,
            borderRadius: BorderRadius.all(Radius.circular(4))),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                'Poin Kamu',
                style: TextStyle(
                  fontFamily: 'PTSans',
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 8.0),
                  child: Text(
                    'Total Poin Anda: ',
                    style: TextStyle(
                      fontSize: 14,
                      fontFamily: 'PTSans',
                    ),
                  ),
                ),
                Expanded(
                  child: Center(
                    child: RichText(
                      text: TextSpan(
                        style: TextStyle(color: Colors.black),
                        children: const <TextSpan>[
                          TextSpan(
                            text: '10000',
                            style: TextStyle(
                              fontSize: 14,
                              fontFamily: 'PTSans',
                            ),
                          ),
                          TextSpan(
                            text: ' Poin',
                            style: TextStyle(
                              fontSize: 10,
                              fontFamily: 'PTSans',
                            ),
                          ),
                        ],
                      ),
                    ),
                    // child: Text(
                    //   '10000 Poin',
                    //   style: TextStyle(fontSize: 14),
                    // ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  AppBar appBar() {
    return AppBar(
      title: const Padding(
        padding: EdgeInsets.only(top: 15, bottom: 15),
        child: Row(
          children: [
            Padding(
              padding: EdgeInsets.only(right: 8.0),
              child: CircleAvatar(
                radius: 24,
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Hi, Rakesh Bramantyo',
                    style:
                        TextStyle(fontSize: 14.0, fontWeight: FontWeight.bold)),
                Text('Newcomer',
                    style: TextStyle(
                        fontSize: 10.0, color: Color.fromRGBO(0, 0, 0, 0.6))),
              ],
            ),
          ],
        ),
      ),
      toolbarHeight: 80.2,
      actions: <Widget>[
        IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.notifications,
              size: 24,
            )),
      ],
    );
  }
}
