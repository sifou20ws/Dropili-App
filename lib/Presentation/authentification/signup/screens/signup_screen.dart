import 'package:dropili/domain/userRepository/auth_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dropili/Presentation/authentification/bloc/auth_bloc.dart';

import '../../comun_widgets/progress_indicator.dart';
import '../widgets/more_signup_options_widget.dart';
import '../widgets/signup_button_widget.dart';
import '../widgets/signup_form_widget.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<SignupScreen> {
  @override
  Widget build(BuildContext context) {
    return RepositoryProvider(
      create: (context) => AuthRepository(),
      child: BlocProvider(
        create: (context) => AuthBloc(context.read<AuthRepository>()),
        child: Scaffold(
            // resizeToAvoidBottomInset: false,
            body: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.only(bottom: 20),
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            // padding: EdgeInsets.only(left: 100, right: 100),
            decoration: BoxDecoration(
                color: Colors.white,
                image: DecorationImage(
                    image: AssetImage('assets/Background.png'),
                    fit: BoxFit.cover)),
            child: BlocBuilder<AuthBloc, AuthState>(
              builder: (context, state) {
                return SafeArea(
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        SizedBox(
                          height: 20,
                        ),
                        Text(
                          'S\'inscrire',
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
                                text: 'Inscription...',
                              )
                            : SingupButton(),
                        SizedBox(
                          height: 30,
                        ),
                        MoreOptions(),
                        SizedBox(
                          height: 60,
                        ),
                        // Spacer(),
                        Padding(
                          padding: const EdgeInsets.only(left: 140, right: 140),
                          child: Image(image: AssetImage('assets/dropili.png')),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        )),
      ),
    );
  }
}
