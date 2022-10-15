import 'package:flutter/material.dart';

class MoreOptions extends StatelessWidget {
  const MoreOptions({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[
          Text(
            'Ou inscrivez-vous avec',
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
          SizedBox(height: 50),
          Text(
            'Vous avez déjà un compte ?',
            style: TextStyle(
              fontSize: 18,
              color: Colors.white,
            ),
          ),
          GestureDetector(
            onTap: () {
              Navigator.pushReplacementNamed(context, '/signin');
            },
            child: Text(
              'Se connecter',
              style: TextStyle(
                fontSize: 18,
                decoration: TextDecoration.underline,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
