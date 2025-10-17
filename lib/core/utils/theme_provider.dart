import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeProvider extends ChangeNotifier{
  static const _themeKey = 'isDark';
  bool _isDark = false;
  bool get isDark => _isDark;
  
  Future<void> loadTheme() async{
    final prefs = await SharedPreferences.getInstance();
    _isDark = prefs.getBool(_themeKey)??false;
  }

  Future<void> themeToggle() async{
    _isDark = !_isDark;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_themeKey,_isDark);
    notifyListeners();
  }
}