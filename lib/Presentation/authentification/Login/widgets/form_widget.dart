import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/login_bloc.dart';
import 'error_message_widget.dart';

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
        borderRadius: BorderRadius.circular(20),
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
          context.read<LoginBloc>().state.status == Status.fail
              ? ErrorMessageWidget(
                  text: context.read<LoginBloc>().state.errorMessage)
              : Container(),
          Padding(
            padding:
                const EdgeInsets.only(bottom: 20, left: 20, right: 30, top: 20),
            // child: BlocBuilder<LoginBloc, LoginState>(
            //   builder: (context, state) {
            // return
            child: Column(children: [
              TextFormField(
                onChanged: ((value) {
                  BlocProvider.of<LoginBloc>(context)
                      .add(EmailTextChangeEvent(value));
                }),
                decoration: InputDecoration(
                  icon: Icon(Icons.email),
                  labelText: "Email",
                  errorText: context.read<LoginBloc>().state.emailValid
                      ? null
                      : "Adresse e-mail non valide",
                ),
                validator: null,
              ),
              SizedBox(
                height: 10,
              ),
              TextFormField(
                onChanged: ((value) {
                  BlocProvider.of<LoginBloc>(context)
                      .add(PasswordTextChangeEvent(
                    value,
                  ));
                }),
                decoration: InputDecoration(
                  icon: Icon(Icons.lock),
                  errorText: context.read<LoginBloc>().state.passwordValid
                      ? null
                      : 'Mot de passe trop court',

                  // hintText: "Password",
                  labelText: 'Mot de pass',
                ),
                obscureText: true,
              ),
              SizedBox(
                height: 25,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(context, '/signin/reset');
                    },
                    child: Text(
                      'Mot de pass oublié ?',
                      style: TextStyle(
                        decoration: TextDecoration.underline,
                        fontSize: 14,
                        color: Colors.blue,
                      ),
                    ),
                  ),
                ],
              ),
            ]),
          ),
        ],
      ),
    );
  }
}
