import 'dart:developer';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:dropili/Presentation/authentification/comun_widgets/message_widget.dart';
import 'package:dropili/Presentation/home/EditProfilePage/bloc/editProfileScreen_bloc.dart';
import 'package:dropili/common/extensions/translation_extension.dart';
import 'package:dropili/data/models/get_costume_block_response.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';

class CustomBlocksDialogBox extends StatefulWidget {
  final String img, url;
  final int index;
  final List<CustomBlocksItem> costumeBlocksList;
  const CustomBlocksDialogBox({
    required this.img,
    required this.index,
    required this.costumeBlocksList,
    required this.url,
  });

  @override
  _CustomBlocksDialogBoxState createState() => _CustomBlocksDialogBoxState();
}

class _CustomBlocksDialogBoxState extends State<CustomBlocksDialogBox> {
  @override
  Widget build(BuildContext context) {
    bool error = false;
    String inputUrl = '';
    return BlocListener<EditProfileBloc, EditProfileState>(
      listener: (context, state) async {
        if (state.status == Status.deleteCostumeBlocksSuccess) {
          Navigator.of(context).pop(false);
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
                                onChanged: (value) {
                                  inputUrl = value;
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
                        (state.status == Status.postBlockLoading ||
                                state.status == Status.deleteLoading)
                            ? Lottie.asset(
                                'assets/lottie/loading.json',
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
                                            url: '',
                                            titleAr: '',
                                            titleFr: '',
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
                                child: CachedNetworkImage(
                                  imageUrl: widget.img,
                                  placeholder: (context, url) => Center(
                                    child: Center(
                                      child: Lottie.asset(
                                        'assets/lottie/loading.json',
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
                                child:
                                    Image.asset('assets/dropili_app_logo.png')),
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
                      child: Container(
                        margin: EdgeInsets.only(top: 40),
                        width: 30,
                        height: 30,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(50),
                          color: Colors.black12,
                        ),
                        child: Icon(
                          Icons.close_rounded,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  )
                ],
              ));
        },
      ),
    );
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
      errorBorder: InputBorder.none,
      disabledBorder: InputBorder.none,
      labelText: text,
      floatingLabelBehavior: FloatingLabelBehavior.never,
    );
  }
}
