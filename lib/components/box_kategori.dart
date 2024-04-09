import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class BoxKategori extends StatelessWidget {

  final Color color;
  final String imageUrl;
  final String label;
  final double width;
  final double height;

  const BoxKategori({super.key, required this.color, required this.imageUrl, required this.label, required this.width, required this.height});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 152,
      height: 154,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(imageUrl, fit: BoxFit.cover,width: width, height: height,),
            SizedBox(height: 6,),
            Text(label, style: TextStyle(
              fontWeight: FontWeight.w700,
              color: Colors.white,
            ),),
          ],
        ),
      ),
    );
  }
}
