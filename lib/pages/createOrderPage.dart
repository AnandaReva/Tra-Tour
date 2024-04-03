import 'package:flutter/material.dart';

class CreateOrderPage extends StatefulWidget {
  CreateOrderPage({Key? key}) : super(key: key);

  @override
  _CreateOrderPageState createState() => _CreateOrderPageState();
}

class _CreateOrderPageState extends State<CreateOrderPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Pilih Petugas Pengangkutan',
          style: TextStyle(fontSize: 18), // Atur ukuran font di sini
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
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
