import 'package:flutter/material.dart';

import '../../../core/constant/colors.dart';

class EditProfileButton extends StatelessWidget {
  final Widget child;
  //Function func = (){} ;
  EditProfileButton({required this.child});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 45,
      width: MediaQuery.of(context).size.width * 0.4,

      child: Container(
        child: Center(child: child),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(20)),
            border: Border.all(
              color: MalinColors.AppBlue,
              width: 1,
            ),
          boxShadow: [
            BoxShadow(
              color: Colors.black,
              offset: Offset(0.0, 0.0), //(x,y)
              blurRadius: 1.0,
            ),
          ],
        ),
      ),
    );
  }
}
