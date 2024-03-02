import 'package:aplikasi_sampah/components/footer.dart';
import 'package:aplikasi_sampah/firebase/auth.dart';
import 'package:aplikasi_sampah/globalVar.dart';
import 'package:aplikasi_sampah/main.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key, required GlobalVar globalVar}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  GlobalVar globalVar = GlobalVar.instance;

  String? errorMessage = '';

  final TextEditingController _controllerEmail = TextEditingController();
  final TextEditingController _controllerPassword = TextEditingController();
  final Auth _auth = Auth(); // Inisialisasi instance Auth

  Future<void> signInWithEmailAndPassword() async {
    try {
      await Auth().signInWithEmailAndPassword(
        email: _controllerEmail.text,
        password: _controllerPassword.text,
      );
      globalVar.isLogin = true;
      Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => HomePage(
                  globalVar: globalVar,
                )),
      );
    } on FirebaseAuthException catch (e) {
      setState(() {
        errorMessage = e.message;
      });
    }
  }

  Future<void> createUserWithEmailAndPassword() async {
    try {
      await Auth().createUserWithEmailAndPassword(
        email: _controllerEmail.text,
        password: _controllerPassword.text,
      );
      globalVar.isLogin = true;
      Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => HomePage(
                  globalVar: globalVar,
                )),
      );
    } on FirebaseAuthException catch (e) {
      setState(() {
        errorMessage = e.message;
      });
    }
  }

  Future<void> signInWithGoogle() async {
    try {
      await _auth
          .signInWithGoogle(context); // Memanggil metode signInWithGoogle dari instance Auth
     
    } catch (e) {
      print('Error signing in with Google: $e');
    }
  }

  Widget _title() {
    return const Text(
      'Tra-tour',
      style: TextStyle(
        color: Colors.white,
        fontFamily: 'Poppins-Bold',
        fontWeight: FontWeight.bold,
      ),
    );
  }

  Widget _entryField(
    String title,
    TextEditingController controller,
  ) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        labelText: title,
      ),
    );
  }

  Widget _errorMessage() {
    return Text(
      errorMessage == '' ? '' : '$errorMessage',
      style: const TextStyle(
        color: Colors.red,
        fontFamily: 'Poppins-Bold',
        fontWeight: FontWeight.bold,
      ),
    );
  }

  Widget _submitButton() {
    print('isLogin:  $globalVar.isLogin');
    return ElevatedButton(
      onPressed: globalVar.isLogin
          ? signInWithEmailAndPassword
          : createUserWithEmailAndPassword,
      child: Text(globalVar.isLogin ? 'Masuk' : 'Buat Akun'),
    );
  }

  Widget _loginRegisterButton() {
    return TextButton(
      onPressed: () {
        setState(() {
          globalVar.isLogin = !globalVar.isLogin;
        });
      },
      child: Text(globalVar.isLogin ? 'Buat Akun' : 'Sudah punya Akun? Masuk'),
    );
  }

  Widget _googleAuth() {
    return Column(
      children: [
        const Text(
          'atau',
          style:
              TextStyle(fontSize: 12), // Ganti dengan ukuran font yang sesuai
        ),
        ElevatedButton.icon(
          onPressed: signInWithGoogle, // Panggil metode signInWithGoogle
          icon: FaIcon(FontAwesomeIcons.google),
          label: Text('Masuk dengan Akun Google'),
        ),
        SizedBox(height: 8), // Jarak antara tombol dan teks
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(backgroundColor: GlobalVar.mainColor, title: _title()),
      body: Container(
        height: double.infinity,
        width: double.infinity,
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(height: 20),
            _entryField('email', _controllerEmail),
            const SizedBox(height: 20),
            _entryField('password', _controllerPassword),
            const SizedBox(height: 20),
            _errorMessage(),
            const SizedBox(height: 20),
            _submitButton(),
            const SizedBox(height: 20),
            _loginRegisterButton(),
            const SizedBox(height: 20),
            _googleAuth(),
          ],
        ),
      ),
      bottomNavigationBar: const MyBottomNavigationBar(),
    );
  }
}
