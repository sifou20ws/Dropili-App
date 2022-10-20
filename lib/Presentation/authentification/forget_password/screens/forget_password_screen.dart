import 'package:dropili/domain/userRepository/auth_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:dropili/Presentation/authentification/bloc/auth_bloc.dart';
import '../../comun_widgets/error_message_widget.dart';
import '../../comun_widgets/progress_indicator.dart';

class ResetPasswordScreen extends StatefulWidget {
  const ResetPasswordScreen({super.key});

  @override
  State<ResetPasswordScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<ResetPasswordScreen> {
  @override
  Widget build(BuildContext context) {
    return RepositoryProvider(
      create: (context) => AuthRepository(),

      child: BlocProvider(
        create: (context) => AuthBloc(context.read<AuthRepository>()),
        child: Scaffold(
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
            child: SafeArea(
              child: BlocBuilder<AuthBloc, AuthState>(
                builder: (context, state) {
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      SizedBox(
                        height: 20,
                      ),
                      Row(
                        children: [
                          SizedBox(
                            width: 20,
                          ),
                          GestureDetector(
                            onTap: () {
                              Navigator.pop(context);
                            },
                            child: Icon(
                              Icons.arrow_back_ios_new,
                              color: Colors.white,
                              size: 30,
                            ),
                          )
                        ],
                      ),
                      Spacer(),
                      Text(
                        'Rester votre mot de pass',
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
                              text: 'Soumission...',
                            )
                          : ResetButton(),
                      SizedBox(
                        height: 30,
                      ),
                      Spacer(),
                      Padding(
                        padding: const EdgeInsets.only(left: 140, right: 140),
                        child: Image(image: AssetImage('assets/dropili.png')),
                      ),
                    ],
                  );
                },
              ),
            ),
          ),
        )),
      ),
    );
  }
}

class ResetButton extends StatelessWidget {
  const ResetButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 45,
      width: 250,
      child: ElevatedButton(
        onPressed: () {
          BlocProvider.of<AuthBloc>(context).add(RestoreSubmittingEvent());
          // Navigator.pushReplacementNamed(context, '/signin');
        },
        child: Text(
          'Soumettre',
          style: TextStyle(
              fontWeight: FontWeight.w400, fontSize: 18, color: Colors.blue),
        ),
        style: ElevatedButton.styleFrom(
            backgroundColor: Colors.white,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(13))),
      ),
    );
  }
}

class FormWidget extends StatefulWidget {
  const FormWidget({super.key});

  @override
  State<FormWidget> createState() => _FormWidgetState();
}

class _FormWidgetState extends State<FormWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.85,
      // height: 300,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(25),
        boxShadow: [
          BoxShadow(
            color: Color.fromARGB(50, 29, 29, 29),
            offset: Offset(0.0, 2.0),
            blurRadius: 10,
          ),
        ],
      ),
      child: Column(
        children: [
          context.read<AuthBloc>().state.status == Status.fail
              ? ErrorMessageWidget(
                  text: context.read<AuthBloc>().state.errorMessage)
              : Container(),
          Padding(
            padding:
                const EdgeInsets.only(bottom: 10, left: 20, right: 30, top: 10),
            child: Column(children: [
              TextFormField(
                onChanged: (value) {
                  BlocProvider.of<AuthBloc>(context)
                      .add(EmailTextChangeEvent(value));
                },
                decoration: InputDecoration(
                  icon: Icon(Icons.email),
                  labelText: "Email",
                  errorText: context.read<AuthBloc>().state.emailValid
                      ? null
                      : "Adresse e-mail non valide",
                  // labelText: 'Email',
                ),
                validator: null,
              ),
              SizedBox(
                height: 10,
              ),
            ]),
          ),
        ],
      ),
    );
  }
}
