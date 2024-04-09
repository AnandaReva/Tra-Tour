import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final double width;
  final Function() onPressed;
  final String text;
  final EdgeInsets? margin;

  const CustomButton(
      {super.key,
      this.width = double.infinity,
      required this.onPressed,
      required this.text,
      this.margin});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: margin,
      width: width,
      height: 32,
      child: TextButton(
        onPressed: onPressed,
        style: TextButton.styleFrom(
          backgroundColor: Color(0xff1D7948),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(6),
          ),
        ),
        child: Text(
          text,
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w700,
            fontSize: 12,
          ),
        ),
      ),
    );
  }
}
