import 'package:dropili/common/extensions/translation_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:dropili/Presentation/authentification/bloc/auth_bloc.dart';

class SingupButton extends StatelessWidget {
  const SingupButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 45,
      width: 250,
      child: ElevatedButton(
        onPressed: () {
          BlocProvider.of<AuthBloc>(context).add(SignupSubmittingEvent());
        },
        child: Text(
          'Signup'.t(context),
          style: TextStyle(
              fontWeight: FontWeight.w400, fontSize: 18, color: Colors.blue),
        ),
        style: ElevatedButton.styleFrom(
            backgroundColor: Colors.white,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(25))),
      ),
    );
  }
}
