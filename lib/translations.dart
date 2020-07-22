import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show  rootBundle;

import 'package:smart_reading/application.dart';

class Translations {
  Translations(this.locale);
  final Locale locale;
  static Translations of(BuildContext context) {
    return Localizations.of<Translations>(context, Translations);
  }
  static Map<String, dynamic> _localizedValues;

  String text(String key){
    return _localizedValues[key] ?? '** $key not found';
  }

  static Future<Translations> load(Locale locale) async {
    Translations translations = new Translations(locale);
    String jsonContent = await rootBundle.loadString("assets/locale/i18n_${locale.languageCode}.json");
    _localizedValues = json.decode(jsonContent);
    return translations;
  }

  get currentLanguage => locale.languageCode;
}
class TranslationsDelegate extends LocalizationsDelegate<Translations> {
  const TranslationsDelegate();

  @override
  bool isSupported(Locale locale) => applic.supportedLanguages.contains(locale.languageCode);

  @override
  Future<Translations> load(Locale locale) => Translations.load(locale);

  @override
  bool shouldReload(TranslationsDelegate old) => false;
}
class SpecifiedLocalizationsDelegate extends LocalizationsDelegate<Translations> {
  final Locale overriddenLocale;

  const SpecifiedLocalizationsDelegate(this.overriddenLocale);

  @override
  bool isSupported(Locale locale) => overriddenLocale != null;

  @override
  Future<Translations> load(Locale locale) =>
    Translations.load(overriddenLocale);

  @override
  bool shouldReload(SpecifiedLocalizationsDelegate old) => true;
}

