import 'package:flutter/material.dart';

class GlobalVar extends ChangeNotifier {
  static final GlobalVar _instance = GlobalVar._internal();
  static const mainColor = Color.fromRGBO(29, 121, 72, 1.0);
  static const secondaryColor = Color.fromRGBO(251, 188, 5, 1.0);
  static const baseColor = Color.fromRGBO(217, 217, 217, 1.0);

  dynamic _userLoginData;
  bool _isLogin = false;
  bool _isLoading = false;
  int _selectedIndex = 0;
  String _selected_role_onboarding = "";
  int _initScreen = 0;

  List<int> _selectedTrashIndexes = []; // Initialize with an empty list

  int get selectedIndex => _selectedIndex;
  set selectedIndex(int value) {
    _selectedIndex = value;
    notifyListeners();
  }

  List<int> get selectedTrashIndexes => _selectedTrashIndexes;
  set selectedTrashIndexes(List<int> value) {
    _selectedTrashIndexes = value;
    notifyListeners();
  }

  int get initScreen => _initScreen;
  set initScreen(int value) {
    _initScreen = value;
    notifyListeners();
  }

  String get selected_role_onboarding => _selected_role_onboarding;

  dynamic get userLoginData => _userLoginData;
  bool get isLogin => _isLogin;
  bool get isLoading => _isLoading;

  set userLoginData(dynamic value) {
    _userLoginData = value;
    notifyListeners();
  }

  set isLogin(bool value) {
    _isLogin = value;
  }

  set isLoading(bool value) {
    _isLoading = value;
  }

  set selected_role_onboarding(String value) {
    _selected_role_onboarding = value;
    notifyListeners();
  }

  GlobalVar._internal();

  static GlobalVar get instance => _instance;
}
