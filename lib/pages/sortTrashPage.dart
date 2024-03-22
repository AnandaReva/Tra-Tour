import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import 'package:tratour/components/appBar.dart';

import 'package:tratour/globalVar.dart';

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
                    onPressed: () {
                      // Use GlobalVar to access selectedTrashIndexes
                      GlobalVar.instance.selectedTrashIndexes =
                          selectedTrashIndexes;
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => ResultScreen(),
                        ),
                      );
                    },
                    child: const Text('Submit Pilihan'),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

class ResultScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Access selectedTrashIndexes from GlobalVar
    List<int> selectedTrashIndexes = GlobalVar.instance.selectedTrashIndexes;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Pilihan yang Dipilih'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: selectedTrashIndexes.map((index) {
            if (index == 0) {
              return const Text('Pilihan 1 dipilih');
            } else if (index == 1) {
              return const Text('Sampah 2 dipilih');
            } else if (index == 2) {
              return const Text('Pilihan 3 dipilih');
            } else if (index == 3) {
              return const Text('Pilihan 4 dipilih');
            } else if (index == 4) {
              return const Text('Pilihan 5 dipilih');
            } else if (index == 5) {
              return const Text('Pilihan 6 dipilih');
            } else {
              return Text('Pilihan ${index} dipilih');
            }
          }).toList(),
        ),
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
  const SortTrashPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<CheckboxProvider>(
      create: (context) => CheckboxProvider(),
      child: Scaffold(
        appBar: const MyAppBar(),
        body: SingleChildScrollView(
            padding: const EdgeInsets.all(20),
            child: SizedBox(
              child: ChecBoxImages(),
              width: 200.0,
              height: 1000.0,
            )),
      ),
    );
  }
}
