import 'package:flutter/cupertino.dart';

class Point extends StatelessWidget {

  final String text;
  final EdgeInsets? margin;
  const Point({super.key, required this.text, required this.margin});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: margin,
      child: Row(
        children: [
          Container(
            width: 24,
            height: 24,
            decoration: BoxDecoration(
                color: Color(0xffFBBC05),
                borderRadius: BorderRadius.circular(100)),
            child: Center(
              child: Text(
                'P',
                style: TextStyle(
                  fontWeight: FontWeight.w700,
                  fontSize: 12,
                ),
              ),
            ),
          ),
          SizedBox(
            width: 16,
          ),
          Text(text, style: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w600,
          ),)
        ],
      ),
    );
  }
}
