import 'package:flutter/material.dart';

var darkTheme = ThemeData.dark();
var lightTheme= ThemeData.light();

class ThemeChanger extends ChangeNotifier {
  ThemeData _themeData;
  ThemeChanger(this._themeData);

  get getTheme => _themeData;
  void setTheme(ThemeData theme) {
    _themeData = theme;
    notifyListeners();
  }
}