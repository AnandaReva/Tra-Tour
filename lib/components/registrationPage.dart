
import 'package:flutter/material.dart';

class RegistrationScreen extends StatefulWidget {
  @override
  _RegistrationScreenState createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _locationController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Registrasi'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              controller: _usernameController,
              decoration: InputDecoration(
                labelText: 'Username',
              ),
            ),
            SizedBox(height: 16.0),
            TextField(
              controller: _phoneController,
              keyboardType: TextInputType.phone,
              decoration: InputDecoration(
                labelText: 'Nomor Telepon',
              ),
            ),
            SizedBox(height: 16.0),
            TextField(
              controller: _locationController,
              decoration: InputDecoration(
                labelText: 'Domisili',
              ),
            ),
            SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () {
                _register();
              },
              child: Text('Daftar'),
            ),
          ],
        ),
      ),
    );
  }

  void _register() {
    // Lakukan validasi dan pemrosesan data registrasi di sini
    String username = _usernameController.text;
    String phone = _phoneController.text;
    String location = _locationController.text;

    // Contoh validasi sederhana
    if (username.isEmpty || phone.isEmpty || location.isEmpty) {
      _showAlertDialog('Gagal', 'Harap isi semua bidang');
    } else {
      // Lakukan pemrosesan registrasi di sini
      _showAlertDialog('Sukses', 'Registrasi berhasil');
      // Bersihkan input setelah registrasi berhasil
      _usernameController.clear();
      _phoneController.clear();
      _locationController.clear();
    }
  }

  void _showAlertDialog(String title, String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          content: Text(message),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('OK'),
            ),
          ],
        );
      },
    );
  }
}