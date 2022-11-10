import 'dart:developer';

import 'package:dropili/Presentation/home/EditProfilePage/bloc/editProfileScreen_bloc.dart';
import 'package:dropili/data/models/get_blocks_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CustomDialogBox extends StatefulWidget {
  final String editText;
  final String img, url;
  final int index;
  final List<BlocksItem> blocksList;

  const CustomDialogBox({
    required this.editText,
    required this.img,
    required this.index,
    required this.blocksList,
    required this.url,
  });

  @override
  _CustomDialogBoxState createState() => _CustomDialogBoxState();
}

class _CustomDialogBoxState extends State<CustomDialogBox> {
  @override
  Widget build(BuildContext context) {
    bool error = false;
    String inputUrl = '';
    return BlocListener<EditProfileBloc, EditProfileState>(
      listener: (context, state) async {
        if (BlocProvider.of<EditProfileBloc>(context).state.status ==
            Status.postBlockSuccess) {
          //await Future.delayed(Duration(seconds: 1));
          Navigator.of(context).pop(false);
        }
        if (BlocProvider.of<EditProfileBloc>(context).state.status ==
            Status.deleteSuccess) {
          //await Future.delayed(Duration(seconds: 1));
          Navigator.of(context).pop(false);
        }
      },
      child: Dialog(
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
                        children: [
                          TextFormField(
                            onChanged: (value) {
                              inputUrl = value;
                            },
                            decoration: buildInputDecoration((widget.url == '')
                                ? widget.editText
                                : widget.url),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 5),
                    Row(
                      children: [
                        Expanded(
                          child: TextButton(
                              onPressed: () {
                                BlocProvider.of<EditProfileBloc>(context).add(
                                    DeleteUserBlocksEvent(
                                        id: widget.index.toString()));
                              },
                              child: Text('Supprimer')),
                        ),
                        Expanded(
                          child: TextButton(
                            onPressed: () {
                              BlocProvider.of<EditProfileBloc>(context).add(
                                  ItemSelectedEvent(
                                      index: widget.index, data: inputUrl));
                            },
                            child: Text('Sauvegarder'),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Positioned(
                left: 20,
                right: 20,
                child: Container(
                  width: 80,
                  height: 80,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    color: Colors.transparent,
                  ),
                  child: Image.network(widget.img),
                ),
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
          )),
    );
  }

  contentBox(context) {}
  InputDecoration buildInputDecoration(String text) {
    return InputDecoration(
      /*enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: BorderSide(
          color: MalinColors.AppBlue,
          width: 2.0,
        ),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: BorderSide(
          color: MalinColors.AppGreen,
          width: 2.0,
        ),
      ),
      border: OutlineInputBorder(),*/
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
      //border: OutlineInputBorder(),
      border: InputBorder.none,
      errorBorder: InputBorder.none,
      disabledBorder: InputBorder.none,
      labelText: text,
    );
  }
}
