import 'dart:ui';

class GlobalVar {
  // Buat instance static dari GlobalVar
  static final GlobalVar _instance = GlobalVar._internal();

  static const mainColor = Color.fromRGBO(64, 130, 109, 1.0);
  static const baseColor = Color.fromRGBO(240, 240, 240, 1.0);

  



// from login
  var _userLoginData;
  var _userLoginPostsData;
  bool _isLogin = false;


  int _selectedIndex;

  // Getter setter
  int get selectedIndex => _selectedIndex;

  get mysql => null;
  set selectedIndex(int value) {
    _selectedIndex = value;
  }




  ////////////////////
  dynamic get userLogindata => _userLoginData;
  dynamic get userLoginPostsData => _userLoginPostsData;
  bool get isLogin => _isLogin;

  set userLogindata(dynamic value) {
    _userLoginData = value;
  }

  set userLoginPostsData(dynamic value) {
    _userLoginPostsData = value;
  }

  set isLogin(bool value) {
    _isLogin = value;
  }

  // Private constructor untuk Singleton
  GlobalVar._internal() : _selectedIndex = 0;

  // Getter untuk instance GlobalVar
  static GlobalVar get instance => _instance;
}
