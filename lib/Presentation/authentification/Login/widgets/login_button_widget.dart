import 'package:dropili/common/extensions/translation_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:dropili/Presentation/authentification/bloc/auth_bloc.dart';

class SigninButton extends StatelessWidget {
  const SigninButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 52,
      width: double.infinity,
      child: ElevatedButton(
        onPressed: () {
          // Navigator.pushReplacementNamed(context, '/signin');
          BlocProvider.of<AuthBloc>(context).add(LoginSubmittingEvent());
        },
        child: Text(
          'Signin'.t(context),
          style: TextStyle(
            fontWeight: FontWeight.w500,
            fontSize: 18,
            color: Colors.blue,
          ),
        ),
        style: ElevatedButton.styleFrom(
          elevation: 5,
          shadowColor: Colors.black.withAlpha(150),
          backgroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
      ),
    );
  }
}
