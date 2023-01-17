import 'dart:io';

import 'package:dropili/Presentation/home/EditProfilePage/bloc/editProfileScreen_bloc.dart';
import 'package:dropili/Presentation/home/EditProfilePage/widgets/icon_container.dart';
import 'package:dropili/Presentation/widgets_model/cachedImage_widget.dart';
import 'package:dropili/Presentation/widgets_model/rounded_profile_picture.dart';
import 'package:dropili/common/constant/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MediaWidget extends StatefulWidget {
  final String getProfilePicture, getBackgroundPicture;
  const MediaWidget(
      {required this.getProfilePicture, required this.getBackgroundPicture});

  @override
  State<MediaWidget> createState() => _MediaWidgetState();
}

class _MediaWidgetState extends State<MediaWidget> {
  @override
  Widget build(BuildContext context) {
    String profilePicture =
        BlocProvider.of<EditProfileBloc>(context).state.profileImagePath;
    String coverPicture =
        BlocProvider.of<EditProfileBloc>(context).state.coverImagePath;

    return Container(
      height: MediaQuery.of(context).size.height * 0.3,
      child: Stack(
        children: <Widget>[
          (widget.getBackgroundPicture == '')
              ? (coverPicture == '')
                  ? Image.asset(
                      'assets/transparent.png',
                      height: MediaQuery.of(context).size.height * 0.25,
                      width: MediaQuery.of(context).size.width,
                      fit: BoxFit.cover,
                      color: MalinColors.AppBlue,
                    )
                  : Image.file(
                      File(coverPicture),
                      width: MediaQuery.of(context).size.width,
                      fit: BoxFit.cover,
                    )
              : (coverPicture == '')
                  ? Container(
                      height: MediaQuery.of(context).size.height * 0.25,
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          fit: BoxFit.fill,
                          image: AssetImage('assets/transparent.png'),
                          alignment: Alignment.topCenter,
                        ),
                      ),
                      child: cachedImageModelWidget(
                        image: widget.getBackgroundPicture,
                      ),
                    )
                  : Image.file(
                      File(coverPicture),
                      width: MediaQuery.of(context).size.width,
                      fit: BoxFit.cover,
                    ),
          Align(
            alignment: Alignment(0.0, 1.01),
            child: Container(
              height: 50,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(0),
                  topRight: Radius.circular(0),
                ),
              ),
            ),
          ),
          Positioned(
            top: 10,
            right: 10,
            child: GestureDetector(
              onTap: () {
                double h = MediaQuery.of(context).size.height * 0.25;
                BlocProvider.of<EditProfileBloc>(context)
                    .add(ImportCoverImageEvent(
                  width: MediaQuery.of(context).size.width.toInt(),
                  height: h.round(),
                ));
              },
              child: IconContainer(
                icon: Icon(
                  Icons.camera_alt_outlined,
                  size: 20,
                  color: MalinColors.AppBlue,
                ),
                outline: false,
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: GestureDetector(
              onTap: () {
                BlocProvider.of<EditProfileBloc>(context)
                    .add(ImportProfileImageEvent());
              },
              child: RoundedProfilePicture(
                image: (widget.getProfilePicture == '')
                    ? (profilePicture == '')
                        ? ''
                        : profilePicture
                    : (profilePicture == '')
                        ? widget.getProfilePicture
                        : profilePicture,
                edit: true,
                file: (profilePicture == '') ? false : true,
                get: (widget.getProfilePicture == '') ? false : true,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
