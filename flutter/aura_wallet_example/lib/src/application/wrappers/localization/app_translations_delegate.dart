import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'localization_manager.dart';

class AppTranslationsDelegate
    extends LocalizationsDelegate<AppLocalizationManager> {
  const AppTranslationsDelegate();

  @override
  bool isSupported(Locale locale) =>
      AppLocalizationManager.instance.isSupportLocale(locale);

  @override
  Future<AppLocalizationManager> load(Locale locale) {
    AppLocalizationManager localization = AppLocalizationManager.instance;
    localization.setCurrentLocale(locale);

    return SynchronousFuture<AppLocalizationManager>(localization);
  }

  @override
  bool shouldReload(
          covariant LocalizationsDelegate<AppLocalizationManager> old) =>
      false;
}
