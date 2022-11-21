import 'package:dropili/common/constant/colors.dart';
import 'package:flutter/material.dart';

class SnackBars {
  static void showSucessSnackBar(BuildContext context, String message) {
    final snackBar = SnackBar(
      duration: Duration(milliseconds: 2000) ,
      content: Text(
        message,
        textAlign: TextAlign.center,
      ),
      elevation: 10,
      backgroundColor: MalinColors.AppGreen,
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  static void showErrorSnackBar(BuildContext context, String message) {
    final snackBar = SnackBar(
      duration: Duration(milliseconds: 2000) ,
      content: Text(
        message,
        textAlign: TextAlign.center,
      ),
      elevation: 10,
      backgroundColor: Colors.red.shade400,
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}
