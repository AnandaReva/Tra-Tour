import 'package:flutter/material.dart';
import 'package:tratour/globalVar.dart';

class OrderProcess extends StatefulWidget {
  OrderProcess({Key? key, required GlobalVar globalVar}) : super(key: key);

  @override
  _OrderProcessState createState() => _OrderProcessState();
}

class _OrderProcessState extends State<OrderProcess> {
  GlobalVar globalVar = GlobalVar.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Mencari Petugas Pengangkut Terdekat',
          style: TextStyle(fontSize: 18), // Atur ukuran font di sini
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(' ${globalVar.orderData};'),
            /*  ElevatedButton(
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => ConfirmationPage(),
                  ),
                );
              },
              child: const Text('Konfirmasi'),
            ) */
          ],
        ),
      ),
    );
  }
}
