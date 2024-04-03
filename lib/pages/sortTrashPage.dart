import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import 'package:tratour/components/appBar.dart';

import 'package:tratour/globalVar.dart';
import 'package:tratour/pages/editprofilepage.dart';
import 'package:tratour/pages/pickLocationPage.dart';

class CustomCheckbox extends StatelessWidget {
  final int index;
  final String title;

  const CustomCheckbox({required this.index, required this.title, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final checkboxProvider = Provider.of<CheckboxProvider>(context);
    return GestureDetector(
      onTap: () {
        checkboxProvider.updateCheckbox(index);
      },
      child: Stack(
        alignment: Alignment.center,
        children: [
          Container(
            width: 100,
            height: 100,
            decoration: BoxDecoration(
              border: Border.all(
                color: checkboxProvider.isChecked[index]
                    ? Colors.black
                    : Colors.transparent,
                width: 3,
              ),
            ),
          ),
          Image.asset(
            checkboxProvider.checkboxImages[index],
            width: 100,
            height: 100,
          ),
        ],
      ),
    );
  }
}

class ChecBoxImages extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<CheckboxProvider>(
        builder: (context, checkboxProvider, _) {
          List<int> selectedTrashIndexes = [];
          for (int i = 0; i < checkboxProvider.checkboxImages.length; i++) {
            if (checkboxProvider.isChecked[i]) {
              selectedTrashIndexes.add(i);
            }
          }
          return SingleChildScrollView(
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  for (int i = 0;
                      i < checkboxProvider.checkboxImages.length;
                      i++)
                    CustomCheckbox(title: 'pilihan ${i + 1}', index: i),
                  ElevatedButton(
                    onPressed: selectedTrashIndexes.isEmpty
                        ? null // Nonaktifkan tombol jika tidak ada pilihan yang dipilih
                        : () {
                            // Gunakan GlobalVar untuk mengakses selectedTrashIndexes
                            GlobalVar.instance.selectedTrashIndexes =
                                selectedTrashIndexes;
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) => PickLocationPage(),
                              ),
                            );
                          },
                    child: const Text('Atur lokasi pengangkutan'),
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

class CheckboxProvider with ChangeNotifier {
  final List<bool> _isChecked = [
    false,
    false,
    false,
    false,
    false,
    false
  ]; // Update panjang list menjadi 6
  final List<String> _checkboxImages = [
    'assets/images/plastik.png',
    'assets/images/organik.png',
    'assets/images/minyak.png',
    'assets/images/kardus.png', // Tambahkan gambar baru
    'assets/images/elektronik.png', // Tambahkan gambar baru
    'assets/images/pakaian.png', // Tambahkan gambar baru
  ];

  List<bool> get isChecked => _isChecked;
  List<String> get checkboxImages => _checkboxImages;

  void updateCheckbox(int index) {
    _isChecked[index] = !_isChecked[index];
    notifyListeners();
  }
}

class SortTrashPage extends StatelessWidget {
  SortTrashPage({Key? key, required GlobalVar globalVar}) : super(key: key);

  GlobalVar globalVar = GlobalVar.instance;

  @override
  Widget build(BuildContext context) {
    if (globalVar.userLoginData['address'] == null ||
        globalVar.userLoginData['address'] == '') {
      return Scaffold(
        appBar: MyAppBar(),
        body: Builder(
          builder: (BuildContext context) {
            return Center(
              child: SingleChildScrollView(
                child: MediaQuery.of(context).size.width > 600
                    ? buildWideLayout()
                    : buildNormalLayout(context),
              ),
            );
          },
        ),
      );
    } else {
      return ChangeNotifierProvider<CheckboxProvider>(
        create: (context) => CheckboxProvider(),
        child: Scaffold(
          appBar: const MyAppBar(),
          body: SingleChildScrollView(
            padding: const EdgeInsets.all(20),
            child: SizedBox(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              child: ChecBoxImages(),
            ),
          ),
        ),
      );
    }

    /*  */
  }

  Widget buildWideLayout() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        // Your content here
        Container(
          width: 140,
          height: 140,
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/images/address_logo.png'),
              fit: BoxFit.cover,
            ),
          ),
        ),
        SizedBox(width: 30),
        const Text(
          'Data alamat harus diisi sebelum membuat pesanan',
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 14, fontWeight: FontWeight.w700),
        ),
        // Add more content as needed
      ],
    );
  }

  Widget buildNormalLayout(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        // Your content here
        Container(
          width: 140,
          height: 140,
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage(
                  'assets/images/address_logo.png'), // Assuming your image is in this path
              fit: BoxFit.cover,
            ),
          ),
        ),
        SizedBox(height: 30),
        const Text(
          'Data alamat harus diisi sebelum membuat pesanan!',
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 14, fontWeight: FontWeight.w700),
        ),
        SizedBox(height: 30),

        TextButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => EditProfilePage(),
              ),
            );
          },
          child: Text('Ubah Alamat'),
        ),

        // Add more content as needed
      ],
    );
  }
}
