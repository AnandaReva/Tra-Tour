import 'package:aplikasi_sampah/dbHelper/mysql.dart';
import 'package:aplikasi_sampah/firebase/auth.dart';
import 'package:aplikasi_sampah/globalVar.dart';
import 'package:aplikasi_sampah/main.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:mysql1/mysql1.dart';
import 'dart:math';
import 'package:loading_animation_widget/loading_animation_widget.dart';

bool loginForm = false; // Defaultnya dalam mode login

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key, required GlobalVar globalVar}) : super(key: key);

  @override
  State<LoginPage> createState() => LoginPageState();
}

String generateRandomString(int length) {
  const chars = 'abcdefghijklmnopqrstuvwxyz0123456789';
  final random = Random();
  return List.generate(length, (index) => chars[random.nextInt(chars.length)])
      .join();
}

class LoginPageState extends State<LoginPage> {
  GlobalVar globalVar = GlobalVar.instance;

  String? errorMessage = '';

  final TextEditingController _controllerEmail = TextEditingController();
  final TextEditingController _controllerPassword = TextEditingController();
  final TextEditingController _controllerUsername = TextEditingController();
  final TextEditingController _controllerPhone = TextEditingController();
  final String initial_user_point = '0';
  final String initial_user_type = '1';
  final initial_profile_image = null;
  String createAndUpdateAt = '';
  String referral_code = '';
 // bool globalVar.isLoading = false;

  final Auth _auth = Auth(); // Inisialisasi instance Auth

  Future<void> signInWithEmailAndPassword() async {
    try {
      setState(() {
        globalVar.isLoading = true; // Menampilkan animasi loading
      });

      Auth auth = Auth(); // Buat objek dari kelas Auth

      // Panggil metode findUserDataFromDB dari objek auth yang sama
      await findUserDataFromDB(_controllerEmail.text);

      await auth.signInWithEmailAndPassword(
        email: _controllerEmail.text,
        password: _controllerPassword.text,
      );

      globalVar.isLogin = true;
      if (mounted) {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => HomePage(
              globalVar: globalVar,
            ),
          ),
        );
      }
    } on FirebaseAuthException catch (e) {
      setState(() {
        errorMessage = e.message;
      });
    } finally {
      setState(() {
        globalVar.isLoading = false; // Menyembunyikan animasi loading setelah selesai
      });
    }
  }

  Future<void> createUserWithEmailAndPassword() async {
    referral_code = generateRandomString(6); // abis didapat terus cek db
    print('cek create Akun 1');

    await checkReferralCodeDB(referral_code);

    /*   DateTime now = DateTime.now();
    createAndUpdateAt = DateFormat('yyyy-MM-dd HH:mm:ss').format(now); 

    //pindah ke pegecekan referral

      try {
      Auth auth = Auth(); // Buat objek dari kelas Auth
      // Menambahkan data user ke database MySQL

      await auth.addUserToDatabase(
        _controllerUsername.text,
        _controllerPassword.text,
        _controllerEmail.text,
        _controllerPhone.text,
        initial_user_point,
        initial_user_type,
        initial_profile_image,
        createAndUpdateAt,
        randomString,
      );

      // Mendaftarkan user menggunakan Firebase Authentication
      await Auth().createUserWithEmailAndPassword(
        _controllerEmail.text,
        _controllerPassword.text,
      );

      globalVar.isLogin = true;
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => HomePage(
            globalVar: globalVar,
          ),
        ),
      );
    } on FirebaseAuthException catch (e) {
      setState(() {
        errorMessage = e.message;
        print('error sql:  $errorMessage');
      });
    } */
  }

  Future<void> checkReferralCodeDB(referral_code) async {
    DateTime now = DateTime.now();
    createAndUpdateAt = DateFormat('yyyy-MM-dd HH:mm:ss').format(now);

    try {
      await Mysql.connect();

      print('cek create akun 2');

      // Menggunakan kueri SQL untuk memeriksa keunikan referral code
      Results referralCodeResult = await Mysql.connection
          .query('SELECT * FROM user WHERE referral_code = ?', [referral_code]);

      // Memeriksa apakah hasil kueri kosong untuk menentukan keunikan referral code
      if (referralCodeResult.isEmpty) {
        print('Referal code unik: $referral_code');

        // Lanjutkan proses menyimpan data user

        try {

           setState(() {
                globalVar.isLoading = true; // Menampilkan animasi loading
              });


          // Menambahkan data user ke database MySQL

          // Mendaftarkan user menggunakan Firebase Authentication
          await Auth().createUserWithEmailAndPassword(
            _controllerEmail.text,
            _controllerPassword.text,
          );  Auth auth = Auth(); // Buat objek dari kelas Auth

          await auth.addUserToDatabase(
            _controllerUsername.text,
            _controllerPassword.text,
            _controllerEmail.text,
            _controllerPhone.text,
            initial_user_point,
            initial_user_type,
            initial_profile_image,
            referral_code,
            createAndUpdateAt,
          );

            setState(() {
                globalVar.isLoading = false; // Menampilkan animasi loading
              });

          globalVar.isLogin = true;
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => HomePage(
                globalVar: globalVar,
              ),
            ),
          );
        } on FirebaseAuthException catch (e) {
          setState(() {
            errorMessage = e.message;
            print('error sql:  $errorMessage');
          });
        } 
      } else {
        print('Referal code telah digunakan: $referral_code');

        // Jika referral code telah digunakan, maka generate kode acak baru
        referral_code = generateRandomString(6);

        // Selama referral code masih belum unik, teruskan untuk menghasilkan kode acak baru
        while (referralCodeResult.isNotEmpty) {
          referral_code = generateRandomString(6);

          // Periksa kembali keunikan referral code yang baru
          referralCodeResult = await Mysql.connection.query(
              'SELECT * FROM user WHERE referral_code = ?', [referral_code]);

          if (referralCodeResult.isEmpty) {
            print('Referal code baru sudah unik: $referral_code');

            // Lanjutkan proses menyimpan data user
            try {
              Auth auth = Auth(); // Buat objek dari kelas Auth
              // Menambahkan data user ke database MySQL

              // Mendaftarkan user menggunakan Firebase Authentication

              setState(() {
                globalVar.isLoading = true; // Menampilkan animasi loading
              });

              await Auth().createUserWithEmailAndPassword(
                _controllerEmail.text,
                _controllerPassword.text,
              );
              await auth.addUserToDatabase(
                _controllerUsername.text,
                _controllerPassword.text,
                _controllerEmail.text,
                _controllerPhone.text,
                initial_user_point,
                initial_user_type,
                initial_profile_image,
                referral_code,
                createAndUpdateAt,
              );

              globalVar.isLogin = true;
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => HomePage(
                    globalVar: globalVar,
                  ),
                ),
              );
            } on FirebaseAuthException catch (e) {
              setState(() {
                errorMessage = e.message;
                print('error sql:  $errorMessage');
              });
            } finally {}
          }
        }
      }
    } catch (e) {
      print('Error Get User Data: $e');
    }
  }

  Future<void> signInWithGoogle() async {
    try {
      await _auth.signInWithGoogle(
          context); // Memanggil metode signInWithGoogle dari instance Auth
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

  Widget _entryFieldPhone(
    String title,
    TextEditingController controller,
  ) {
    return TextField(
      controller: controller,
      keyboardType: TextInputType.phone,
      inputFormatters: [
        FilteringTextInputFormatter.digitsOnly,
        LengthLimitingTextInputFormatter(12),
      ],
      decoration: const InputDecoration(
        labelText: 'Phone Number',
        hintText: 'Enter your phone number',
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
    print('sub button: ${globalVar.isLogin}');
    return ElevatedButton(
      onPressed: loginForm
          ? signInWithEmailAndPassword
          : createUserWithEmailAndPassword,
      child: Text(loginForm ? 'Masuk' : 'Buat Akun'),
    );
  }

  Widget _loginRegisterButton() {
    return TextButton(
      onPressed: () {
        setState(() {
          loginForm = !loginForm; // Toggle antara mode login dan registrasi
        });
      },
      child: Text(loginForm ? 'Buat Akun' : 'Sudah punya Akun? Masuk '),
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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(backgroundColor: GlobalVar.mainColor, title: _title()),
      body: globalVar.isLoading
          ? Center(
              child: Center(
                  child: LoadingAnimationWidget.staggeredDotsWave(
                      color: Colors.orange, size: 75)))
          : SingleChildScrollView(
              child: Container(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Center(
                      child: Text(
                        !loginForm ? 'Buat Akun' : 'Masuk',
                        style: const TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    _entryField('email', _controllerEmail),
                    const SizedBox(height: 20),
                    _entryField('password', _controllerPassword),
                    const SizedBox(height: 20),
                    // Tampilkan input username dan nomor telepon hanya ketika tidak dalam mode login
                    if (!loginForm) ...[
                      _entryField('username', _controllerUsername),
                      const SizedBox(height: 20),
                      _entryFieldPhone('Nomor telepon', _controllerPhone),
                      const SizedBox(height: 20),
                    ],
                    _errorMessage(), // Tambahkan widget _errorMessage() di sini
                    const SizedBox(height: 20),
                    _submitButton(),
                    const SizedBox(height: 20),
                    _loginRegisterButton(),
                    const SizedBox(height: 20),
                    _googleAuth(),
                  ],
                ),
              ),
            ),
    );
  }

  Future<void> findUserDataFromDB(
    String email,
  ) async {
    try {
      await Mysql.connect();
      Results results = await Mysql.connection
          .query('SELECT * FROM user WHERE email = ? ', [email]);
      globalVar.userLoginData = results.toList();

      if (globalVar.userLoginData.isNotEmpty) {
        print('Login Berhasil : ${globalVar.userLoginData}');

        globalVar.isLogin = true;
      }
    } catch (e) {
      print('Error Get User Data: $e');
    }
  }
}





//cek referral code uniqe:


