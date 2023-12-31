import 'dart:developer';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:dropili/Presentation/authentification/comun_widgets/message_widget.dart';
import 'package:dropili/Presentation/home/EditProfilePage/bloc/editProfileScreen_bloc.dart';
import 'package:dropili/common/constant/colors.dart';
import 'package:dropili/common/extensions/translation_extension.dart';
import 'package:dropili/data/models/get_blocks_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';

class BlocksDialogBox extends StatefulWidget {
  final String editText;
  final String img, url;
  final int index;
  final List<BlocksItem> blocksList;
  final bool put;
  const BlocksDialogBox({
    required this.editText,
    required this.img,
    required this.index,
    required this.blocksList,
    required this.url,
    required this.put,
  });

  @override
  _BlocksDialogBoxState createState() => _BlocksDialogBoxState();
}

class _BlocksDialogBoxState extends State<BlocksDialogBox> {
  @override
  Widget build(BuildContext context) {
    String inputUrl = '';
    return BlocListener<EditProfileBloc, EditProfileState>(
      listener: (context, state) async {
        if (state.status == Status.postBlockSuccess) {
          Navigator.of(context).pop(false);
        }
        if (state.status == Status.deleteSuccess) {
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
                  padding:
                      EdgeInsets.only(left: 10, top: 50, right: 10, bottom: 10),
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
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            state.status == Status.failInBlocksDialogue
                                ? Padding(
                                    padding: const EdgeInsets.only(bottom: 5),
                                    child: MessageWidget(
                                      color: 'red',
                                      text: state.messageError.t(context),
                                    ),
                                  )
                                : Container(),
                            //SizedBox(height: 10),
                            Text(widget.editText),
                            SizedBox(height: 5),
                            TextFormField(
                              initialValue: (widget.url == '') ? '' : widget.url  ,
                              onChanged: (value) {
                                inputUrl = value;
                              },
                              decoration: buildInputDecoration(
                                  text: (widget.url == '') ? '' : widget.url,
                                  error:
                                      state.status == Status.postBlockInvalidUrl
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
                              'assets/lottie/loading-green.json',
                              height: 60,
                            )
                          : Row(
                              children: [
                                Expanded(
                                  child: TextButton(
                                    onPressed: () {
                                      (widget.url == '')
                                          ? { log('cancel'),
                                              state.status = Status.initial,
                                              Navigator.of(context).pop(false)
                                            }
                                          : BlocProvider.of<EditProfileBloc>(
                                                  context)
                                              .add(DeleteUserBlocksEvent(
                                                  id: widget.index.toString()));
                                    },
                                    child: (widget.url == '')
                                        ? Text('Cancel'.t(context))
                                        : Text('Remove'.t(context)),
                                  ),
                                ),
                                Expanded(
                                  child: TextButton(
                                    onPressed: () {
                                      BlocProvider.of<EditProfileBloc>(context)
                                          .add(
                                        ItemSelectedEvent(
                                          index: widget.index,
                                          data: (inputUrl=='')?widget.url:inputUrl,
                                          put: widget.put,
                                        ),
                                      );
                                    },
                                    child: (widget.put)
                                        ? Text('update'.t(context))
                                        : Text('save'.t(context)),
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
                      child: CachedNetworkImage(
                        imageUrl: widget.img,
                        placeholder: (context, url) => Center(
                            child: Center(
                          child: Lottie.asset(
                            'assets/lottie/loading-green.json',
                            height: 80,
                          ),
                        )),
                        errorWidget: (context, url, error) => Icon(Icons.error),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ],
                ),
                Positioned(
                  right: 8,
                  top: 8,
                  child: GestureDetector(
                    onTap: () {
                      state.status = Status.initial;
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
                        Icons.close_outlined,
                        color: Colors.grey.shade800,
                      ),
                    ),
                  ),
                ),
                Positioned(
                  left: 8,
                  top: 8,
                  child: GestureDetector(
                    onTap: () {
                      //Navigator.of(context).pop(false);
                    },
                    child: Tooltip(
                      message: widget.editText,
                      waitDuration: Duration(seconds: 1),
                      showDuration: Duration(seconds: 5),
                      triggerMode: TooltipTriggerMode.tap,
                      height: 35,
                      textStyle: TextStyle(
                        fontSize: 15,
                        color: Colors.white,
                      ),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: MalinColors.AppGreen),
                      child: Container(
                        margin: EdgeInsets.only(top: 40),
                        width: 30,
                        height: 30,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(50),
                          color: Colors.black12,
                        ),
                        child: Icon(
                          Icons.info_outline,
                          color: Colors.grey.shade800,
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
          );
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
      //border: InputBorder.none,
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(7),
        borderSide: BorderSide.none,
      ),
      //disabledBorder: InputBorder.none,
      labelText: text,
      floatingLabelBehavior: FloatingLabelBehavior.never,
    );
  }
}
