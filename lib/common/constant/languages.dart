import 'dart:io';

import 'package:dropili/core/utils/storage.dart';
import 'package:dropili/domain/entities/language_entity.dart';

class Languages {
  const Languages._();

  static const languages = [
    LanguageEntity(code: 'en', value: 'English'),
    // LanguageEntity(code: 'fr', value: 'French'),
    LanguageEntity(code: 'ar', value: 'Arabic'),
  ];

  static Future<String> initialLanguage() async {
    List<String> codes = languages.map((e) => e.code).toList();

    String? storedCode = await LocalStorageHandler.loadLanguage();
    String defaultCode = Platform.localeName.split('_')[0];

    return (storedCode != null && codes.contains(storedCode))
        ? storedCode
        : codes.contains(defaultCode)
            ? defaultCode
            : languages[0].code;
  }
}
