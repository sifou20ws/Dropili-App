import 'dart:developer';
import 'dart:io' show Platform;

import 'package:flutter/material.dart';

import 'package:dropili/core/utils/storage.dart';
import 'package:flutter/services.dart';

class LoadinScreen extends StatefulWidget {
  const LoadinScreen({super.key});

  @override
  State<LoadinScreen> createState() => _LoadinScreenState();
}

class _LoadinScreenState extends State<LoadinScreen> {
  String? token;
  String nextRoute = '/onBord';

  static const platform = const MethodChannel('http.dropili.co/channel');

  @override
  void initState() {
    super.initState();
    navigate();
  }

  void navigate() async {
    token = await LocalStorageHandler.loadToken();

    String url = '';

    if (token == null) {
      nextRoute = '/onBoard';
    } else {
      nextRoute = '/home';
      startUri().then(
        (value) {
          var val = value.toString();
          log(val == "" ? "ios platform" : "null");
          if (val.contains('dropili')) {
            url = value.toString();
            nextRoute = '/scannedProfile';
          } else {
            nextRoute = '/home';
          }
        },
      );
    }

    await Future.delayed(Duration(seconds: 2));

    if (nextRoute == '/scannedProfile') {
      Navigator.pushReplacementNamed(context, '/home');
      Navigator.pushNamed(context, nextRoute, arguments: url);
      return;
    }

    Navigator.pushReplacementNamed(context, nextRoute);
  }

  Future startUri() async {
    try {
      if (Platform.isAndroid) {
        return await platform.invokeMethod('initialLink');
      } else if (Platform.isIOS) {
        return null;
      }
    } on PlatformException catch (e) {
      return "Failed to Invoke: '${e.message}'.";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.only(left: 100, right: 100),
        decoration: BoxDecoration(
            color: Colors.white,
            image: DecorationImage(
                image: AssetImage('assets/Background.png'), fit: BoxFit.cover)),
        child: Hero(
          tag: 'something',
          child: Image(
            image: AssetImage('assets/dropili.png'),
          ),
        ));
  }
}
