import 'package:dropili/Presentation/authentification/bloc/auth_bloc.dart';
import 'package:dropili/common/extensions/translation_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:dropili/Presentation/authentification/comun_widgets/message_widget.dart';

class FormWidget extends StatefulWidget {
  const FormWidget({super.key});

  @override
  State<FormWidget> createState() => _FormWidgetState();
}

class _FormWidgetState extends State<FormWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.80,
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
            child: Column(children: [
              TextFormField(
                onChanged: ((value) {
                  BlocProvider.of<AuthBloc>(context)
                      .add(UsernameChangedEvent(value));
                }),
                decoration: InputDecoration(
                  icon: Icon(Icons.email),
                  labelText: 'username'.t(context),
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
                  labelText: 'password'.t(context),
                  suffixIcon: IconButton(
                    onPressed: (() {
                      BlocProvider.of<AuthBloc>(context).add(
                          PasswordVisibiltyChangeEvent(
                              !context.read<AuthBloc>().state.passwordVisible));
                    }),
                    icon: Icon(
                      !context.read<AuthBloc>().state.passwordVisible
                          ? Icons.visibility
                          : Icons.visibility_off,
                    ),
                    color: Colors.grey[600],
                    iconSize: 24,
                  ),
                ),
                // obscureText: false,
                obscureText: !context.read<AuthBloc>().state.passwordVisible,
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
                        'forget password'.t(context),
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
