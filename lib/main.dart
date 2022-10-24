import 'dart:async';

import 'package:dropili/Presentation/dropili_app.dart';
import 'package:flutter/material.dart';
import 'package:dropili/di/get_it.dart' as getIt;
import 'package:flutter/services.dart';

import 'Presentation/ProfilePage/screens/profileScreen_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  unawaited(
      SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]));
  unawaited(getIt.init());
  runApp(const DropiliApp());
}
