import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'dart:io';
import 'package:flutter/services.dart';

class AppLocalizationManager {
  static AppLocalizationManager? _appLocalizationManager;

  AppLocalizationManager._init();

  factory AppLocalizationManager() {
    _appLocalizationManager ??= AppLocalizationManager._init();

    return _appLocalizationManager!;
  }

  static AppLocalizationManager get instance => AppLocalizationManager();

  final Map<String, Map<String, String>> _localize = {};

  Locale locale = const Locale('vi');

  Map<String, String> get _currentLocalize =>
      _localize[locale.languageCode] ?? <String, String>{};

  static AppLocalizationManager of(BuildContext context) {
    return Localizations.of<AppLocalizationManager>(
        context, AppLocalizationManager)!;
  }

  bool isSupportLocale(Locale locale) {
    return _localize.containsKey(locale.languageCode);
  }

  void setCurrentLocale(Locale locale) {
    if (isSupportLocale(locale)) {
      locale = locale;
    }
  }

  List<String> get supportedLang =>
      _localize.entries.map((e) => e.key).toList();

  Future<void> load() async {
    const String languageFolder =
        'assets/language/';

    List<String> supportedLanguage = ['en', 'vi'];

    await Future.wait(supportedLanguage.map((langCode) async {
      String loader = '';
      try {
        loader = await rootBundle.loadString('$languageFolder$langCode.json');
      } catch (e) {
        loader = await rootBundle.loadString('$languageFolder${'vi.json'}');
      }
      _localize[langCode] =
          Map<String, String>.from(jsonDecode(loader) as Map<String, dynamic>);
    }));

    _initLocale();
  }

  ///set lang from server
  void loadFromJson(Map<String, Map<String, String>> json) {
    json.forEach((key, value) {
      if (_localize[key.toLowerCase()] != null) {
        _localize[key.toLowerCase()]!.addAll(value);
      } else {
        _localize[key.toLowerCase()] = value;
      }
    });
  }

  void _initLocale() {
    String localeName = Platform.localeName;

    Locale deviceLocale;

    if (localeName.toLowerCase() == 'vi' ||
        localeName.toLowerCase() == 'vi_vn') {
      deviceLocale = const Locale('vi');
    } else {
      deviceLocale = const Locale('en');
    }

    if (isSupportLocale(deviceLocale)) {
      locale = deviceLocale;
    } else {
      locale = const Locale('en');
    }
  }

  Locale getAppLocale() {
    return locale;
  }

  String translate(String key) {
    return _currentLocalize[key] ?? key;
  }

  String translateWithParam(String key, Map<String, dynamic> param) {
    if (_currentLocalize[key] != null) {
      String currentValue = _currentLocalize[key]!;

      param.forEach((paramKey, paramValue) {
        currentValue = currentValue.replaceFirst(
          '\${$paramKey}',
          paramValue.toString(),
        );
      });
      return currentValue;
    }

    return key;
  }
}
