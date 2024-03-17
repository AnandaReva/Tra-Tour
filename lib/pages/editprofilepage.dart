import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gallery_picker/gallery_picker.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:tratour/globalVar.dart';
import 'package:tratour/database/updateUser.dart';
//import 'package:tratour/main.dart';

class EditProfilePage extends StatefulWidget {
  const EditProfilePage({Key? key}) : super(key: key);

  @override
  _EditProfilePageState createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  final UpdateUser _updateUser = UpdateUser();
  GlobalVar globalVar = GlobalVar.instance;

  late TextEditingController _usernameUpdateController;
  late TextEditingController _phoneUpdateController;
  late TextEditingController _addressUpdateController;
  late TextEditingController _postalUpdateCodeController;
  final String profileImageUpdateUrl = '';

  File? _selectedImage;

  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  @override
  void initState() {
    super.initState();
    Map<String, dynamic> userData = globalVar.userLoginData ?? {};
    _usernameUpdateController =
        TextEditingController(text: userData['username'] ?? '');
    _phoneUpdateController =
        TextEditingController(text: userData['phone'] ?? '');
    _addressUpdateController =
        TextEditingController(text: userData['address'] ?? '');
    _postalUpdateCodeController =
        TextEditingController(text: userData['postal_code'] ?? '');
  }

  @override
  void dispose() {
    _usernameUpdateController.dispose();
    _phoneUpdateController.dispose();
    _addressUpdateController.dispose();
    _postalUpdateCodeController.dispose();
    super.dispose();
  }

  FocusScopeNode? _focusScopeNode;

  @override
  Widget build(BuildContext context) {
    GlobalVar globalVar = GlobalVar.instance;

    Map<String, dynamic> userData = globalVar.userLoginData ?? {};
    if (_usernameUpdateController.text != userData['username']) {
      _usernameUpdateController.text = userData['username'] ?? '';
    }
    if (_phoneUpdateController.text != userData['phone']) {
      _phoneUpdateController.text = userData['phone'] ?? '';
    }
    if (_addressUpdateController.text != userData['address']) {
      _addressUpdateController.text = userData['address'] ?? '';
    }
    if (_postalUpdateCodeController.text != userData['postal_code']) {
      _postalUpdateCodeController.text = userData['postal_code'] ?? '';
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: GlobalVar.mainColor,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            setState(() {
              globalVar.isLoading = false;
            });
            Navigator.of(context).pop();
          },
        ),
      ),
      body: globalVar.isLoading // Show loading animation if isLoading is true
          ? Center(
              child: LoadingAnimationWidget.staggeredDotsWave(
                  color: Colors.orange, size: 75))
          : SafeArea(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
                      child: Container(
                        padding: EdgeInsets.all(20),
                        child: const Text(
                          "Lengkapi data anda untuk \n melakukan pemesanan",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                    Center(
                      child: Stack(
                        children: [
                          CircleAvatar(
                            radius: 42,
                            backgroundImage: _selectedImage != null
                                ? FileImage(_selectedImage!)
                                    as ImageProvider<Object>
                                : NetworkImage(userData['profile_image'] ??
                                    'https://firebasestorage.googleapis.com/v0/b/tra-tour.appspot.com/o/default_profile_image.png?alt=media&token=83bb623d-473f-4c5e-93c3-ecc3fc5f915b'),
                          ),
                          Positioned(
                            bottom: -5,
                            right: -10,
                            child: ElevatedButton(
                              onPressed: () async {
                                _selectedImage =
                                    await getImageFromGallery(context);
                                print('selectedImage $_selectedImage');
                                setState(() {});
                                // INI
                              },
                              style: ElevatedButton.styleFrom(
                                padding: EdgeInsets.zero,
                                backgroundColor: Colors.transparent,
                                shape: CircleBorder(),
                                shadowColor: Colors.transparent,
                              ),
                              child: const Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Icon(
                                  Icons.camera_alt_rounded,
                                  color: Colors.white,
                                  size: 24,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Form(
                      child: Padding(
                        padding: EdgeInsets.all(20),
                        child: Column(
                          children: [
                            // Add onChanged callback to update userData map
                            TextFormField(
                              keyboardType: TextInputType.name,
                              inputFormatters: [
                                FilteringTextInputFormatter.allow(
                                    RegExp(r'^[a-zA-Z\s]*$')),
                                LengthLimitingTextInputFormatter(40),
                              ],
                              controller: _usernameUpdateController,
                              decoration: const InputDecoration(
                                contentPadding: EdgeInsets.all(10),
                                border: OutlineInputBorder(),
                                labelText: 'Nama Pengguna',
                              ),
                              onChanged: (value) {
                                setState(() {
                                  userData['username'] = value;
                                });
                              },
                            ),
                            SizedBox(height: 20),
                            TextFormField(
                              keyboardType: TextInputType.phone,
                              inputFormatters: [
                                FilteringTextInputFormatter.digitsOnly,
                                LengthLimitingTextInputFormatter(13),
                              ],
                              controller: _phoneUpdateController,
                              decoration: const InputDecoration(
                                contentPadding: EdgeInsets.all(10),
                                border: OutlineInputBorder(),
                                labelText: 'Nomor Telepon (Cth: 081234567890) ',
                              ),
                              onChanged: (value) {
                                setState(() {
                                  userData['phone'] = value;
                                });
                              },
                            ),
                            SizedBox(height: 20),
                            TextFormField(
                              controller: _addressUpdateController,
                              decoration: const InputDecoration(
                                contentPadding: EdgeInsets.all(10),
                                border: OutlineInputBorder(),
                                labelText: 'Alamat',
                              ),
                              onChanged: (value) {
                                setState(() {
                                  userData['address'] = value;
                                });
                              },
                            ),
                            SizedBox(height: 20),
                            TextFormField(
                              keyboardType: TextInputType.phone,
                              inputFormatters: [
                                FilteringTextInputFormatter.digitsOnly,
                                LengthLimitingTextInputFormatter(5),
                              ],
                              controller: _postalUpdateCodeController,
                              decoration: const InputDecoration(
                                contentPadding: EdgeInsets.all(10),
                                border: OutlineInputBorder(),
                                labelText: 'Kode Pos',
                              ),
                              onChanged: (value) {
                                setState(() {
                                  userData['postal_code'] = value;
                                });
                              },
                            ),
                            SizedBox(height: 10),
                            ElevatedButton(
                              onPressed: () {
                                _confirmEdit(context);
                              },
                              style: ElevatedButton.styleFrom(
                                foregroundColor: Colors.white,
                                backgroundColor: GlobalVar.mainColor,
                              ),
                              child: Text('Simpan Perubahan'),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
    );
  }

  void _confirmEdit(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Konfirmasi Perubahan Profil'),
          content: Text('Apakah Anda yakin ingin mengubah data profil anda?'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                setState(() {
                  globalVar.isLoading = false;
                });
              },
              child: Text('Batal'),
            ),
            ElevatedButton(
              onPressed: () async {
                Navigator.of(context).pop();
                setState(() {
                  globalVar.isLoading =
                      true; // Set isLoading to true when updating starts
                });
                await _updateUserData();
                setState(() {
                  globalVar.isLoading =
                      false; // Set isLoading to false when updating finishes
                });

                print('check textfield C: ${_usernameUpdateController.text}');
                print('check textfield C: ${_phoneUpdateController.text}');
                print('check textfield C: ${_addressUpdateController.text}');
                print('check textfield C: ${_postalUpdateCodeController.text}');
              },
              child: Text('Ubah'),
            ),
          ],
        );
      },
    ).then((_) {
      // Setelah dialog ditutup, kembalikan fokus
      _focusScopeNode?.requestFocus();
    });
  }

  Future<void> _updateUserData() async {
    // Cek apakah gambar sudah dipilih
    if (_selectedImage != null) {
      // Kondisi untuk saat foto profil diganti
      bool success =
          await _updateUser.uploadImageFirebaseStorage(_selectedImage!);
      if (success) {
        // Tampilkan pesan berhasil jika berhasil
        print('Upload image successfully');

        // Perbarui state untuk memperbarui tampilan widget
        setState(() {});

        // Simpan fokus saat ini sebelum pembaruan state
        _focusScopeNode = FocusScope.of(context);

        // Update data user
        await _updateUser.updateUserToDatabase(
          globalVar.userLoginData['email'],
          _usernameUpdateController.text,
          _phoneUpdateController.text,
          _addressUpdateController.text,
          _postalUpdateCodeController.text,
          _updateUser.profileImageUpdateUrl, // Gunakan URL gambar baru
        );

        // Kembalikan fokus setelah pembaruan selesai
        _focusScopeNode?.requestFocus();

        // Tampilkan pesan berhasil jika berhasil
        print('Update user data successfully');
      } else {
        // Tampilkan pesan gagal jika gagal
        print('Failed to upload image');
      }
    } else {
      // Kondisi untuk saat foto profil tidak diganti
      print('check textfield B: ${_usernameUpdateController.text}');
      print('check textfield B: ${_phoneUpdateController.text}');
      print('check textfield B: ${_addressUpdateController.text}');
      print('check textfield B: ${_postalUpdateCodeController.text}');
      await _updateUser.updateUserToDatabase(
        globalVar.userLoginData['email'],
        _usernameUpdateController.text,
        _phoneUpdateController.text,
        _addressUpdateController.text,
        _postalUpdateCodeController.text,
        null,
      );
      print('No image selected');
    }
  }

  Future<File?> getImageFromGallery(BuildContext context) async {
    try {
      List<MediaFile>? singleMedia =
          await GalleryPicker.pickMedia(context: context, singleMedia: true);
      return singleMedia?.first.getFile();
    } catch (e) {
      print('Error Image Picker: $e');
    }
    return null;
  }
}
