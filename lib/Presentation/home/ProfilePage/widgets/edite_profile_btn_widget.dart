import 'package:dropili/common/constant/colors.dart';
import 'package:dropili/common/extensions/translation_extension.dart';
import 'package:flutter/material.dart';

class EditeProfileBtnWidget extends StatelessWidget {
  const EditeProfileBtnWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      height: 40,
      width: 130,
      decoration: BoxDecoration(
        color: MalinColors.AppGreen,
        // color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Color.fromARGB(20, 29, 29, 29),
            offset: Offset(0.0, 2.0),
            blurRadius: 10,
            spreadRadius: 5,
          ),
        ],
      ),
      child: Text(
        'Edit Profile'.t(context),
        style: TextStyle(
            // color: MalinColors.AppGreen,
            color: Colors.white,
            fontSize: 15,
            fontWeight: FontWeight.w500),
      ),
    );
  }
}
