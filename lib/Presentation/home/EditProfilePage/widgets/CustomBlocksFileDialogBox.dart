import 'dart:developer';
import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:dropili/Presentation/authentification/comun_widgets/message_widget.dart';
import 'package:dropili/Presentation/home/EditProfilePage/bloc/editProfileScreen_bloc.dart';
import 'package:dropili/Presentation/home/EditProfilePage/widgets/close_icon_widget.dart';
import 'package:dropili/common/constant/colors.dart';
import 'package:dropili/common/extensions/translation_extension.dart';
import 'package:dropili/data/models/get_costume_block_response.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';

class CustomBlocksFileDialogBox extends StatefulWidget {
  final String img, file, title;
  final int index;
  const CustomBlocksFileDialogBox({
    required this.title,
    required this.img,
    required this.index,
    this.file = '',
  });

  @override
  _CustomBlocksFileDialogBoxState createState() =>
      _CustomBlocksFileDialogBoxState();
}

class _CustomBlocksFileDialogBoxState extends State<CustomBlocksFileDialogBox> {
  bool success = false;
  @override
  Widget build(BuildContext context) {
    Future<void> pickImage() async {
      BlocProvider.of<EditProfileBloc>(context).add(GetCostumeBlockImage());
    }
    Future<void> pickFile() async {
      BlocProvider.of<EditProfileBloc>(context).add(GetCostumeBlockFile());
    }
    String titleAr = '';
    bool iconPath = false;

    return BlocListener<EditProfileBloc, EditProfileState>(
      listener: (context, state) async {
        if (state.status == Status.deleteCostumeBlocksSuccess) {
          Navigator.of(context).pop(false);
        }
        if (state.status == Status.updateCostumeBlocksSuccess) {
          Navigator.of(context).pop(false);
        }
        if (state.status == Status.costumeBlockImageSuccess) {
          iconPath = true;
          success = true;
        }
      },
      child: BlocBuilder<EditProfileBloc, EditProfileState>(
        builder: (context, state) {
          return Dialog(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              backgroundColor: Colors.transparent,
              child: Stack(
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.only(
                        left: 10, top: 50, right: 10, bottom: 10),
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
                          padding:
                              const EdgeInsets.only(top: 20, right: 5, left: 5),
                          child: Column(
                            children: [
                              state.status == Status.failInBlocksDialogue
                                  ? MessageWidget(
                                      color: 'red',
                                      text: state.messageError.t(context),
                                    )
                                  : Container(),
                              TextFormField(
                                initialValue: widget.title,
                                onChanged: (value) {
                                  titleAr = value;
                                },
                                decoration: textInputDecoration(
                                    text: widget.title,
                                    error: state.status ==
                                            Status.postBlockInvalidUrl
                                        ? true
                                        : false),
                              ),
                              SizedBox(height: 5),
                              GestureDetector(
                                onTap: () {
                                  pickFile();
                                },
                                child: TextFormField(
                                  decoration: fileFieldDecoration(
                                      lable: (state.fileName == '')
                                          ? widget.file
                                          : state.fileName,
                                      error: false),
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 5),
                        (state.status == Status.updateCostumeBlocksLoading ||
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
                                            .add(DeleteCostumeBlocksEvent(
                                                id: widget.index.toString()));
                                      },
                                      child: Text('Remove'.t(context)),
                                    ),
                                  ),
                                  Expanded(
                                    child: TextButton(
                                      onPressed: () {
                                        log(state.filePath,
                                            name: 'file path screen');
                                        BlocProvider.of<EditProfileBloc>(
                                                context)
                                            .add(
                                          UpdateCostumeBlock(
                                            id: widget.index.toString(),
                                            title: (titleAr == '')
                                                ? widget.title
                                                : titleAr,
                                            icon: iconPath
                                                ? state.addCostumeBlockImgPath
                                                : '',
                                            file: state.fileName == ''
                                                ? ''
                                                : state.filePath,
                                            urlOrFile: false,
                                          ),
                                        );
                                      },
                                      child: Text('update'.t(context)),
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
                          pickImage();
                        },
                        child: CustomBlockImage(
                          costumeBlockImgPath: state.addCostumeBlockImgPath,
                          widget: widget,
                          success: success,
                        ),
                      ),
                    ],
                  ),
                  Positioned(
                    right: 5,
                    top: 5,
                    child: GestureDetector(
                      onTap: () {
                        BlocProvider.of<EditProfileBloc>(context)
                            .add(ResetCostumeBlocksEvent());
                        Navigator.of(context).pop(false);
                      },
                      child: CloseIcon(),
                    ),
                  )
                ],
              ));
        },
      ),
    );
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

  InputDecoration textInputDecoration(
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
      errorBorder: InputBorder.none,
      disabledBorder: InputBorder.none,
      labelText: text,
      floatingLabelBehavior: FloatingLabelBehavior.never,
    );
  }

}

class CustomBlockImage extends StatelessWidget {
  const CustomBlockImage({
    Key? key,
    required this.widget,
    required this.success,
    required this.costumeBlockImgPath,
  }) : super(key: key);

  final CustomBlocksFileDialogBox widget;
  final bool success;
  final String costumeBlockImgPath;

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
          child: (widget.img != '')
              ? ClipRRect(
                  borderRadius: BorderRadius.circular(15),
                  child: success
                      ? Image.file(
                          File(costumeBlockImgPath),
                          fit: BoxFit.cover,
                        )
                      : CachedNetworkImage(
                          imageUrl: widget.img,
                          placeholder: (context, url) => Center(
                            child: Center(
                              child: Lottie.asset(
                                'assets/lottie/loading-green.json',
                                height: 80,
                              ),
                            ),
                          ),
                          errorWidget: (context, url, error) =>
                              Icon(Icons.error),
                          fit: BoxFit.cover,
                        ),
                )
              : ClipRRect(
                  borderRadius: BorderRadius.circular(15),
                  child: success
                      ? Image.file(
                          File(costumeBlockImgPath),
                          fit: BoxFit.cover,
                        )
                      : Image.asset('assets/dropili_app_logo.png')),
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
