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

class LinkBlockDialogBox extends StatefulWidget {
  final String img, url , title;
  final int index;
  const LinkBlockDialogBox({
    required this.title,
    required this.img,
    required this.index,
    this.url = '',
  });

  @override
  _LinkBlockDialogBoxState createState() => _LinkBlockDialogBoxState();
}

class _LinkBlockDialogBoxState extends State<LinkBlockDialogBox> {
  bool success = false;
  @override
  Widget build(BuildContext context) {
    Future<void> pickImage() async {
      BlocProvider.of<EditProfileBloc>(context).add(GetCostumeBlockImage());
    }

    String titleAr = '', url = '';
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
                                initialValue: widget
                                    .title,
                                onChanged: (value) {
                                  titleAr = value;
                                },
                                decoration: buildInputDecoration(
                                    text: widget.url,
                                    error: state.status ==
                                            Status.postBlockInvalidUrl
                                        ? true
                                        : false),
                              ),
                              SizedBox(height: 5),
                              TextFormField(
                                initialValue:
                                    widget.url,
                                onChanged: (value) {
                                  url = value;
                                },
                                decoration: buildInputDecoration(
                                    text: widget.url,
                                    error: state.status ==
                                            Status.postBlockInvalidUrl
                                        ? true
                                        : false),
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
                                        BlocProvider.of<EditProfileBloc>(
                                                context)
                                            .add(
                                          UpdateCostumeBlock(
                                            id: widget.index.toString(),
                                            url: (url == '')
                                                ? widget
                                                    .url
                                                : url,
                                            title: (titleAr == '')
                                                ? widget.title
                                                : titleAr,
                                            icon: iconPath
                                                ? state.addCostumeBlockImgPath
                                                : '',
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
                          pickImage().then((value) {
                            success = true;
                          });
                          log('hi');
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

  final LinkBlockDialogBox widget;
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
