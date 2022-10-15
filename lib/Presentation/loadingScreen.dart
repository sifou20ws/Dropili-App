import 'package:flutter/material.dart';

class LoadinScreen extends StatefulWidget {
  const LoadinScreen({super.key});

  @override
  State<LoadinScreen> createState() => _LoadinScreenState();
}

class _LoadinScreenState extends State<LoadinScreen> {
  @override
  void initState() {
    super.initState();
    justwait();
  }

  void justwait() async {
    await Future.delayed(Duration(seconds: 5), (() {
      Navigator.pushReplacementNamed(context, '/onBoard');
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
