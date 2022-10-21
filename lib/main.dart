import 'package:dropili/Presentation/authentification/forget_password/screens/forget_password_screen.dart';
import 'package:dropili/Presentation/authentification/Login/screens/login_screen.dart';
import 'package:dropili/Presentation/authentification/signup/screens/signup_screen.dart';
import 'package:dropili/Presentation/home/home_screen.dart';
import 'package:dropili/Presentation/loadingScreen.dart';
import 'package:dropili/Presentation/onBoarding/screens/on_boarding_screen.dart';
import 'package:flutter/material.dart';

void main() async {
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
      theme: ThemeData(primaryColor: Colors.blue, fontFamily: 'Roboto'),
      routes: {
        '/': (context) => LoadinScreen(),
        '/onBoard': ((context) => OnBoardingScreen()),
        '/signin': ((context) => LoginScreen()),
        '/register': ((context) => SignupScreen()),
        '/signin/reset': ((context) => ResetPasswordScreen()),
        '/home': ((context) => HomeScreen()),
      },
    );
  }
}
