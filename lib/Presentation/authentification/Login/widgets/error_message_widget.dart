import 'package:flutter/material.dart';

class ErrorMessageWidget extends StatelessWidget {
  final String text;
  const ErrorMessageWidget({Key? key, required this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.85,
      height: 30,
      decoration: BoxDecoration(
        color: Color.fromARGB(255, 255, 99, 79),
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20), topRight: Radius.circular(20)),
      ),
      child: Center(
          child: Text(
        text,
        style: TextStyle(
            color: Colors.white, fontWeight: FontWeight.w200, fontSize: 13),
      )),
    );
  }
}
