import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:dropili/Presentation/home/EditProfilePage/widgets/icon_container.dart';
import 'package:dropili/common/constant/colors.dart';
import 'package:flutter/material.dart';

class RoundedProfilePicture extends StatelessWidget {
  final String image;
  final bool edit;
  final bool file, get;
  final double size;
  RoundedProfilePicture(
      {required this.image,
      this.edit = false,
      this.file = false,
      this.get = false,
      this.size = 120});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Positioned(
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(500),
              boxShadow: [
                BoxShadow(
                  // color: Color.fromARGB(10, 29, 29, 29),
                  color: Colors.black.withAlpha(30),
                  offset: Offset(0.0, 2.0),
                  blurRadius: 10,
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
            child: Container(
              height: size,
              width: size,
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
                        : CachedNetworkImage(
                            imageUrl: image,
                            placeholder: (context, url) =>
                                Center(child: CircularProgressIndicator()),
                            errorWidget: (context, url, error) =>
                                Icon(Icons.error),
                            fit: BoxFit.cover,
                          )
                    : file
                        ? Image.file(
                            File(image),
                            width: 100,
                            height: 100,
                            fit: BoxFit.cover,
                          )
                        : null,
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
