import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dropili/Presentation/authentification/bloc/auth_bloc.dart';

import '../../comun_widgets/error_message_widget.dart';

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
                const EdgeInsets.only(bottom: 10, left: 20, right: 30, top: 20),
            child: Column(children: [
              TextFormField(
                onChanged: (value) {
                  BlocProvider.of<AuthBloc>(context)
                      .add(NameTextChangedEvent(value));
                },
                decoration: InputDecoration(
                    icon: Icon(Icons.person),
                    labelText: "Nom",
                    errorText: context.read<AuthBloc>().state.nameValid
                        ? null
                        : 'Nom trop court'

                    // labelText: 'Email',
                    ),
                validator: null,
              ),
              SizedBox(
                height: 10,
              ),
              TextFormField(
                onChanged: (value) {
                  BlocProvider.of<AuthBloc>(context)
                      .add(UsernameChangedEvent(value));
                },
                decoration: InputDecoration(
                    icon: Icon(Icons.person),
                    labelText: "Nome d'utilisateur",
                    errorText: context.read<AuthBloc>().state.usernameValid
                        ? null
                        : "Nom d\'utilisateur trop court"),
                validator: null,
              ),
              SizedBox(
                height: 10,
              ),
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
              TextFormField(
                onChanged: (value) {
                  BlocProvider.of<AuthBloc>(context)
                      .add(PasswordTextChangeEvent(value));
                },
                decoration: InputDecoration(
                  icon: Icon(Icons.lock),
                  // hintText: "Password",
                  labelText: 'Mot de pass',
                  errorText: context.read<AuthBloc>().state.passwordValid
                      ? null
                      : 'Mot de passe trop court',
                ),
                validator: null,
                obscureText: true,
              ),
              SizedBox(
                height: 30,
              ),
            ]),
          ),
        ],
      ),
    );
  }
}
