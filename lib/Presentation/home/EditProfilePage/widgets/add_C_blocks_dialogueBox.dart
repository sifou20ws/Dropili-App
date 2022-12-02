import 'dart:developer';
import 'dart:io';

import 'package:dropili/Presentation/home/EditProfilePage/bloc/editProfileScreen_bloc.dart';
import 'package:dropili/common/extensions/translation_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';

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
                                TextFormField(
                                  onChanged: (value) {
                                    titlear = value;
                                  },
                                  decoration: buildInputDecoration(
                                      text: 'Name ar',
                                      error: !state.cBValideArName),
                                ),
                                SizedBox(height: 5),
                                TextFormField(
                                  onChanged: (value) {
                                    titlefr = value;
                                  },
                                  decoration: buildInputDecoration(
                                      text: 'Name fr',
                                      error: !state.cBValideFrName),
                                ),
                                SizedBox(height: 5),
                                TextFormField(
                                  onChanged: (value) {
                                    url = value;
                                  },
                                  decoration: buildInputDecoration(
                                      text: 'Url', error: !state.cBValideUrl),
                                ),
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
                                        child: Text('Cancel'.t(context)),
                                      ),
                                    ),
                                    Expanded(
                                      child: TextButton(
                                        onPressed: () {
                                          BlocProvider.of<EditProfileBloc>(
                                                  context)
                                              .add(PostCostumeBlock(
                                                  url: url,
                                                  titleAr: titlear,
                                                  titleFr: titlefr,
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
                            log('hi');
                          },
                          child: Container(
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
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10)),
                              child: success
                                  ? Image.file(
                                      File(state.addCostumeBlockImgPath),
                                      fit: BoxFit.cover,
                                    )
                                  : Image.asset('assets/dropili_app_logo.png'),
                            ),
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
}

contentBox(context) {}
InputDecoration buildInputDecoration(
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
    border: InputBorder.none,
    errorBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(7),
      borderSide: BorderSide.none,
    ),
    disabledBorder: InputBorder.none,
    labelText: text,
    floatingLabelBehavior: FloatingLabelBehavior.never,
  );
}
