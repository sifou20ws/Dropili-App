import 'package:dropili/common/extensions/translation_extension.dart';
import 'package:dropili/domain/repositories/auth_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dropili/Presentation/authentification/bloc/auth_bloc.dart';
import 'package:dropili/di/get_it.dart' as getIt;

import 'package:dropili/Presentation/authentification/comun_widgets/progress_indicator.dart';
import 'package:dropili/Presentation/authentification/signup/widgets/more_signup_options_widget.dart';
import 'package:dropili/Presentation/authentification/signup/widgets/signup_button_widget.dart';
import 'package:dropili/Presentation/authentification/signup/widgets/signup_form_widget.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
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
        child: Container(
          padding: EdgeInsets.only(bottom: 0, top: 0, left: 45, right: 45),
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          // padding: EdgeInsets.only(left: 100, right: 100),
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage('assets/Background.png'),
                  fit: BoxFit.cover)),
          child: BlocListener<AuthBloc, AuthState>(
            listener: (context, state) async {
              if (state.status == Status.success) {
                await Future.delayed(Duration(seconds: 1));
                Navigator.pushReplacementNamed(context, '/home');
              }
            },
            child: BlocBuilder<AuthBloc, AuthState>(
              builder: (context, state) {
                return SafeArea(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 10,
                      ),
                      Spacer(),
                      Text(
                        'Signup'.t(context),
                        style: TextStyle(
                            fontSize: 25,
                            fontWeight: FontWeight.w500,
                            color: Colors.white),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      FormWidget(),
                      SizedBox(
                        height: 20,
                      ),
                      state.status == Status.loading
                          ? LoadingIndicatorWidget(
                              text: 'Signup'.t(context) + '...',
                            )
                          : state.status == Status.success
                              ? Container()
                              : SingupButton(),
                      SizedBox(
                        height: 30,
                      ),
                      MoreOptions(),
                      // SizedBox(
                      //   height: 60,
                      // ),
                      Spacer(),
                      SwitchWidget(),
                      SizedBox(
                        height: 60,
                      ),
                      // Spacer(),
                      // Padding(
                      //   padding: const EdgeInsets.only(left: 140, right: 140),
                      //   child: Image(image: AssetImage('assets/dropili.png')),
                      // ),
                    ],
                  ),
                );
              },
            ),
          ),
        ),
      )),
    );
  }
}
