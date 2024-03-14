// ignore_for_file: prefer_const_constructors
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:tratour_application/model/articles_model.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});

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
          // Banner
          Padding(
            padding: EdgeInsets.all(20),
            child: Stack(
              clipBehavior: Clip.none,
              children: <Widget>[
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.180),
                        spreadRadius: 2,
                        blurRadius: 1,
                        offset: Offset(0, 0),
                      ), //BoxShadow
                    ],
                  ),
                  padding: EdgeInsets.all(8),
                  child: Row(
                    children: <Widget>[
                      Flexible(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              "Setor sampah bawa keuntungan",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 14,
                              ),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Text(
                              "Tukar sampah di rumahmu dengan reward menarik dari kami",
                              style: TextStyle(
                                fontSize: 12,
                              ),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        width: 100,
                      )
                    ],
                  ),
                ),
                Positioned(
                  child: Image.asset(
                    'assets/images/Homepage-removebg-preview.png',
                    scale: 0.92,
                  ),
                  top: -20,
                  right: 0,
                ),
              ],
            ),
          ),
          // Poin dan Voucher
          _poinSection(),
          // Artikel Pilihan1
          _artikelPilihan(),
        ],
      ),
    );
  }

  Padding _poinSection() {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        children: <Widget>[
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.all(8.0),
                child: Text(
                  'Poin Kamu',
                  style: TextStyle(
                    fontFamily: 'PTSans',
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Row(
                children: [
                  Padding(
                    padding: EdgeInsets.all(8.0),
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
                    ),
                  ),
                ],
              ),
            ],
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const <Widget>[
                    Text(
                      'Voucher',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'PTSans',
                      ),
                    ),
                    Text(
                      'Total poin kamu dapat ditukarkan dengan voucher dibawah ini loh!',
                      style: TextStyle(
                        fontSize: 14,
                        fontFamily: 'PTSans',
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.all(8.0),
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
                        Text(
                          "Pulsa\nPrabayar",
                          textAlign: TextAlign.center,
                          style: TextStyle(fontSize: 12, fontFamily: 'PTSans'),
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        IconButton(
                          onPressed: () {},
                          icon: Icon(Icons.wifi),
                        ),
                        Text(
                          "Paket\nData",
                          textAlign: TextAlign.center,
                          style: TextStyle(fontSize: 12, fontFamily: 'PTSans'),
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        IconButton(
                          onPressed: () {},
                          icon: Icon(Icons.bolt),
                        ),
                        Text(
                          "Voucher\nListrik",
                          textAlign: TextAlign.center,
                          style: TextStyle(fontSize: 12, fontFamily: 'PTSans'),
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        IconButton(
                          onPressed: () {},
                          icon: Icon(Icons.arrow_right_alt),
                        ),
                        Text(
                          "Voucher\nLainnya",
                          textAlign: TextAlign.center,
                          style: TextStyle(fontSize: 12, fontFamily: 'PTSans'),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Padding _artikelPilihan() {
    return Padding(
      padding: EdgeInsets.all(20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.all(8.0),
            child: Row(
              children: [
                Text(
                  "Artikel Pilihan",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'PTSans',
                  ),
                ),
                Icon(
                  Icons.chevron_right,
                  size: 20,
                ),
              ],
            ),
          ),
          SizedBox(
            height: 225,
            child: ListView.separated(
              separatorBuilder: (context, index) => SizedBox(width: 25),
              padding: EdgeInsets.only(
                left: 25,
                right: 25,
              ),
              itemCount: articles.length,
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                return Container(
                  width: 200,
                  decoration: BoxDecoration(
                    color: Colors.grey.shade200,
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
                        padding: EdgeInsets.all(8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              articles[index].title,
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 14,
                                fontFamily: 'PTSans',
                              ),
                            ),
                            Row(
                              children: [
                                Icon(
                                  Icons.calendar_month,
                                  size: 14,
                                ),
                                Text(
                                  articles[index].date,
                                  style: TextStyle(fontSize: 10),
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
            ),
          ),
        ],
      ),
    );
  }

  AppBar appBar() {
    return AppBar(
      toolbarHeight: 80,
      leadingWidth: 75,
      leading: Padding(
        padding: EdgeInsets.only(left: 20),
        child: CircleAvatar(
          radius: 24, // Atur radius sesuai keinginan Anda
        ),
      ),
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: const <Widget>[
          Text('Hi, Krishnaa',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
          Text('Newcomer',
              style:
                  TextStyle(fontSize: 12, color: Color.fromRGBO(0, 0, 0, 0.6))),
        ],
      ),
      actions: [
        Padding(
          padding: EdgeInsets.only(right: 20),
          child: IconButton(
            onPressed: () {},
            icon: Icon(
              Icons.notifications,
              size: 28,
            ),
          ),
        ),
      ],
    );
  }
}
