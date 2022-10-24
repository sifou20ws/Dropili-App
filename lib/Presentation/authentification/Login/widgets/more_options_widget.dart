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
            'or connect'.t(context),
            style: TextStyle(
              fontSize: 18,
              color: Colors.white,
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
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
              SizedBox(
                height: 50,
                // width: 30,
                child: VerticalDivider(
                  color: Colors.white,
                  width: 50,
                  thickness: 1,
                ),
              ),
              Container(
                padding: EdgeInsets.all(8),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    border: Border.all(color: Colors.white, width: 1)),
                child: SizedBox(
                  height: 35,
                  child: Image(
                    image: AssetImage('assets/fingerprint.png'),
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(
            height: 50,
          ),
          Text(
            'don\'t have an account'.t(context),
            style: TextStyle(
              fontSize: 18,
              color: Colors.white,
            ),
          ),
          GestureDetector(
            onTap: () {
              Navigator.pushReplacementNamed(context, '/register');
            },
            child: Text(
              'Signup'.t(context),
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
