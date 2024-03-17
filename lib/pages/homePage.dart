import 'package:flutter/material.dart';
import 'package:tratour/globalVar.dart';
import 'package:tratour/model/articles_model.dart';

class HomePage extends StatelessWidget {
  final Map<String, dynamic>? userData; // Define userData parameter
  const HomePage({Key? key, this.userData}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    _getInfo();
    return Scaffold(
      appBar: AppBar(),
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
                  padding: const EdgeInsets.all(8),
                  child: const Row(
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
                  top: -20,
                  right: 0,
                  child: Image.asset(
                    'assets/images/Homepage-removebg-preview.png',
                    scale: 0.92,
                  ),
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
}

List<ArticlesModel> articles = [];

void _getInfo() {
  articles = ArticlesModel.getArticles();
}

Padding _artikelPilihan() {
  return Padding(
    padding: EdgeInsets.all(20.0),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
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
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(15),
                    topRight: Radius.circular(15),
                  ),
                ),
                child: Column(
                  children: [
                    ClipRRect(
                      borderRadius: const BorderRadius.all(
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
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 14,
                              fontFamily: 'PTSans',
                            ),
                          ),
                          Row(
                            children: [
                              const Icon(
                                Icons.calendar_month,
                                size: 14,
                              ),
                              Text(
                                articles[index].date,
                                style: TextStyle(fontSize: 10),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          Text(
                            articles[index].description,
                            style: const TextStyle(
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

Padding _poinSection() {
  GlobalVar globalVar = GlobalVar.instance;

  print('debug m: ${globalVar.userLoginData}');
  Map<String, dynamic> userData = globalVar.userLoginData ?? {};
  print('debug m Tipe data userData: ${userData.runtimeType}');

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
                        children: <TextSpan>[
                          TextSpan(
                            text: userData['user_point']?.toString() ?? '',
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
