import 'package:dropili/common/constant/colors.dart';
import 'package:dropili/common/extensions/translation_extension.dart';
import 'package:flutter/material.dart';

class ShareButton extends StatelessWidget {
  const ShareButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      height: 55,
      width: 250,
      decoration: BoxDecoration(
        color: MalinColors.AppGreen.withAlpha(190),
        // color: Colors.white,
        borderRadius: BorderRadius.circular(25),
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
        'Share profile'.t(context),
        style: TextStyle(
            // color: MalinColors.AppGreen,
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.w500),
      ),
    );
  }
}
