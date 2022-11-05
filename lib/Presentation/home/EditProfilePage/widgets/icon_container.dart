import 'package:dropili/common/constant/colors.dart';
import 'package:flutter/material.dart';

class IconContainer extends StatelessWidget {
  final Icon icon;
  final outline;
  const IconContainer({required this.icon, this.outline = true});

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 5,
      borderRadius: BorderRadius.all(Radius.circular(500)),
      child: Container(
        padding: EdgeInsets.all(5),
        child: icon,
        decoration: BoxDecoration(
          color: Colors.white,
          border: outline ? Border.all(color: MalinColors.AppGreen) : null,
          borderRadius: BorderRadius.all(
            Radius.circular(20),
          ),
        ),
      ),
    );
  }
}
