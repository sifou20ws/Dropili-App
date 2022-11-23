import 'dart:developer';

import 'package:dropili/Presentation/authentification/bloc/auth_bloc.dart';
import 'package:dropili/common/constant/colors.dart';
import 'package:dropili/common/extensions/translation_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:local_auth/error_codes.dart';

class MoreOptions extends StatelessWidget {
  const MoreOptions({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[
          Text(
            'or connect'.t(context),
            style: TextStyle(
              fontSize: 17,
              color: Colors.white,
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                child: GestureDetector(
                  onTap: () {
                    BlocProvider.of<AuthBloc>(context).add(GoogleAuthEvent());
                  },
                  child: Container(
                    height: 50,
                    padding: EdgeInsets.all(4),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(color: Colors.white, width: 1)),
                    child: Image(
                      image: AssetImage('assets/google_logo_colored.png'),
                      // color: MalinColors.AppBlue,
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 50,
                // width: 30,
                child: VerticalDivider(
                  color: Colors.white,
                  width: 50,
                  thickness: 1,
                ),
              ),
              Expanded(
                child: GestureDetector(
                  onTap: () async {
                    BlocProvider.of<AuthBloc>(context).add(BiometricsAuthentifactionEvent());
                  },
                  child: Container(
                    height: 50,
                    padding: EdgeInsets.all(7),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(color: Colors.white, width: 1)),
                    child: Image(
                      image: AssetImage('assets/fingerprint.png'),
                      color: MalinColors.AppBlue,
                    ),
                  ),
                ),
              ),
            ],
          ),
          // SizedBox(
          //   height: 100,
          // ),
          // SwitchToSignupWidget(),
        ],
      ),
    );
  }
}

class SwitchToSignupWidget extends StatelessWidget {
  const SwitchToSignupWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          'don\'t have an account'.t(context),
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
            Navigator.pushReplacementNamed(context, '/register');
          },
          child: Text(
            'Signup Now'.t(context),
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
