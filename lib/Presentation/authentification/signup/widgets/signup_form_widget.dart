import 'package:dropili/Presentation/authentification/comun_widgets/fields_decoration.dart';
import 'package:dropili/common/extensions/translation_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dropili/Presentation/authentification/bloc/auth_bloc.dart';

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
      child: Column(
        children: [
          context.read<AuthBloc>().state.status == Status.fail
              ? MessageWidget(
                  color: 'red',
                  text: context.read<AuthBloc>().state.errorMessage)
              : context.read<AuthBloc>().state.status == Status.success
                  ? MessageWidget(
                      color: 'green',
                      text: 'User created successfully',
                    )
                  : Container(),
          SizedBox(
            height: 16,
          ),
          Column(children: [
            TextFormField(
              onChanged: (value) {
                BlocProvider.of<AuthBloc>(context)
                    .add(NameTextChangedEvent(value));
              },
              style:
                  TextStyle(color: Colors.white, fontWeight: FontWeight.w500),
              decoration: buildInputDecoration(
                text: 'name'.t(context),
              ).copyWith(
                prefixIcon: Icon(
                  Icons.person,
                  color: Colors.white,
                ),
                errorText: context.read<AuthBloc>().state.nameValid
                    ? null
                    : 'name'.t(context) + ' ' + 'short'.t(context),
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
              style:
                  TextStyle(color: Colors.white, fontWeight: FontWeight.w500),
              decoration: buildInputDecoration(text: 'username'.t(context))
                  .copyWith(
                      prefixIcon: Icon(
                        Icons.person_outline_rounded,
                        color: Colors.white,
                      ),
                      // icon: Icon(Icons.person),
                      errorText: context.read<AuthBloc>().state.usernameValid
                          ? null
                          : 'username'.t(context) +
                              ' ' +
                              'not valide'.t(context)),
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
              style:
                  TextStyle(color: Colors.white, fontWeight: FontWeight.w500),
              decoration: buildInputDecoration(
                text: 'email'.t(context),
              ).copyWith(
                prefixIcon: Icon(
                  Icons.email_outlined,
                  color: Colors.white,
                ),
                errorText: context.read<AuthBloc>().state.emailValid
                    ? null
                    : 'email'.t(context) + ' ' + 'not valid'.t(context),
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
              style:
                  TextStyle(color: Colors.white, fontWeight: FontWeight.w500),
              decoration: buildInputDecoration(
                text: 'password'.t(context),
              ).copyWith(
                prefixIcon: Icon(
                  Icons.lock,
                  color: Colors.white,
                ),
                errorText: context.read<AuthBloc>().state.passwordValid
                    ? null
                    : 'password'.t(context) + ' ' + 'short'.t(context),
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
              validator: null,
              obscureText: !context.read<AuthBloc>().state.passwordVisible,
            ),
            SizedBox(
              height: 30,
            ),
          ]),
        ],
      ),
    );
  }
}
