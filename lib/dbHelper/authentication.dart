import 'package:aplikasi_sampah/dbHelper/mysql.dart';
import 'package:aplikasi_sampah/globalVar.dart';
import 'package:flutter/material.dart';
import 'package:mysql1/mysql1.dart';

class LoginMysqlDatabase {
  final GlobalVar globalVar;

  LoginMysqlDatabase({required this.globalVar});

  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  String loginMessage = '';

  Future<void> _login() async {
    final String username = _usernameController.text;
    final String password = _passwordController.text;

    final MySqlConnection conn = await Mysql.getConnection();

    var results = await conn.query(
        'SELECT * FROM users WHERE username = ? AND password = ?',
        [username, password]);

    if (results.isNotEmpty) {
      loginMessage = 'Login berhasil!';
    } else {
      loginMessage = 'Login gagal. Periksa kembali username dan password.';
    }

    await conn.close();
  }

  Future<bool> connect(String email, String password) async {
    print('cek1');

    try {
      final MySqlConnection conn = await Mysql.getConnection();
      print('cek2');

      var results = await conn.query(
          'SELECT * FROM users WHERE username = ? AND password = ?',
          [email, password]);

      if (results.isNotEmpty) {
        loginMessage = 'Login berhasil!';
      } else {
        loginMessage = 'Login gagal. Periksa kembali username dan password.';
      }

      await conn.close();

      bool loginSuccess = loginMessage == 'Login berhasil!';
      globalVar.isLogin = loginSuccess; // Set isLogin menjadi true jika login sukses
      print('status login: ${globalVar.isLogin}');

      return loginSuccess;
    } catch (e) {
      // Tangani eksepsi yang terjadi
      print('Error: $e');
      return false; // Kembalikan false untuk menandakan bahwa login gagal
    }
  }
}
