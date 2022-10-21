import 'package:dropili/Presentation/authentification/bloc/auth_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../comun_widgets/message_widget.dart';

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
          context.read<AuthBloc>().state.status == Status.fail
              ? MessageWidget(
                  color: 'red',
                  text: context.read<AuthBloc>().state.errorMessage)
              : context.read<AuthBloc>().state.status == Status.success
                  ? MessageWidget(
                      color: 'green',
                      text: 'Signed in successfully',
                    )
                  : Container(),
          Padding(
            padding:
                const EdgeInsets.only(bottom: 20, left: 20, right: 30, top: 20),
            // child: BlocBuilder<AuthBloc, LoginState>(
            //   builder: (context, state) {
            // return
            child: Column(children: [
              TextFormField(
                onChanged: ((value) {
                  BlocProvider.of<AuthBloc>(context)
                      .add(UsernameChangedEvent(value));
                }),
                decoration: InputDecoration(
                  icon: Icon(Icons.email),
                  labelText: "Nom d'utilisteur",
                ),
                validator: null,
              ),
              SizedBox(
                height: 10,
              ),
              TextFormField(
                onChanged: ((value) {
                  BlocProvider.of<AuthBloc>(context)
                      .add(PasswordTextChangeEvent(value));
                }),
                decoration: InputDecoration(
                  icon: Icon(Icons.lock),
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
                    child: Container(
                      height: 20,
                      child: Text(
                        'Mot de pass oublié ?',
                        style: TextStyle(
                          decoration: TextDecoration.underline,
                          fontSize: 14,
                          color: Colors.blue,
                        ),
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
