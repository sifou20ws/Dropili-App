import 'dart:developer';

import 'package:flutter/material.dart';

import 'package:dropili/core/utils/token.dart';
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
    token = await TokenHandler.loadToken();

    String url = '';

    if (token == null) {
      nextRoute = '/onBoard';
    } else {
      nextRoute = '/home';
      startUri().then(
        (value) {
          var val = value.toString();
          log(val);
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

  Future<Object> startUri() async {
    try {
      return await platform.invokeMethod('initialLink');
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
