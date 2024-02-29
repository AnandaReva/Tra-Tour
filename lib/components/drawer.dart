import 'package:flutter/material.dart';

class DrawerMenu extends StatelessWidget {
  const DrawerMenu({Key? key}) : super(key: key);

  static const mainColor = Color.fromRGBO(21, 16, 38, 1.0);
  static const baseColor = Color.fromRGBO(240, 240, 240, 1.0);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: const <Widget>[
          DrawerHeader(
            decoration: BoxDecoration(
              color: mainColor,
            ),
            child: Text(
              'Popular',
              style: TextStyle(
                fontFamily: 'Poppins-Bold',
                fontWeight: FontWeight.bold,
                color: baseColor, // Warna teks hitam
              ),
            ),
          ),
          ListTile(
            title: Text('Home'),
            /* selected: _selectedIndex == 0,
              onTap: () {
                _onItemTapped(0);
                Navigator.pop(context);
              }, */
          ),
          ListTile(
            title: Text('Business'),
            /*  selected: _selectedIndex == 1,
              onTap: () {
                _onItemTapped(1);
                Navigator.pop(context);
              }, */
          ),
          ListTile(
            title: Text('School'),
            /*  selected: _selectedIndex == 2,
              onTap: () {
                _onItemTapped(2);
                Navigator.pop(context);
              }, */
          ),
        ],
      ),
    );
  }
}
