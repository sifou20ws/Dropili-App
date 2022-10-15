import 'package:flutter/material.dart';

import '../widgets/form_widget.dart';
import '../widgets/more_options_widget.dart';
import '../widgets/signin_button_widget.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        // resizeToAvoidBottomInset: false,
        body: SingleChildScrollView(
      child: Container(
        padding: EdgeInsets.only(bottom: 20),
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        // padding: EdgeInsets.only(left: 100, right: 100),
        decoration: BoxDecoration(
            color: Colors.white,
            image: DecorationImage(
                image: AssetImage('assets/Background.png'), fit: BoxFit.cover)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Spacer(),
            Text(
              'Connexion',
              style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.w500,
                  color: Colors.white),
            ),
            SizedBox(
              height: 20,
            ),
            FormWidget(),
            SizedBox(
              height: 20,
            ),
            SigninButton(),
            SizedBox(
              height: 50,
            ),
            MoreOptions(),
            Spacer(),
            Padding(
              padding: const EdgeInsets.only(left: 140, right: 140),
              child: Image(image: AssetImage('assets/dropili.png')),
            ),
          ],
        ),
      ),
    ));
  }
}

// Alimunium - zitoun k7al - variante / les cornichant
// zit ilio - ma3jouun - maxon chocolat - farina - khamir / isis  
// papier rolo / 4 bidh / chlada khas / 10 rami / paki marlboro switch
