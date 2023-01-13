import 'package:dropili/common/constant/colors.dart';
import 'package:flutter/material.dart';
import 'dart:io';

class BlockImage extends StatelessWidget {
  const BlockImage({
    required this.success,
    required this.CostumeBlockImgPath,
  });

  final bool success;
  final String CostumeBlockImgPath;
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          width: 80,
          height: 80,
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: Color.fromARGB(50, 0, 0, 0),
                offset: Offset(0.0, 5.0),
                blurRadius: 10,
                spreadRadius: 1,
              ),
            ],
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.all(Radius.circular(10)),
            child: success
                ? Image.file(
              File(CostumeBlockImgPath),
              fit: BoxFit.cover,
            )
                : Image.asset('assets/dropili_app_logo.png'),
          ),
        ),
        Positioned(
          bottom: 0,
          right: 0,
          child: Container(
            padding: EdgeInsets.all(2),
            child: Icon(
              Icons.edit_outlined,
              size: 15,
              color: MalinColors.AppBlue,
            ),
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(color: MalinColors.AppGreen),
              borderRadius: BorderRadius.all(
                Radius.circular(50),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
