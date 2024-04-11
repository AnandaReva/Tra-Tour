import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tratour/globalVar.dart';
import 'package:tratour/pages/user/pickLocationPage.dart';

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
            width: 150,
            height: 150,
            decoration: BoxDecoration(
             
              border: Border.all(
                color: checkboxProvider.isChecked[index]
                    ? GlobalVar.mainColor
                    : Colors.transparent,
                width: 3, // Atur ketebalan border di sini
              ),
            ),
            child: ColorFiltered(
              colorFilter: ColorFilter.mode(
                Colors.transparent.withOpacity(
                  checkboxProvider.isChecked[index] ? 0.2 : 0.0,
                ),
                BlendMode.srcATop,
              ),
              child: Image.asset(
                checkboxProvider.checkboxImages[index],
                width: 150,
                height: 150,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ignore: must_be_immutable
class ChecBoxImages extends StatelessWidget {
  GlobalVar globalVar = GlobalVar.instance;

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
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  children: [
                    for (int i = 0;
                        i < checkboxProvider.checkboxImages.length;
                        i += 2)
                      Row(
                        mainAxisAlignment: MainAxisAlignment
                            .center, // Menengahkan item di dalam Row
                        children: [
                          CustomCheckbox(title: 'pilihan ${i + 1}', index: i),
                          if (i + 1 < checkboxProvider.checkboxImages.length)
                            CustomCheckbox(
                                title: 'pilihan ${i + 2}', index: i + 1),
                        ],
                      ),
                  ],
                ),
                SizedBox(
                  height: 50,
                ),
                ElevatedButton(
                  onPressed: selectedTrashIndexes.isEmpty
                      ? null // Nonaktifkan tombol jika tidak ada pilihan yang dipilih
                      : () {
                          // Gunakan GlobalVar untuk mengakses selectedTrashIndexes

                          globalVar.selectedTrashIndexes = selectedTrashIndexes;
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => PickLocationPage(),
                            ),
                          );
                          print(
                              'selected indexes:  ${globalVar.selectedTrashIndexes}  ');
                        },
                  child: const Text('Atur lokasi pengangkutan'),
                )
              ],
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
