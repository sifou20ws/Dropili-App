
import 'package:flutter/material.dart';

import '../../core/utils/token.dart';

class LoadinScreen extends StatefulWidget {
  const LoadinScreen({super.key});

  @override
  State<LoadinScreen> createState() => _LoadinScreenState();
}

class _LoadinScreenState extends State<LoadinScreen> {
  String? token;
  String? nextRoute;

  @override
  void initState() {
    //token = 'hello';
    super.initState();
    navigate();
  }

  void navigate() async {
    token = await TokenHandler.loadToken();
    String nextRout = token == null ? '/onBoard' : '/home';
    await Future.delayed(Duration(seconds: 3), (() {
      Navigator.pushReplacementNamed(context, nextRout);
    }));
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
