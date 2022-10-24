import 'dart:io';

import 'package:dropili/domain/entities/language_entity.dart';

class Languages {
  const Languages._();

  static const languages = [
    LanguageEntity(code: 'en', value: 'English'),
    LanguageEntity(code: 'fr', value: 'French'),
    LanguageEntity(code: 'ar', value: 'Arabic'),
  ];

  static String deviceLanguageCode() {
    String code = Platform.localeName.split('_')[0];
    List<String> codes = languages.map((e) => e.code).toList();
    return codes.contains(code) ? code : languages[0].code;
  }
}
