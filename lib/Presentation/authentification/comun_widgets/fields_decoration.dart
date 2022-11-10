import 'package:flutter/material.dart';

InputDecoration buildInputDecoration(
    {required String text, bool name = false, String? error = null}) {
  return InputDecoration(
      errorText: error,
      errorStyle: TextStyle(
        color: Colors.white,
        // decoration: TextDecoration.underline,
        // decorationColor: Colors.red,
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: BorderSide(
          color: Colors.red,
          width: 2,
        ),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: BorderSide(
          color: Colors.red,
          width: 2,
        ),
      ),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: BorderSide(
          color: Colors.white.withAlpha(200),
          width: 2,
        ),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: BorderSide(
          color: Colors.white.withAlpha(200),
          width: 2,
        ),
      ),
      filled: true,
      fillColor: Colors.white.withAlpha(100),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: BorderSide(
          color: Colors.white.withAlpha(200),
          width: 2,
        ),
      ),
      disabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: BorderSide(
          color: Colors.white.withAlpha(150),
          width: 2,
        ),
      ),
      labelText: text,
      floatingLabelBehavior: FloatingLabelBehavior.never,
      labelStyle: TextStyle(
          color: Colors.white.withAlpha(255), fontWeight: FontWeight.w400));
}
