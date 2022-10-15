
import 'package:flutter/material.dart';



class FormWidget extends StatefulWidget {
  const FormWidget({super.key});

  @override
  State<FormWidget> createState() => _FormWidgetState();
}

class _FormWidgetState extends State<FormWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.85,
      // height: 300,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(25),
        boxShadow: [
          BoxShadow(
            color: Color.fromARGB(50, 29, 29, 29),
            offset: Offset(0.0, 2.0),
            blurRadius: 10,
          ),
        ],
      ),
      child: Padding(
        padding:
            const EdgeInsets.only(bottom: 10, left: 20, right: 30, top: 20),
        child: Column(children: [
          TextFormField(
            decoration: InputDecoration(
              icon: Icon(Icons.person),
              labelText: "Nom",
              // labelText: 'Email',
            ),
            validator: null,
          ),
          SizedBox(
            height: 10,
          ),
          TextFormField(
            decoration: InputDecoration(
              icon: Icon(Icons.person),
              labelText: "Nome d'utilisateur",
              // labelText: 'Email',
            ),
            validator: null,
          ),
          SizedBox(
            height: 10,
          ),
          TextFormField(
            decoration: InputDecoration(
              icon: Icon(Icons.email),
              labelText: "Email",
              // labelText: 'Email',
            ),
            validator: null,
          ),
          SizedBox(
            height: 10,
          ),
          TextFormField(
            decoration: InputDecoration(
              icon: Icon(Icons.lock),
              // hintText: "Password",
              labelText: 'Mot de pass',
            ),
            validator: null,
            obscureText: true,
          ),
          SizedBox(
            height: 30,
          ),
        ]),
      ),
    );
  }
}