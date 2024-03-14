import 'package:flutter/material.dart';

class EditProfilePage extends StatelessWidget {
  const EditProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: Padding(
            padding: const EdgeInsets.only(left: 20),
            child: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: const Icon(
                Icons.arrow_back_ios,
                size: 22,
              ),
            ),
          ),
          title: const Text(
            "Edit Profil",
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: EdgeInsets.all(20),
                child: Text(
                  "Lengkapi data profil anda",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Center(
                child: SizedBox(
                  width: 80,
                  height: 80,
                  child: Stack(
                    clipBehavior: Clip.none,
                    fit: StackFit.expand,
                    children: [
                      CircleAvatar(
                        backgroundImage: NetworkImage(
                          'https://firebasestorage.googleapis.com/v0/b/tra-tour.appspot.com/o/admin%2Fadmin_profile_picture.png?alt=media&token=2f101f86-e0d6-4cbb-aebe-faa4d37479d0',
                        ),
                      ),
                      Positioned(
                        bottom: -10,
                        right: -35,
                        child: RawMaterialButton(
                          onPressed: () {},
                          elevation: 2.0,
                          fillColor: Color(0xFFF5F6F9),
                          child: Icon(
                            Icons.camera_alt_outlined,
                            color: Colors.black,
                            size: 15,
                          ),
                          shape: CircleBorder(),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              // Center(
              //   child: CircleAvatar(
              //     radius: 42,
              //     backgroundImage: NetworkImage(
              //       'https://firebasestorage.googleapis.com/v0/b/tra-tour.appspot.com/o/admin%2Fadmin_profile_picture.png?alt=media&token=2f101f86-e0d6-4cbb-aebe-faa4d37479d0',
              //     ),
              //   ),
              // ),
              // form
              Form(
                child: Padding(
                  padding: EdgeInsets.all(20),
                  child: Column(
                    children: [
                      TextFormField(
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.all(10),
                          border: OutlineInputBorder(),
                          labelText: 'Nama Lengkap',
                        ),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      TextFormField(
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.all(10),
                          border: OutlineInputBorder(),
                          labelText: 'Alamat',
                        ),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      TextFormField(
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.all(10),
                          border: OutlineInputBorder(),
                          labelText: 'Nomor Telepon',
                        ),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      TextFormField(
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.all(10),
                          border: OutlineInputBorder(),
                          labelText: 'Kode Pos',
                        ),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      ElevatedButton(
                        onPressed: () {},
                        child: Text("Simpan Perubahan"),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.grey[200],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ));
  }
}
