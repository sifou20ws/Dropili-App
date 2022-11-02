import 'dart:io';

import 'package:dropili/Presentation/home/EditProfilePage/widgets/icon_container.dart';
import 'package:dropili/common/constant/colors.dart';
import 'package:flutter/material.dart';

class RoundedProfilePicture extends StatelessWidget {
  final String image;
  final bool edit;
  final bool file, get;
  RoundedProfilePicture(
      {required this.image,
      this.edit = false,
      this.file = false,
      this.get = false});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Positioned(
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,

              borderRadius: BorderRadius.circular(500),
              gradient: LinearGradient(
                begin: Alignment.topRight,
                end: Alignment.bottomLeft,
                colors: [
                  MalinColors.AppGreen,
                  MalinColors.AppBlue,
                ],
              ),
              boxShadow: [
                BoxShadow(
                  color: MalinColors.shadow,
                  blurRadius: 1,
                  spreadRadius: 1,
                  offset: const Offset(0, 0),
                ),
              ],
              image: DecorationImage(
                //fit: BoxFit.fill,
                image: AssetImage(
                  'assets/dropili_app_logo.png',
                ),
                alignment: Alignment.topCenter,
              ),
            ),
            child: Padding(
              padding: EdgeInsets.all(2),
              child: Container(
                height: 100,
                width: 100,
                decoration: BoxDecoration(
                  //color: Colors.white,
                  borderRadius: BorderRadius.circular(500),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(80),
                  child: get
                      ? file
                          ? Image.file(
                              File(image),
                              width: 100,
                              height: 100,
                              fit: BoxFit.cover,
                            )
                          : Image.network(
                              image,
                              fit: BoxFit.cover,
                              width: 100,
                              height: 100,
                            )
                      : file
                          ? Image.file(
                              File(image),
                              width: 100,
                              height: 100,
                              fit: BoxFit.cover,
                            )
                          :null,
                ),
              ),
            ),
          ),
        ),
        edit
            ? Positioned(
                bottom: 10,
                right: 0,
                child: IconContainer(
                  icon: Icon(
                    Icons.edit_outlined,
                    size: 15,
                    color: MalinColors.AppBlue,
                  ),
                ),
              )
            : Positioned(
                bottom: 10,
                right: 0,
                child: Container(),
              ),
      ],
    );
  }
}
