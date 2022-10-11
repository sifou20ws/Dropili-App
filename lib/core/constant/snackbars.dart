import 'package:flutter/material.dart';

class MalinSnackBars {
  static SnackBar errorSnackBar(e) => SnackBar(
        content: Text(
          "Erreur : $e",
          style: TextStyle(
              color: Colors.white, fontSize: 15, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.red,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(12.0),
                topRight: Radius.circular(12.0))),
      );

  static SnackBar SuccessSnackBar(s) => SnackBar(
        content: Text(
          s,
          style: TextStyle(
              color: Colors.white, fontSize: 15, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.green,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(12.0),
                topRight: Radius.circular(12.0))),
      );
}
