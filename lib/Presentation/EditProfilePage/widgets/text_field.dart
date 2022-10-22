import 'package:flutter/material.dart';

import '../../../core/constant/colors.dart';

class EditProfileTextField extends StatelessWidget {
  final String text;
  bool long ;
  EditProfileTextField({required this.text, this.long = false});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      decoration: InputDecoration(
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(
            color: MalinColors.AppBlue,
            width: 2.0,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(
            color: MalinColors.AppGreen,
            width: 2.0,
          ),
        ),
        border: OutlineInputBorder(),
        labelText: text,
      ),
      maxLines:long ? 4 : 1,
    );
  }
}