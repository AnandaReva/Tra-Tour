import 'package:flutter/cupertino.dart';

class BoxPriceList extends StatelessWidget {
  final String item;
  final String harga;
  const BoxPriceList({super.key, required this.item, required this.harga});

  @override
  Widget build(BuildContext context) {
    return Expanded(child: Container(
      padding: EdgeInsets.symmetric(vertical: 14, horizontal: 16),
      decoration: BoxDecoration(
        border: Border.all(
          width: 1,
        )
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(item, style: TextStyle(
              fontWeight: FontWeight.w700,
              fontSize: 12
          ),),
          SizedBox(height: 6,),
          Text('Rp $harga', style: TextStyle(
            fontWeight: FontWeight.w700,
            fontSize: 12
          ),),
        ],
      ),
    ),);
  }
}
