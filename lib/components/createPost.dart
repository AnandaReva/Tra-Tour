import 'dart:io';

import 'package:flutter/material.dart';

import 'package:aplikasi_sampah/components/footer.dart';
//import 'package:aplikasi_sampah/dbhelper/mongodb.dart';

import 'package:aplikasi_sampah/globalVar.dart';
import 'package:file_picker/file_picker.dart';
import 'package:carousel_slider/carousel_slider.dart';

class CreatePostPage extends StatefulWidget {
  const CreatePostPage({Key? key, required GlobalVar globalVar})
      : super(key: key);

  @override
  _CreatePostPageState createState() => _CreatePostPageState();
}

class _CreatePostPageState extends State<CreatePostPage> {
  TextEditingController titleController = TextEditingController();
  TextEditingController contentController = TextEditingController();

  List<PlatformFile>? files; // Menyimpan file yang dipilih
  static const mainColor = Color.fromRGBO(21, 16, 38, 1.0);
  //static const baseColor = Color.fromRGBO(240, 240, 240, 1.0);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: mainColor,
        title: const Text(
          'Create Post',
          style: TextStyle(
            color: Colors.white,
            fontFamily: 'Poppins-Bold',
            fontWeight: FontWeight.bold,
          ),
        ),
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            ElevatedButton(
              onPressed: () async {
                FilePickerResult? result = await FilePicker.platform.pickFiles(
                  allowMultiple: true,
                  type: FileType.custom,
                  allowedExtensions: [
                    'png',
                    'jpg',
                    'jpeg',
                    'gif',
                    'bmp',
                    'webp',
                    'mp4',
                    'avi',
                    'mkv',
                    'mov',
                    'wmv'
                  ],
                );

                if (result != null) {
                  bool filesAccepted = true;

                  for (var file in result.files) {
                    final size = file.size;
                    final sizeKbs = size / 1024;

                    if (sizeKbs > maxSizeKbs) {
                      print('File size should be less than $maxSizeKbs Kb');
                      filesAccepted = false;
                      break;
                    }
                  }

                  if (filesAccepted) {
                    if (result.files.length <= 4) {
                      setState(() {
                        files = result.files;
                      });
                    } else {
                      showDialog(
                        context:
                            context, // Gunakan BuildContext yang sudah disimpan sebelumnya
                        builder: (BuildContext dialogContext) {
                          return AlertDialog(
                            title:  Text('Error'),
                            content: Text(
                                'Maximum 4 files are allowed to be selected.'),
                            actions: <Widget>[
                              TextButton(
                                onPressed: () {
                                  Navigator.of(dialogContext)
                                      .pop(); // Gunakan dialogContext di sini
                                },
                                child: Text('OK'),
                              ),
                            ],
                          );
                        },
                      );
                    }
                  }
                }
              },
              child: Text(files != null && files!.isNotEmpty
                  ? 'Files Selected: ${files!.length}'
                  : 'Select Files'),
            ),
            if (files != null)
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Preview Files:'),
                  const SizedBox(height: 10),
                  CarouselSlider(
                    options: CarouselOptions(
                        height:
                            100), // Atur tinggi carousel sesuai kebutuhan Anda
                    items: files!.map((file) {
                      return Builder(
                        builder: (BuildContext context) {
                          return SizedBox(
                            width: MediaQuery.of(context).size.width,
                            child: _buildPreview(file),
                          );
                        },
                      );
                    }).toList(),
                  ),
                ],
              ),
            const SizedBox(height: 20),
            TextField(
              controller: titleController,
              decoration: const InputDecoration(
                labelText: 'Caption',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20),
            TextField(
              controller: contentController,
              maxLines: 5,
              keyboardType: TextInputType.multiline,
              decoration: const InputDecoration(
                labelText: 'Content',
                border: OutlineInputBorder(),
              ),
            ),
            // Add attachments fields if needed
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                String title = titleController.text;
                String content = contentController.text;
                // Get attachments if needed
                // Create a new post with the data
                // You need to implement the logic to send the post data to the server
              },
              child: const Text('Create Post'),
            ),
          ],
        ),
      ),
      bottomNavigationBar: const MyBottomNavigationBar(),
    );
  }

  double _sizeKbs = 0;
  final int maxSizeKbs = 1024;

  Widget _buildPreview(PlatformFile file) {
    if (file.extension == 'jpg' || file.extension == 'png') {
      return Image.file(File(file.path!));
    } else {
      // Tambahkan kode untuk menampilkan pratinjau untuk jenis file lainnya
      return Text('No Preview Available');
    }
  }
}
