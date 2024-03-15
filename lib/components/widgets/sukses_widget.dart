import 'package:flutter/material.dart';

class SuksesPage extends StatelessWidget {

  final String label;
  const SuksesPage({super.key, required this.label});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.check_circle, color: Color(0xff6FD73E), size: 178,),
            SizedBox(height: 43,),
            Text(label, style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.w700,
            ),),
          ],
        ),
      ),
    );
  }
}
