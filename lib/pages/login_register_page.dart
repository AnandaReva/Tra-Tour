//import 'package:tratour/dbHelper/mysql.dart';
// ignore_for_file: prefer_const_constructors, non_constant_identifier_names

import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tratour/database/auth.dart';
import 'package:tratour/globalVar.dart';
import 'package:tratour/main.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

//import 'package:intl/intl.dart';
//import 'package:mysql1/mysql1.dart';
import 'dart:math';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

bool loginForm = true; // Inisialisasi di luar blok if

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key, required GlobalVar globalVar}) : super(key: key);

  @override
  State<LoginPage> createState() => LoginPageState();
  
}

String generateRandomString(int length) {
  const chars =
      'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789'; // Huruf kapital ditambahkan di awal
  final random = Random();
  return List.generate(length, (index) => chars[random.nextInt(chars.length)])
      .join();
}

class LoginPageState extends State<LoginPage> {
  GlobalVar globalVar = GlobalVar.instance;

  @override
  void initState() {
    super.initState();
    if (globalVar.initScreen == 0) {
        print('initScreen: ${globalVar.initScreen}');
         print("awal 2 : ${globalVar.selected_role_onboarding}");
      
      loginForm = false; // Setel nilai loginForm di dalam blok if
    } else {
      loginForm = true;
    }
  }

  String? errorMessage = '';

  final TextEditingController _controllerEmail = TextEditingController();
  final TextEditingController _controllerPassword = TextEditingController();
  final TextEditingController _controllerUsername = TextEditingController();
  final TextEditingController _controllerPhone = TextEditingController();
  final TextEditingController _controllerRole = TextEditingController();
  final TextEditingController _controllerReferralCodeInput =
      TextEditingController();
  final String initial_user_point = '0';
  final String initial_profile_image = 'null';
  final String initial_address = 'null';
  final String initial_postal_code = 'null';
  final String initial_referral_code = 'null';

  String referral_code = '';

  

  // bool globalVar.isLoading = false;
  Future<void> createUserWithEmailAndPassword() async {
    print('initScreen: $globalVar.initScreen');
    if (globalVar.initScreen == 0) {
      // dari onboarding
      _controllerRole.text = globalVar.selected_role_onboarding;
    }
    referral_code = generateRandomString(6); // abis didapat terus cek db
    print('cek create Akun 1');

    if (_controllerEmail.text.isEmpty ||
        _controllerPassword.text.isEmpty ||
        _controllerUsername.text.isEmpty ||
        _controllerPhone.text.isEmpty ||
        _controllerRole.text.isEmpty) {
      setState(() {
        errorMessage = 'Kolom data tidak boleh kosong';
      });
      return;
    } else if (_controllerPassword.text.length < 8) {
      setState(() {
        errorMessage = 'Password harus memiliki minimal 8 karakter';
      });
      return;
    }

    // Menampilkan dialog konfirmasi sebelum membuat akun
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Perhatian !!!"),
          content:
              const Text("Anda Tidak dapat Mengganti peran setelah mendaftar "),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text("Batal"),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
                // Jika konfirmasi diterima, lanjutkan dengan membuat akun
                checkReferralCode(referral_code);
              },
              child: const Text("Ya"),
            ),
          ],
        );
      },
    );
  }

  Future<void> checkReferralCode(referral_code) async {
    String url =
        'https://tratour.000webhostapp.com/checkReferralCode.php?referral_code=$referral_code';

    try {
      setState(() {
        globalVar.isLoading =
            true; // Menyembunyikan animasi loading setelah selesai
      });
      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        // Berhasil mendapatkan respon dari server
        Map<String, dynamic> data = json.decode(response.body);
        print('Response Referral Code: $data');

        // success false maka data tidak ada / uniqe
        if (data['success'] == true) {
          // Lakukan sesuatu dengan data yang diperoleh dari server
          print('Referral code telah digunakan: $referral_code');

          // Jika referral code telah digunakan, maka suruh registrasi ulang

          setState(() {
            globalVar.isLoading = false;
          });
        } else {
          // Data null, berikan pesan atau lakukan tindakan lain
          print('Referal code unik: $referral_code');
          try {
            // Menambahkan data user ke database MySQL

            // Mendaftarkan user menggunakan Firebase Authentication
            await Auth().createUserWithEmailAndPassword(
              _controllerEmail.text,
              _controllerPassword.text,
            );
            Auth auth = Auth(); // Buat objek dari kelas Auth

            await auth.addUserToDatabase(
              _controllerUsername.text,
              _controllerPassword.text,
              _controllerEmail.text,
              _controllerPhone.text, // Pass phone as string
              _controllerRole.text,

              initial_user_point,
              initial_profile_image,
              initial_address,
              initial_postal_code,
              referral_code,
            );

            if (mounted) {
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(
                  builder: (context) => MainPage(),
                ),
                (route) => false,
              );
             
            }

            setState(() {
              globalVar.isLoading = false; // Menampilkan animasi loading
            });
          } on FirebaseAuthException catch (e) {
            setState(() {
              print('Firebase:  $e.message');

              if (e.message == 'The email address is badly formatted.') {
                errorMessage = 'Masukkan email dengan format yang sesuai';
              } else if (e.message ==
                  'The email address is already in use by another account.') {
                errorMessage = 'Alamat email sudah digunakan dalam akun lain.';
              } else {
                errorMessage =
                    'Gagal mendaftarkan akun, mohon coba lagi \n: ${e.message}';
              }
              print('error Signin: ${e.message}');

              globalVar.isLoading = false;
            });
          }
        }
      } else {
        // Gagal mendapatkan respon dari server
        globalVar.isLoading = false;
        print('Failed to load data: ${response.statusCode}');
      }
    } catch (e) {
      // Terjadi kesalahan saat melakukan permintaan HTTP
      globalVar.isLoading = false;
      print('Error Find data: $e');
    }
  }

  final Auth auth = Auth(); // Inisialisasi instance Auth

  Future<void> signInWithEmailAndPassword() async {
    if (_controllerEmail.text.isEmpty || _controllerPassword.text.isEmpty) {
      setState(() {
        errorMessage = 'Kolom data tidak boleh kosong';
      });
      return;
    }

    try {
      setState(() {
        globalVar.isLoading = true; // Menampilkan animasi loading
      });

      // Panggil metode findUserDataFromDB dari objek auth yang sama
      await findUserDataFromDB(_controllerEmail.text);

      await auth.signInWithEmailAndPassword(
        email: _controllerEmail.text,
        password: _controllerPassword.text,
      );

      globalVar.isLogin = true;
      if (mounted) {
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(
            builder: (context) => MainPage(),
          ),
          (route) => false,
        );
      }

      setState(() {
        globalVar.isLoading = false; // Menampilkan animasi loading
      });
    } on FirebaseAuthException catch (e) {
      setState(() {
        // Periksa kode kesalahan FirebaseAuthException
        if (e.message == 'The email address is badly formatted.') {
          errorMessage = 'Masukkan email dengan format yang sesuai';
        } else if (e.message ==
            'The supplied auth credential is incorrect, malformed or has expired.') {
          errorMessage = 'Email atau password salah';
        } else if (e.message ==
            'A network error (such as timeout, interrupted connection or unreachable host) has occurred.') {
          errorMessage = 'Periksa koneksi internet';
        } else {
          errorMessage = 'Terjadi kesalahan saat masuk: ${e.message}';
        }
        print('error Signin: ${e.message}');
        globalVar.isLoading = false;
      });
    } finally {
      setState(() {
        globalVar.isLoading = false; // Menampilkan animasi loading
      });
    }
  }

  Future<void> signInWithGoogle() async {
    try {
      await auth.signInWithGoogle(
          context); // Memanggil metode signInWithGoogle dari instance Auth
    } catch (e) {
      print('Error signing in with Google: $e');
    }
  }

  Widget _title() {
    return
    
    
     Image.asset(
      'assets/images/logo.png',
      width: 100, // Menyesuaikan lebar sesuai kebutuhan

      fit: BoxFit.cover,
    );
  }

  Widget _entryField(
    String title,
    TextEditingController controller,
  ) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25),
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 10),
        decoration: BoxDecoration(
            color: Colors.grey[200],
            border: Border.all(
              color: Colors.white,
            ),
            borderRadius: BorderRadius.circular(12)),
        child: Padding(
          padding: EdgeInsets.only(left: 20),
          child: TextField(
            controller: controller,
            decoration: InputDecoration(
              border: InputBorder.none,
              hintText: title,
              labelText: title,
            ),
          ),
        ),
      ),
    );

    /*  TextField(
      controller: controller,
      decoration: InputDecoration(
        labelText: title,
      ),
    ); */
  }

  Widget _entryFieldUsername(
    String title,
    TextEditingController controller,
  ) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25),
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 10),
        decoration: BoxDecoration(
          color: Colors.grey[200],
          border: Border.all(
            color: Colors.white,
          ),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Padding(
          padding: EdgeInsets.only(left: 20),
          child: TextField(
            keyboardType: TextInputType.text,
            inputFormatters: [
              FilteringTextInputFormatter.allow(
                  RegExp(r'^[a-zA-Z0-9 ]*$')), // Allow only letters and numbers
              LengthLimitingTextInputFormatter(25),
            ],
            controller: controller,
            decoration: InputDecoration(
              border: InputBorder.none,
              hintText: title,
              labelText: 'Nama Pengguna',
            ),
          ),
        ),
      ),
    );
  }

  Widget _entryReferralCodeInput(
    String title,
    TextEditingController controller,
  ) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25),
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 10),
        decoration: BoxDecoration(
          color: Colors.grey[200],
          border: Border.all(
            color: Colors.white,
          ),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Padding(
          padding: EdgeInsets.only(left: 20),
          child: TextField(
            keyboardType: TextInputType.text,
            inputFormatters: [
              FilteringTextInputFormatter.allow(RegExp(
                  r'^[a-zA-Z0-9]*$')), // Allow only uppercase letters and numbers
              LengthLimitingTextInputFormatter(6), // Limit to 6 characters
            ],
            controller: controller,
            decoration: InputDecoration(
              border: InputBorder.none,
              hintText: title,
              labelText: 'Referral Code (Opsional)',
            ),
          ),
        ),
      ),
    );
  }

  Widget _entryFieldPhone(
    String title,
    TextEditingController controller,
  ) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25),
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 10),
        decoration: BoxDecoration(
          color: Colors.grey[200],
          border: Border.all(
            color: Colors.white,
          ),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Padding(
          padding: EdgeInsets.only(left: 20),
          child: TextField(
            keyboardType: TextInputType.phone, // Set keyboard type to phone
            inputFormatters: [
              FilteringTextInputFormatter.digitsOnly, // Hanya izinkan digit
              LengthLimitingTextInputFormatter(13), // Batasan panjang
            ],
            controller: controller,
            decoration: InputDecoration(
              border: InputBorder.none,
              hintText: title,
              labelText: 'Nomor Telepon',
            ),
          ),
        ),
      ),
    );
  }

  Widget _entryRole(
    String title,
    TextEditingController controller,
  ) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25),
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 10),
        decoration: BoxDecoration(
          color: Colors.grey[200],
          border: Border.all(
            color: Colors.white,
          ),
          borderRadius: BorderRadius.circular(12),
        ),
        child: DropdownButtonFormField<String>(
          value: controller.text.isEmpty ? null : controller.text,
          onChanged: (String? newValue) {
            controller.text = newValue ?? '';
          },
          items: [
            DropdownMenuItem<String>(
              value: null,
              child: Container(
                color: Colors.grey,
                child: Text(
                  'Apa peran yang mau anda pilih: ',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
            DropdownMenuItem<String>(
              value: '1',
              child: Text('Pengguna'),
            ),
            DropdownMenuItem<String>(
              value: '2',
              child: Text('Petugas pengangkut'),
            ),
            DropdownMenuItem<String>(
              value: '3',
              child: Text('Pengepul'),
            ),
          ],
          decoration: InputDecoration(
            labelText: title,
            hintText: 'Pilih peran',
            border: InputBorder.none,
            contentPadding: EdgeInsets.symmetric(horizontal: 20),
          ),
        ),
      ),
    );
  }

  Widget _errorMessage() {
    if (errorMessage == null || errorMessage!.isEmpty) {
      return Container(); // Widget penampung kosong
    } else {
      return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25),
          child: Center(
            child: Text(
              errorMessage!,
              style: const TextStyle(
                color: Colors.red,
                fontFamily: 'Poppins-Bold',
                fontWeight: FontWeight.bold,
              ),
            ),
          ));
    }
  }

  Widget _submitButton() {
    if (kDebugMode) {
      print('sub button: ${globalVar.isLogin}');
    }
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25),
      child: GestureDetector(
        onTap: loginForm
            ? signInWithEmailAndPassword
            : createUserWithEmailAndPassword,
        child: Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: Color.fromARGB(255, 29, 121, 72),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Center(
            child: Text(
              loginForm ? 'Masuk' : 'Buat Akun',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _loginRegisterButton() {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          GestureDetector(
            // onTap: widget.showRegisterPage,
            child: TextButton(
              onPressed: () {
                setState(() {
                  loginForm =
                      !loginForm; // Toggle antara mode login dan registrasi
                });
              },
              child: RichText(
                text: TextSpan(
                  children: [
                    TextSpan(
                      text:
                          loginForm ? 'Pengguna Baru? ' : 'Sudah punya Akun? ',
                      style: TextStyle(
                        color: Colors.black, // Warna teks untuk bagian pertama
                      ),
                    ),
                    TextSpan(
                      text: loginForm ? 'Buat Akun' : 'Masuk',
                      style: TextStyle(
                        color: Colors.blue, // Warna teks untuk bagian kedua
                        fontWeight:
                            FontWeight.bold, // Atur gaya teks menjadi tebal
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _googleAuth() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25),
      child: GestureDetector(
        onTap: () {},
        child: Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: Colors.black),
            ),
            child: InkWell(
              onTap:
                  signInWithGoogle, // Panggil metode signInWithGoogle saat gambar diklik
              child: Row(
                mainAxisAlignment: MainAxisAlignment
                    .center, // Menempatkan widget di tengah secara horizontal
                children: [
                  Image.asset(
                    'assets/images/google.png', // Path to your colored Google logo image
                    width: 24, // Adjust width as needed
                    height: 24, // Adjust height as needed
                  ),
                  SizedBox(width: 10), // Spacer
                  Text(
                    "SignIn With Google",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            )),
      ),
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
          : SafeArea(
              child: CustomScrollView(
                slivers: [
                  SliverFillRemaining(
                    hasScrollBody: false,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                                padding: const EdgeInsets.all(25),
                                child: Center(
                                  child: Text(
                                    loginForm ? 'Masuk' : 'Daftar',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 30,
                                    ),
                                  ),
                                )),
                            if (!loginForm) ...[
                              
                              _entryFieldUsername(
                                  'Nama Lengkap', _controllerUsername),
                              const SizedBox(height: 10),
                            ],
                            _entryField('Email', _controllerEmail),
                            const SizedBox(height: 10),
                            _entryField('Password', _controllerPassword),
                            if (!loginForm) ...[
                              const SizedBox(height: 10),
                              _entryFieldPhone(
                                  'Cth: 081234567890', _controllerPhone),
                              if (globalVar.initScreen == 1) ...[
                                SizedBox(height: 10),
                                _entryRole('Pilih Peran', _controllerRole)
                              ],
                              const SizedBox(height: 10),
                              _entryReferralCodeInput('Kode Referral',
                                  _controllerReferralCodeInput),
                            ],
                            SizedBox(
                              height: 10,
                            ),
                            _errorMessage(),
                            SizedBox(
                              height: 10,
                            ),
                            _submitButton(),
                            Divider(
                              height: 50,
                              thickness: 1,
                              indent: 30,
                              endIndent: 30,
                              color: Colors.black,
                            ),
                            _googleAuth(),
                          ],
                        ),
                        _loginRegisterButton(),
                      ],
                    ),
                  ),
                ],
              ),
            ),
    );
  }

  Future<void> findUserDataFromDB(
    String email,
  ) async {
    String url = 'https://tratour.000webhostapp.com/findUser.php?email=$email';

    try {
      // Melakukan HTTP GET request
      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        // Berhasil mendapatkan respon dari server
        GlobalVar globalVar = GlobalVar.instance;
        Map<String, dynamic> data = json.decode(response.body);

        // Memperbarui userLoginData dengan data yang diperoleh
        globalVar.userLoginData = data['data'];

        // Set isLogin menjadi true
        globalVar.isLogin = true;
      } else {
        // Gagal mendapatkan respon dari server
        print('Failed to load data: ${response.statusCode}');
      }
    } catch (e) {
      // Terjadi kesalahan saat melakukan permintaan HTTP
      print('Error Find: $e');
    }
  }
}
