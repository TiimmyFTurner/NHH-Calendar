import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Settings extends ChangeNotifier {
  static final Map<String, ThemeData> _themes = {
    'blue': ThemeData(
      brightness: Brightness.light,
      primaryColor: Colors.blue[600],
      accentColor: Colors.deepOrange[400],
      appBarTheme: AppBarTheme(elevation: 0),
    ),
    'dark': ThemeData(
      brightness: Brightness.dark,
      accentColor: Colors.deepOrange[400],
      appBarTheme: AppBarTheme(elevation: 0),
    )
  };
  ThemeData _themeData = _themes['blue'];

  bool _showJalaliDate = true;

  SharedPreferences _prefs;

  Future readSetting() async {
    _prefs = await SharedPreferences.getInstance();
    _showJalaliDate = _prefs.getBool('jalali') ?? true;
    _themeData = (_prefs.getBool('darkMode') ?? false)
        ? _themes['dark']
        : _themes['blue'];
    notifyListeners();
  }

  ThemeData get themeData => _themeData;

  ThemeData get darkTheme => _themes['dark'];

  bool get darkMode => _themeData == _themes['dark'] ? true : false;

  bool get showJalaliDate => _showJalaliDate;

  set switchDarkMode(bool status) {
    _themeData = status ? _themes['dark'] : _themes['blue'];
    _prefs.setBool('darkMode', status);
    notifyListeners();
  }

  set showJalaliDate(bool status) {
    _showJalaliDate = status;
    _prefs.setBool('jalali', status);
    notifyListeners();
  }
}
