import 'package:flutter/material.dart';

class CloseIcon extends StatelessWidget {
  const CloseIcon({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 40),
      width: 30,
      height: 30,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(50),
        color: Colors.black12,
      ),
      child: Icon(
        Icons.close_rounded,
        color: Colors.black,
      ),
    );
  }
}