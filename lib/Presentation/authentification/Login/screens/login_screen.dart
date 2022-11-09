import 'package:dropili/Presentation/authentification/Login/widgets/login_form_widget%20copy.dart';
import 'package:dropili/Presentation/authentification/comun_widgets/progress_indicator.dart';
import 'package:dropili/common/extensions/translation_extension.dart';
import 'package:dropili/domain/repositories/auth_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:dropili/Presentation/authentification/bloc/auth_bloc.dart';
import 'package:dropili/di/get_it.dart' as getIt;

import 'package:dropili/Presentation/authentification/Login/widgets/login_form_widget.dart';
import 'package:dropili/Presentation/authentification/Login/widgets/more_options_widget.dart';
import 'package:dropili/Presentation/authentification/Login/widgets/signin_button_widget.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  late AuthBloc _authBloc;
  @override
  void initState() {
    super.initState();
    _authBloc = AuthBloc(getIt.getItInstace<AuthRepository>());
  }

  @override
  void dispose() {
    _authBloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: _authBloc,
      child: Scaffold(
          body: SingleChildScrollView(
        child: BlocListener<AuthBloc, AuthState>(
          listener: (context, state) async {
            if (state.status == Status.success) {
              await Future.delayed(Duration(seconds: 1));
              Navigator.pushReplacementNamed(context, '/home');
            }
          },
          child: BlocBuilder<AuthBloc, AuthState>(
            builder: (context, state) {
              return Container(
                padding:
                    EdgeInsets.only(bottom: 20, top: 0, left: 45, right: 45),
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                // padding: EdgeInsets.only(left: 100, right: 100),
                decoration: BoxDecoration(
                    color: Colors.white,
                    image: DecorationImage(
                        image: AssetImage('assets/Background.png'),
                        fit: BoxFit.cover)),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Spacer(),
                    SizedBox(
                      height: 80,
                    ),
                    Text(
                      'Signin'.t(context),
                      style: TextStyle(
                          fontSize: 27,
                          fontWeight: FontWeight.w600,
                          color: Colors.white),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      'Good to see you'.t(context),
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w400,
                          color: Colors.white),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    LogingFormWidget(),
                    SizedBox(
                      height: 20,
                    ),
                    state.status == Status.loading
                        ? LoadingIndicatorWidget(
                            text: 'Signin'.t(context) + '...',
                          )
                        : state.status == Status.success
                            ? Container()
                            : SigninButton(),
                    SizedBox(
                      height: 60,
                    ),
                    MoreOptions(),
                    Spacer(),
                    SwitchToSignupWidget(),
                    SizedBox(
                      height: 50,
                    ),
                    // Image(
                    //   image: AssetImage(
                    //     'assets/dropili.png',
                    //   ),
                    //   width: 120,
                    // ),
                  ],
                ),
              );
            },
          ),
        ),
      )),
    );
  }
}

// Alimunium - zitoun k7al - variante / les cornichant
// zit ilio - ma3jouun - maxon chocolat - farina - khamir / isis  
// papier rolo / 4 bidh / chlada khas / 10 rami / paki marlboro switch
