import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:dropili/Presentation/home/EditProfilePage/bloc/editProfileScreen_bloc.dart';
import 'package:dropili/Presentation/home/EditProfilePage/widgets/icon_container.dart';
import 'package:dropili/Presentation/widgets_model/rounded_profile_picture.dart';
import 'package:dropili/common/constant/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class EditProfileMediaWidget extends StatefulWidget {
  const EditProfileMediaWidget({Key? key}) : super(key: key);

  @override
  State<EditProfileMediaWidget> createState() => _EditProfileMediaWidgetState();
}

class _EditProfileMediaWidgetState extends State<EditProfileMediaWidget> {
  @override
  Widget build(BuildContext context) {
    String profilePicture =
        BlocProvider.of<EditProfileBloc>(context).state.profileImagePath;
    String coverPicture =
        BlocProvider.of<EditProfileBloc>(context).state.coverImagePath;

    String getProfilePicture = '';
    getProfilePicture = BlocProvider.of<EditProfileBloc>(context)
        .state
        .showProfile!
        .user
        .userProfile
        .originalUrl;
    String getBackgroundPicture = '';
    getBackgroundPicture = BlocProvider.of<EditProfileBloc>(context)
        .state
        .showProfile!
        .user
        .userBackground
        .originalUrl;

    return Container(
      height: MediaQuery.of(context).size.height * 0.3,
      child: Stack(
        children: <Widget>[
          (getBackgroundPicture == '')
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
                  ? Image.network(
                      getBackgroundPicture,
                      fit: BoxFit.cover,
                      width: MediaQuery.of(context).size.width,
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
                BlocProvider.of<EditProfileBloc>(context)
                    .add(ImportCoverImageEvent());
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
                image: (getProfilePicture == '')
                    ? (profilePicture == '')
                        ? ''
                        : profilePicture
                    : (profilePicture == '')
                        ? getProfilePicture
                        : profilePicture,
                edit: true,
                file: (profilePicture == '') ? false : true,
                get: (getProfilePicture == '') ? false : true,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
