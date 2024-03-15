import 'package:flutter/cupertino.dart';

class IconTabs extends StatelessWidget {
  final String icon;
  final String label;
  const IconTabs({super.key, required this.icon, required this.label});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 20, bottom: 20, left: 16),
      child: Column(
        children: [
          Image.asset(
            icon,
            width: 28,
            height: 28,
            fit: BoxFit.cover,
          ),
          SizedBox(height: 2,),
          Text(
            label,
            style: TextStyle(
              fontSize: 10,
            ),
            textAlign: TextAlign.center,
          )
        ],
      ),
    );
  }
}
