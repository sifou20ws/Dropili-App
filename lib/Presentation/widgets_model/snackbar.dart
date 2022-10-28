import 'package:dropili/common/constant/colors.dart';
import 'package:flutter/material.dart';

class SnackBars {
  static void showSucessSnackBar(BuildContext context, String message) {
    final snackBar = SnackBar(
      content: Text(
        message,
        textAlign: TextAlign.center,
      ),
      elevation: 10,
      backgroundColor: MalinColors.AppGreen,
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}
