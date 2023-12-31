import 'package:dropili/Presentation/change_language/change_language_sceen2.dart';
import 'package:dropili/Presentation/home/EditProfilePage/screens/edit_profile_screen.dart';
import 'package:dropili/Presentation/home/collectionPage/screens/friend_profile_screen.dart';
import 'package:dropili/Presentation/home/root/home_screen.dart';
import 'package:dropili/Presentation/home/scanned_profile/scanned_profile_screen.dart';
import 'package:flutter/material.dart';

import 'package:dropili/Presentation/authentification/Login/screens/login_screen.dart';
import 'package:dropili/Presentation/authentification/forget_password/screens/forget_password_screen.dart';
import 'package:dropili/Presentation/authentification/signup/screens/signup_screen.dart';
import 'package:dropili/Presentation/loading_screen/loadingScreen.dart';
import 'package:dropili/Presentation/onBoarding/screens/on_boarding_screen.dart';

class Routes {
  static Map<String, WidgetBuilder> getRoutes(RouteSettings setting) => {
        '/': (context) => LoadinScreen(),
        '/onBoard': ((context) => OnBoardingScreen()),
        '/signin': ((context) => LoginScreen()),
        '/register': ((context) => SignupScreen()),
        '/signin/reset': ((context) => ResetPasswordScreen()),
        '/changeLanguage': ((context) => LanguageChangeScreen()),
        '/home': ((context) => HomeScreen()),
        '/editProfile': ((context) => EditProfilePage()),
        '/showFriend': (context) => FriendProfileScreen(),
        '/scannedProfile': (context) => ScannedProfileScreen(),
      };
}
