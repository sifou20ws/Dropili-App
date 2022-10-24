import 'package:dropili/Presentation/localization/app_localization.dart';
import 'package:flutter/cupertino.dart';

extension StringExtension on String {
  String t(BuildContext context) {
    return AppLocalizations.of(context)?.translate(this) ?? this;
  }
}
