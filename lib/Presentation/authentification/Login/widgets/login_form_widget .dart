import 'package:dropili/Presentation/authentification/bloc/auth_bloc.dart';
import 'package:dropili/Presentation/authentification/comun_widgets/fields_decoration.dart';
import 'package:dropili/common/extensions/translation_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:dropili/Presentation/authentification/comun_widgets/message_widget.dart';

class LogingFormWidget extends StatefulWidget {
  const LogingFormWidget({super.key});

  @override
  State<LogingFormWidget> createState() => _FormWidgetState();
}

class _FormWidgetState extends State<LogingFormWidget> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        context.read<AuthBloc>().state.status == Status.fail
            ? MessageWidget(
                color: 'red',
                text: context.read<AuthBloc>().state.errorMessage.t(context))
            : context.read<AuthBloc>().state.status == Status.success
                ? MessageWidget(
                    color: 'green',
                    text: 'Signed in successfully'.t(context),
                  )
                : Container(),
        Padding(
          padding: const EdgeInsets.only(bottom: 20, top: 20),
          child: Column(children: [
            TextFormField(
              onChanged: ((value) {
                BlocProvider.of<AuthBloc>(context)
                    .add(UsernameChangedEvent(value));
              }),
              style:
                  TextStyle(color: Colors.white, fontWeight: FontWeight.w500),
              decoration: buildInputDecoration(
                text: 'username'.t(context),
              ).copyWith(
                prefixIcon: Icon(
                  Icons.person_outline,
                  color: Colors.white,
                ),
              ),
              validator: null,
            ),
            SizedBox(
              height: 15,
            ),
            TextFormField(
              onChanged: ((value) {
                BlocProvider.of<AuthBloc>(context)
                    .add(PasswordTextChangeEvent(value));
              }),
              cursorColor: Colors.white,
              style:
                  TextStyle(color: Colors.white, fontWeight: FontWeight.w500),
              decoration:
                  buildInputDecoration(text: 'password'.t(context)).copyWith(
                prefixIcon: Icon(
                  Icons.lock_outline_rounded,
                  color: Colors.white,
                ),
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
                  color: Colors.white,
                  iconSize: 24,
                ),
              ),
              // obscureText: false,
              obscureText: !context.read<AuthBloc>().state.passwordVisible,
            ),
            SizedBox(
              height: 20,
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
                          // decoration: TextDecoration.underline,
                          fontSize: 16,
                          color: Colors.white,
                          fontWeight: FontWeight.w500),
                    ),
                  ),
                ),
              ],
            ),
          ]),
        ),
      ],
    );
  }
}
