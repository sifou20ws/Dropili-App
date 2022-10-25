import 'dart:io';

import 'package:dropili/common/constant/colors.dart';
import 'package:dropili/common/constant/snackbars.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:dropili/Presentation/widgets_model/icons_lists.dart';
import '../../widgets_model/profile_grid.dart';
import '../../widgets_model/rounded_profile_picture.dart';
import '../bloc/editProfileScreen_bloc.dart';
import '../widgets/button.dart';
import '../widgets/icon_container.dart';
import '../widgets/text_field.dart';
import 'package:image_picker/image_picker.dart';

import 'dart:developer';

class EditProfilePage extends StatefulWidget {
  const EditProfilePage({Key? key}) : super(key: key);

  @override
  State<EditProfilePage> createState() => _MyOffersPageState();
}

enum MediaType {
  image,
}

class _MyOffersPageState extends State<EditProfilePage> {
  bool selected = false;

  @override
  Widget build(BuildContext context) {
    String? imagePath;
    void pickMedia(ImageSource source) async {
      XFile? file;
      MediaType _mediaType = MediaType.image;

      if (_mediaType == MediaType.image) {
        file = await ImagePicker().pickImage(source: source);
      }
      if (file != null) {
        imagePath = file.path;
        setState(() {});
      }
      log(imagePath.toString());
    }

    return BlocListener<EditProfileBloc, EditProfileState>(
      listener: (context, state) {
        if (state.status == Status.fail) {
          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              MalinSnackBars.errorSnackBar(state.messageError!.message),
            );
        }
      },
      child: BlocBuilder<EditProfileBloc, EditProfileState>(
        builder: (context, state) {
          return SafeArea(
            child: Scaffold(
              resizeToAvoidBottomInset: false,
              backgroundColor: Colors.white,
              appBar: AppBar(
                elevation: 0,
                backgroundColor: MalinColors.AppBlue,
                iconTheme: IconThemeData(color: Colors.black),
                leading: IconButton(
                  icon: Icon(
                    Icons.arrow_back_ios_new,
                    color: Colors.white,
                  ),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
                title: Center(
                  child: Text(
                    'Modifier mon profil',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
                actions: <Widget>[
                  IconButton(
                    icon: Icon(
                      Icons.share,
                      color: Colors.white,
                    ),
                    onPressed: () {
                      // do something
                    },
                  )
                ],
              ),
              body: Stack(
                children: <Widget>[
                  SingleChildScrollView(
                    child: Container(
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage('assets/background2.png'),
                          alignment: Alignment.topCenter,
                        ),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Container(
                            height: MediaQuery.of(context).size.height * 0.25,
                            child: Stack(
                              children: <Widget>[
                                (imagePath == null)
                                    ? Image.asset(
                                        'assets/transparent.png',
                                        height:
                                            MediaQuery.of(context).size.height *
                                                0.20,
                                        width:
                                            MediaQuery.of(context).size.width,
                                        fit: BoxFit.cover,
                                        color: MalinColors.AppBlue,
                                      )
                                    : Image.file(File(imagePath!)),
                                Align(
                                  alignment: Alignment.bottomCenter,
                                  child: Container(
                                    height: 50,
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(20),
                                        topRight: Radius.circular(20),
                                      ),
                                    ),
                                  ),
                                ),
                                Positioned(
                                  top: 10,
                                  right: 10,
                                  child: GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        pickMedia(ImageSource.gallery);
                                      });
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
                                      pickMedia(ImageSource.gallery);
                                    },
                                    child: RoundedProfilePicture(
                                      image: 'assets/dropili_Logo_PNG.png',
                                      edit: true,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            decoration: BoxDecoration(
                              color: Colors.white,
                            ),
                            child: Padding(
                              padding: EdgeInsets.only(
                                  left: 30, right: 30, bottom: 50),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  SizedBox(height: 15),
                                  EditProfileTextField(text: 'Nom'),
                                  SizedBox(height: 15),
                                  EditProfileTextField(
                                      text: 'A propos de moi', long: true),
                                  SizedBox(height: 15),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: <Widget>[
                                      EditProfileButton(
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: <Widget>[
                                            Text(
                                              'Direct sur',
                                              style: TextStyle(
                                                  fontWeight: FontWeight.w400,
                                                  fontSize: 18,
                                                  color: Colors.blue),
                                            ),
                                            SizedBox(width: 3),
                                            CupertinoSwitch(
                                              value: state.switchButton,
                                              onChanged: (bool state) {
                                                context
                                                    .read<EditProfileBloc>()
                                                    .add(SwitchEvent(
                                                        state: state));
                                              }, //
                                              activeColor: MalinColors.AppBlue,
                                            ),
                                          ],
                                        ),
                                      ),
                                      EditProfileButton(
                                        child: Text(
                                          'Profile active',
                                          style: TextStyle(
                                              fontWeight: FontWeight.w400,
                                              fontSize: 18,
                                              color: Colors.blue),
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 15),
                                  Grid(
                                      start: 0,
                                      size: 11,
                                      type: 'contactItems',
                                      title: 'Contacts',
                                      myList: IconsLists.allItems),
                                  SizedBox(height: 15),
                                  Grid(
                                      start: 11,
                                      size: 7,
                                      title: 'Reseaux sociaux',
                                      type: 'reseauxItems',
                                      myList: IconsLists.allItems),
                                  SizedBox(height: 15),
                                  Grid(
                                      start: 18,
                                      size: 5,
                                      title: 'Moyens de paiement',
                                      type: 'paimentsItems',
                                      myList: IconsLists.allItems),
                                  SizedBox(height: 15),
                                  Grid(
                                      start: 23,
                                      size: 2,
                                      title: 'Divers',
                                      type: 'diversItems',
                                      myList: IconsLists.allItems),
                                  SizedBox(height: 15),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 0,
                    child: Container(
                      color: MalinColors.AppBlue,
                      height: 60,
                      width: MediaQuery.of(context).size.width,
                      child: Center(
                        child: Text(
                          'Enregistrer mon profile',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 30,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
