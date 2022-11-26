import 'package:flutter/material.dart';

class MalinColors {
  const MalinColors._();

  static const Color AppGreen = Color.fromRGBO(0, 207, 137, 1);
  static const Color AppBlue = Color.fromRGBO(0, 113, 222, 1);
  static const Color AppBlue2 = Color.fromARGB(255, 0, 123, 206);

  static const Color shadow = Color.fromRGBO(0, 174, 166, 1);
  static const Color navBarBackground = Color.fromARGB(255, 55, 51, 70);
  static const Color cardsColor = Color.fromARGB(255, 246, 246, 246);
  static const Color greyElemntsColor = Color.fromARGB(255, 250, 250, 250);

  static const Gradient blueGradient = LinearGradient(
      begin: Alignment.topRight,
      end: Alignment.topLeft,
      colors: [Colors.white, AppBlue, Colors.white]);

  static const Gradient greenGradient = LinearGradient(
      begin: Alignment.topRight,
      end: Alignment.topLeft,
      colors: [Colors.white, AppGreen, Colors.white]);
}
