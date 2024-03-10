//import 'package:aplikasi_sampah/dbHelper/mysql.dart';
import 'package:aplikasi_sampah/components/profilePage.dart';
import 'package:aplikasi_sampah/firebase/auth.dart';
import 'package:aplikasi_sampah/globalVar.dart';
import 'package:aplikasi_sampah/main.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
//import 'package:intl/intl.dart';
//import 'package:mysql1/mysql1.dart';
import 'dart:math';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

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
  final TextEditingController _controllerRole = TextEditingController();
  final String initial_user_point = '0';
  final String initial_profile_image = 'null';
  String referral_code = '';
  // bool globalVar.isLoading = false;
  Future<void> createUserWithEmailAndPassword() async {
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
    }

    // Menampilkan dialog konfirmasi sebelum membuat akun
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Perhatian !!!"),
          content: const Text("Anda Tidak dapat Mengganti peran setelah mendaftar "),
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
            setState(() {
              globalVar.isLoading = true; // Menampilkan animasi loading
            });

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
              referral_code,
            );

            setState(() {
              globalVar.isLoading = false; // Menampilkan animasi loading
            });

            if (mounted) {
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(
                  builder: (context) => HomePage(globalVar: globalVar),
                ),
                (route) => false,
              );
            }
          } on FirebaseAuthException catch (e) {
            setState(() {
              errorMessage =
                  'Gagal mendaftarkan akun, mohon coba lagi \n $e.message ';
              print('Firebase:  $e.message');
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
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(
            builder: (context) => HomePage(globalVar: globalVar),
          ),
          (route) => false,
        );
      }
    } on FirebaseAuthException catch (e) {
      setState(() {
        // Periksa kode kesalahan FirebaseAuthException
        if (e.code == 'user-not-found' || e.code == 'wrong-password') {
          errorMessage = 'Username atau password salah';
        } else {
          errorMessage = 'Terjadi kesalahan saat masuk: ${e.message}';
        }
        print('error sql: ${e.message}');
        globalVar.isLoading = false;
      });
    } finally {
      globalVar.isLoading =
          false; // Menyembunyikan animasi loading setelah selesai
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
        // Only allow digits and optional "+" symbol
        FilteringTextInputFormatter.allow(RegExp(r'^[+\d]*$')),
        // Limit to 13 characters (including optional "+")
        LengthLimitingTextInputFormatter(13),
      ],
      decoration: InputDecoration(
        labelText: title,
        hintText: 'Masukkan nomor telepon',
      ),
    );
  }

  Widget _entryRole(
    String title,
    TextEditingController controller,
  ) {
    return DropdownButtonFormField<String>(
      value: controller.text.isEmpty ? '1' : controller.text,
      onChanged: (String? newValue) {
        setState(() {
          controller.text = newValue ?? '';
        });
      },
      items: const [
        DropdownMenuItem<String>(
          value: '1',
          child: Text('Pengepul'),
        ),
        DropdownMenuItem<String>(
          value: '2',
          child: Text('Petugas pengangkut'),
        ),
        DropdownMenuItem<String>(
          value: '3',
          child: Text('Pemakai'),
        ),
      ],
      decoration: InputDecoration(
        labelText: title,
        hintText: 'Pilih peran',
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
                      _entryRole('Pilih Peran', _controllerRole),
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
    /*   try {
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
    } */
    String url = 'https://tratour.000webhostapp.com/findUser.php?email=$email';

    try {
      /*  setState(() {
        globalVar.isLoading = true;
      }); */

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
        /*  setState(() {
          globalVar.isLoading = false;
        }); */
      }
    } catch (e) {
      // Terjadi kesalahan saat melakukan permintaan HTTP
      print('Error Find: $e');
    }
  }
}





//cek referral code uniqe:


