import 'package:flutter/material.dart';

class Settings extends ChangeNotifier {
  final Map<String, ThemeData> _themes = {
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
  ThemeData _themeData;

  bool _showJalaliDate = true;

  ThemeData get themeData =>
      _themeData = _themeData == null ? _themes['blue'] : _themeData;

  ThemeData get darkTheme => _themes['dark'];

  bool get darkMode => _themeData == _themes['dark'] ? true : false;

  bool get showJalaliDate => _showJalaliDate;

  set setThemeData(ThemeData theme) {
    _themeData = theme;
    notifyListeners();
  }

  set switchDarkMode(bool status) {
    _themeData = status ? _themes['dark'] : _themes['blue'];
    notifyListeners();
  }

  set showJalaliDate(bool status) {
    _showJalaliDate = status;
    notifyListeners();
  }
}
