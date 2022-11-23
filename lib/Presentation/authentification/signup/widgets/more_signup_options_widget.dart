import 'package:dropili/Presentation/authentification/bloc/auth_bloc.dart';
import 'package:dropili/common/extensions/translation_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MoreOptions extends StatelessWidget {
  const MoreOptions({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        // mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Text(
            'or signup'.t(context),
            style: TextStyle(
              fontSize: 18,
              color: Colors.white,
            ),
          ),
          SizedBox(
            height: 20,
          ),
          GestureDetector(
            onTap: () {
              BlocProvider.of<AuthBloc>(context).add(GoogleAuthEvent());
            },
            child: Container(
              height: 50,
              width: 120,
              padding: EdgeInsets.all(4),
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: Colors.white, width: 1)),
              child: Image(
                image: AssetImage('assets/google_logo_colored.png'),
              ),
            ),
          ),
          // Spacer(),
        ],
      ),
    );
  }
}

class SwitchWidget extends StatelessWidget {
  const SwitchWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          'You already have an account ?'.t(context),
          style: TextStyle(
            fontSize: 18,
            color: Colors.white,
          ),
        ),
        SizedBox(
          height: 15,
        ),
        GestureDetector(
          onTap: () {
            Navigator.pushReplacementNamed(context, '/signin');
          },
          child: Text(
            'Signin'.t(context),
            style: TextStyle(
                fontSize: 19,
                // decoration: TextDecoration.underline,
                color: Colors.white,
                fontWeight: FontWeight.w600),
          ),
        ),
      ],
    );
  }
}
