import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';

class MyImageViewer extends StatelessWidget {
  final String profilePhoto;

  const MyImageViewer({Key? key, required this.profilePhoto}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
            'Foto profil anda'), 
      ),
      body: Center(
        child: PhotoView(
          imageProvider: NetworkImage(profilePhoto),
          loadingBuilder: (context, progress) => Center(
            child: Container(
              width: 20.0,
              height: 20.0,
              child: CircularProgressIndicator(
                value: progress == null || progress.expectedTotalBytes == null
                    ? null
                    : progress.cumulativeBytesLoaded /
                        progress.expectedTotalBytes!,
              ),
            ),
          ),
          backgroundDecoration: BoxDecoration(color: Colors.black),
          gaplessPlayback: false,
          customSize: MediaQuery.of(context).size,
          heroAttributes: const PhotoViewHeroAttributes(
            tag: "someTag",
            transitionOnUserGestures: true,
          ),
          scaleStateChangedCallback: (scaleState) {
            // Your scale state change callback logic here
          },
          enableRotation: true,
          minScale: PhotoViewComputedScale.contained * 0.8,
          maxScale: PhotoViewComputedScale.covered * 1.8,
          initialScale: PhotoViewComputedScale.contained,
          basePosition: Alignment.center,
        ),
      ),
    );
  }
}
