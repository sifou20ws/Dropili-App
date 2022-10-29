import 'package:dropili/common/extensions/translation_extension.dart';
import 'package:flutter/material.dart';

class MoreOptions extends StatelessWidget {
  const MoreOptions({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
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
          Container(
            padding: EdgeInsets.all(8),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                border: Border.all(color: Colors.white, width: 1)),
            child: SizedBox(
              height: 35,
              child: Image(
                image: AssetImage('assets/google_logo.png'),
              ),
            ),
          ),
          SizedBox(height: 40),
          Text(
            'don\'t have an account'.t(context),
            style: TextStyle(
              fontSize: 18,
              color: Colors.white,
            ),
          ),
          SizedBox(
            height: 10,
          ),
          GestureDetector(
            onTap: () {
              Navigator.pushReplacementNamed(context, '/signin');
            },
            child: Text(
              'Signin'.t(context),
              style: TextStyle(
                fontSize: 19,
                decoration: TextDecoration.underline,
                color: Colors.white,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
