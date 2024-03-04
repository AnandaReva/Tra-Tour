import 'package:flutter/material.dart';
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
    );
  }

  Padding _artikelPilihan() {
    return Padding(
      padding: const EdgeInsets.all(20.0),
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
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                return Container(
                  width: 152,
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
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              articles[index].title,
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 12,
                                fontFamily: 'PTSans',
                              ),
                            ),
                            Row(
                              children: [
                                const Icon(
                                  Icons.calendar_month,
                                  size: 12,
                                ),
                                Text(
                                  articles[index].date,
                                  style: const TextStyle(fontSize: 8),
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
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Container(
        width: 320,
        decoration: BoxDecoration(
          color: Colors.grey.shade200,
          borderRadius: const BorderRadius.all(
            Radius.circular(10),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(
              padding: EdgeInsets.all(8.0),
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
                        icon: const Icon(Icons.smartphone),
                      ),
                      const Text(
                        "Pulsa\nPrabayar",
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 10, fontFamily: 'PTSans'),
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      IconButton(
                        onPressed: () {},
                        icon: Icon(Icons.wifi),
                      ),
                      const Text(
                        "Paket\nData",
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 10, fontFamily: 'PTSans'),
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      IconButton(
                        onPressed: () {},
                        icon: Icon(Icons.bolt),
                      ),
                      const Text(
                        "Voucher\nListrik",
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 10, fontFamily: 'PTSans'),
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      IconButton(
                        onPressed: () {},
                        icon: const Icon(Icons.arrow_right_alt),
                      ),
                      const Text(
                        "Voucher\nLainnya",
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 10, fontFamily: 'PTSans'),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Padding _poinSection() {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Container(
        width: 320,
        height: 70,
        decoration: BoxDecoration(
            color: Colors.grey.shade200,
            borderRadius: BorderRadius.all(Radius.circular(10))),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(
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
                const Padding(
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
                      text: const TextSpan(
                        style: TextStyle(color: Colors.black),
                        children: <TextSpan>[
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
      toolbarHeight: 80,
      leadingWidth: 75,
      leading: const Padding(
        padding: EdgeInsets.only(left: 20),
        child: CircleAvatar(
          radius: 24, // Atur radius sesuai keinginan Anda
        ),
      ),
      title: const Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Hi, Rakesh Bramantyo',
              style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
          Text('Newcomer',
              style:
                  TextStyle(fontSize: 10, color: Color.fromRGBO(0, 0, 0, 0.6))),
        ],
      ),
      actions: [
        Padding(
          padding: const EdgeInsets.only(right: 20),
          child: IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.notifications,
              size: 24,
            ),
          ),
        ),
      ],
    );
  }
}
