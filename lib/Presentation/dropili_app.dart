import 'package:dropili/Presentation/home/EditProfilePage/screens/editProfilePage.dart';
import 'package:dropili/Presentation/home/ProfilePage/screens/profileScreen_page.dart';
import 'package:dropili/Presentation/localization/app_localization.dart';
import 'package:dropili/Presentation/localization/bloc/language_bloc.dart';
import 'package:dropili/common/constant/languages.dart';
import 'package:dropili/di/get_it.dart';
import 'package:flutter/material.dart';

import 'package:dropili/Presentation/authentification/forget_password/screens/forget_password_screen.dart';
import 'package:dropili/Presentation/authentification/Login/screens/login_screen.dart';
import 'package:dropili/Presentation/authentification/signup/screens/signup_screen.dart';
import 'package:dropili/Presentation/loading_screen/loadingScreen.dart';
import 'package:dropili/Presentation/onBoarding/screens/on_boarding_screen.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

class DropiliApp extends StatefulWidget {
  const DropiliApp({Key? key}) : super(key: key);

  @override
  State<DropiliApp> createState() => _DropiliAppState();
}

class _DropiliAppState extends State<DropiliApp> {
  late LanguageBloc _languageBloc;

  @override
  void initState() {
    super.initState();
    _languageBloc = getItInstace<LanguageBloc>();
  }

  @override
  void dispose() {
    super.dispose();
    _languageBloc.close();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: _languageBloc,
      child: BlocBuilder<LanguageBloc, LanguageState>(
        builder: (context, state) {
          return state is LanguageLoaded
              ? MaterialApp(
                  title: 'Dropili',
                  debugShowCheckedModeBanner: false,
                  theme: ThemeData(
                      primaryColor: Colors.blue, fontFamily: 'Roboto'),
                  routes: {
                    '/': (context) => LoadinScreen(),
                    '/onBoard': ((context) => OnBoardingScreen()),
                    '/signin': ((context) => LoginScreen()),
                    '/register': ((context) => SignupScreen()),
                    '/signin/reset': ((context) => ResetPasswordScreen()),
                    '/home': ((context) => ProfilePage()),
                    '/editProfile' : ((context) => EditProfilePage()),
                  },
                  supportedLocales:
                      Languages.languages.map((e) => Locale(e.code)).toList(),
                  localizationsDelegates: [
                    AppLocalizations.delegate,
                    GlobalMaterialLocalizations.delegate,
                    GlobalWidgetsLocalizations.delegate,
                  ],
                  locale: state.locale,
                )
              : SizedBox.shrink();
        },
      ),
    );
  }
}
