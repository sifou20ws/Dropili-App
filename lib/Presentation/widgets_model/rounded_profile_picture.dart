import 'package:dropili/Presentation/home/EditProfilePage/widgets/icon_container.dart';
import 'package:dropili/common/constant/colors.dart';
import 'package:flutter/material.dart';

class RoundedProfilePicture extends StatelessWidget {
  final String image;
  final bool edit;
  RoundedProfilePicture({required this.image, this.edit = false});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Positioned(
          child: Container(
            decoration: BoxDecoration(
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
            ),
            child: Padding(
              padding: EdgeInsets.all(2),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(500),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(80),
                  child: Image.asset(
                    image,
                    width: 100.0,
                    height: 100.0,
                  ),
                ),
              ),
            ),
          ),
        ),
        edit ? Positioned(
          bottom: 10,
          right: 0,
          child: IconContainer(
            icon: Icon(Icons.edit_outlined, size: 15 , color: MalinColors.AppBlue,),
          ),
        ): Positioned(
          bottom: 10,
          right: 0,
          child: Container(),
        ),
      ],
    );
  }
}