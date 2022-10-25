import 'package:flutter/material.dart';

class MessageWidget extends StatelessWidget {
  final String text;
  final String color;
  const MessageWidget({Key? key, required this.text, required this.color})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.85,
      height: 30,
      decoration: BoxDecoration(
        color: color == 'red' ? Color.fromARGB(255, 255, 99, 79) : Colors.green,
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20), topRight: Radius.circular(20)),
      ),
      child: Center(
          child: Text(
        text,
        style: TextStyle(
            color: Colors.white, fontWeight: FontWeight.w400, fontSize: 13),
      )),
    );
  }
}
