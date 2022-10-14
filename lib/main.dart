import 'package:dropili/Presentation/loadingScreen.dart';
import 'package:dropili/Presentation/onBoarding/screens/on_boarding_screen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Dropili',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.red,
      ),
      routes: {
        '/': (context) => LoadinScreen(),
        '/onBoard': ((context) => OnBoardingScreen()),
        '/signin': ((context) => Container()),
        '/register': ((context) => Container())
      },
    );
  }
}
