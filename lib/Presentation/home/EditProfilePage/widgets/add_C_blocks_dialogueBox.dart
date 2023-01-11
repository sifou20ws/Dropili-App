import 'dart:developer';
import 'dart:io';

import 'package:dropili/Presentation/home/EditProfilePage/bloc/editProfileScreen_bloc.dart';
import 'package:dropili/Presentation/home/EditProfilePage/widgets/icon_container.dart';
import 'package:dropili/common/constant/colors.dart';
import 'package:dropili/common/extensions/translation_extension.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_toggle_tab/flutter_toggle_tab.dart';
import 'package:lottie/lottie.dart';
import 'package:toggle_switch/toggle_switch.dart';

class AddCustomBlocksDialog extends StatefulWidget {
  const AddCustomBlocksDialog();

  @override
  _AddCustomBlocksDialogState createState() => _AddCustomBlocksDialogState();
}

class _AddCustomBlocksDialogState extends State<AddCustomBlocksDialog> {
  bool success = false;

  _AddCustomBlocksDialogState();
  String titlear = '', titlefr = '', url = '';

  @override
  Widget build(BuildContext context) {
    Future<void> pickImage() async {
      BlocProvider.of<EditProfileBloc>(context).add(GetCostumeBlockImage());
    }

    Future<void> pickFile() async {
      BlocProvider.of<EditProfileBloc>(context).add(GetCostumeBlockFile());
    }

    Color getColor(Set<MaterialState> states) {
      const Set<MaterialState> interactiveStates = <MaterialState>{
        MaterialState.pressed,
        MaterialState.hovered,
        MaterialState.focused,
      };
      if (states.any(interactiveStates.contains)) {
        return Colors.blue;
      }
      return Colors.greenAccent;
    }

    bool iconPath = false;
    return BlocListener<EditProfileBloc, EditProfileState>(
        listener: (context, state) async {
      if (state.status == Status.costumeBlockImageSuccess) {
        iconPath = true;
      }
      if (state.status == Status.postCostumeBlocksSuccess) {
        Navigator.of(context).pop(false);
      }
    }, child: BlocBuilder<EditProfileBloc, EditProfileState>(
      builder: (context, state) {
        return Stack(
          children: <Widget>[
            Container(
              padding: EdgeInsets.only(left: 10, top: 50, right: 10, bottom: 0),
              margin: EdgeInsets.only(top: 40),
              decoration: BoxDecoration(
                shape: BoxShape.rectangle,
                color: Colors.transparent,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Dialog(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                backgroundColor: Colors.transparent,
                child: Stack(
                  children: <Widget>[
                    Container(
                      padding: EdgeInsets.only(
                          left: 10, top: 50, right: 10, bottom: 0),
                      margin: EdgeInsets.only(top: 40),
                      decoration: BoxDecoration(
                        shape: BoxShape.rectangle,
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.only(
                                top: 10, right: 5, left: 5),
                            child: Column(
                              children: [
                                FlutterToggleTab(
                                  width: 50,
                                  height: 40,
                                  borderRadius: 20,
                                  unSelectedBackgroundColors: [
                                    Colors.grey.shade200
                                  ],
                                  selectedTextStyle: TextStyle(
                                      color: Colors.white,
                                      fontSize: 18,
                                      fontWeight: FontWeight.w500),
                                  unSelectedTextStyle: TextStyle(
                                      color: Colors.blue,
                                      fontSize: 14,
                                      fontWeight: FontWeight.w400),
                                  labels: ['Link', 'File'],
                                  icons: [
                                    Icons.link,
                                    Icons.file_copy,
                                  ],
                                  selectedBackgroundColors: [
                                    Colors.blue,
                                  ],
                                  marginSelected: EdgeInsets.all(3),
                                  selectedIndex: state.fileOrLink,
                                  selectedLabelIndex: (index) {
                                    BlocProvider.of<EditProfileBloc>(context)
                                        .add(CostumeUrlOrFileEvent(
                                            state: index));
                                  },
                                ),
                                SizedBox(height: 15),
                                TextFormField(
                                  onChanged: (value) {
                                    titlear = value;
                                  },
                                  decoration: textFieldDecoration(
                                      text: 'Name'.t(context),
                                      error: !state.cBValideName),
                                ),
                                SizedBox(height: 5),
                                state.fileOrUrl
                                    ? TextFormField(
                                        onChanged: (value) {
                                          url = value;
                                        },
                                        decoration: textFieldDecoration(
                                            text: 'Url'.t(context),
                                            error: !state.cBValideUrl),
                                      )
                                    : GestureDetector(
                                        onTap: () {
                                          pickFile();
                                        },
                                        child: TextFormField(
                                          decoration: fileFieldDecoration(
                                              error: !state.cBValideFile,
                                              lable: state.fileName),
                                        ),
                                      )
                              ],
                            ),
                          ),
                          (state.status == Status.postCostumeBlocksLoading ||
                                  state.status ==
                                      Status.deleteCostumeBlocksLoading)
                              ? Lottie.asset(
                                  'assets/lottie/loading-green.json',
                                  height: 60,
                                )
                              : Row(
                                  children: [
                                    Expanded(
                                      child: TextButton(
                                        onPressed: () {
                                          BlocProvider.of<EditProfileBloc>(
                                                  context)
                                              .add(ResetCostumeBlocksEvent());
                                          Navigator.pop(context);
                                        },
                                        child: Text('Back'.t(context)),
                                      ),
                                    ),
                                    Expanded(
                                      child: TextButton(
                                        onPressed: () {
                                          state.fileOrUrl
                                              ? BlocProvider.of<
                                                      EditProfileBloc>(context)
                                                  .add(PostCostumeBlock(
                                                      fileOrUrl: true,
                                                      url: url,
                                                      file: '',
                                                      titleAr: titlear,
                                                      icon: iconPath
                                                          ? state
                                                              .addCostumeBlockImgPath
                                                          : ''))
                                              : BlocProvider.of<
                                                      EditProfileBloc>(context)
                                                  .add(PostCostumeBlock(
                                                      fileOrUrl: false,
                                                      file: state.filePath,
                                                      titleAr: titlear,
                                                      icon: iconPath
                                                          ? state
                                                              .addCostumeBlockImgPath
                                                          : ''));
                                        },
                                        child: Text('Save'.t(context)),
                                      ),
                                    ),
                                  ],
                                ),
                        ],
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        GestureDetector(
                          onTap: () {
                            pickImage().then((value) {
                              success = true;
                            });
                          },
                          child: CbAddImage(
                            success: success,
                            CostumeBlockImgPath: state.addCostumeBlockImgPath,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        );
      },
    ));
  }

  InputDecoration fileFieldDecoration(
      {required String lable, required bool error}) {
    return InputDecoration(
      enabled: false,
      filled: true,
      fillColor: Color.fromARGB(50, 166, 166, 166),
      disabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(7),
        borderSide: BorderSide.none,
      ),
      labelText: (lable.isEmpty) ? 'Click to upload file' : lable,
      floatingLabelBehavior: FloatingLabelBehavior.never,
      errorText: error ? 'this value is required' : null,
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(7),
        borderSide: BorderSide(color: Colors.red),
      ),
    );
  }

  InputDecoration textFieldDecoration(
      {required String text, required bool error}) {
    return InputDecoration(
      errorText: error ? 'this value is required' : null,
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(7),
        borderSide: BorderSide.none,
      ),
      filled: true,
      fillColor: Color.fromARGB(50, 166, 166, 166),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(7),
        borderSide: BorderSide.none,
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(7),
        borderSide: BorderSide(color: Colors.red),
      ),
      labelText: text,
      floatingLabelBehavior: FloatingLabelBehavior.never,
    );
  }
}

class CbAddImage extends StatelessWidget {
  const CbAddImage({
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

class textCheckbox extends StatelessWidget {
  final Checkbox checkBox;
  final String text;
  const textCheckbox({required this.checkBox, required this.text});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Text(
          text.t(context),
          style: TextStyle(
              fontWeight: FontWeight.w500, fontSize: 18, color: Colors.black),
        ),
        checkBox,
      ],
    );
  }
}
