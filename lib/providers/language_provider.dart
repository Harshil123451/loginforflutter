import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LanguageProvider extends ChangeNotifier {
  static const String _languageKey = 'selected_language';
  final SharedPreferences prefs;
  late Locale _currentLocale;

  LanguageProvider(this.prefs) {
    String? savedLanguage = prefs.getString(_languageKey);
    _currentLocale = Locale(savedLanguage ?? 'en');
  }

  Locale get currentLocale => _currentLocale;

  Future<void> changeLanguage(String languageCode) async {
    if (_currentLocale.languageCode != languageCode) {
      _currentLocale = Locale(languageCode);
      await prefs.setString(_languageKey, languageCode);
      notifyListeners();
    }
  }
} 