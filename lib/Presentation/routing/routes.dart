import 'package:dropili/Presentation/home/ProfilePage/screens/profileScreen_page.dart';
import 'package:dropili/Presentation/home/root/home_screen.dart';
import 'package:flutter/material.dart';

import 'package:dropili/Presentation/authentification/Login/screens/login_screen.dart';
import 'package:dropili/Presentation/authentification/forget_password/screens/forget_password_screen.dart';
import 'package:dropili/Presentation/authentification/signup/screens/signup_screen.dart';
import 'package:dropili/Presentation/change_language/change_language_screen.dart';
import 'package:dropili/Presentation/loading_screen/loadingScreen.dart';
import 'package:dropili/Presentation/onBoarding/screens/on_boarding_screen.dart';

class Routes {
  static Map<String, WidgetBuilder> getRoutes(RouteSettings setting) => {
        '/': (context) => LoadinScreen(),
        '/onBoard': ((context) => OnBoardingScreen()),
        '/signin': ((context) => LoginScreen()),
        '/register': ((context) => SignupScreen()),
        '/signin/reset': ((context) => ResetPasswordScreen()),
        '/changeLanguage': ((context) => ChangeLanguageScreen()),
        '/profile': ((context) => ProfilePage()),
        '/home': ((context) => HomeScreen()),
      };
}
