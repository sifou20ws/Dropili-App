import 'package:dropili/Presentation/home/EditProfilePage/bloc/editProfileScreen_bloc.dart';
import 'package:dropili/common/constant/colors.dart';
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
    String inputUrl = '';
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
                    padding: const EdgeInsets.only(top: 20),
                    child: TextFormField(
                      onChanged: (value) {
                        /* BlocProvider.of<EditProfileBloc>(context)
                            .add(BlockUrlEvent(value));*/
                        inputUrl = value;
                      },
                      decoration: buildInputDecoration(
                          (widget.url == '') ? widget.editText : widget.url),
                    ),
                  ),
                  SizedBox(height: 15),
                  Row(
                    children: [
                      Expanded(
                        child: TextButton(
                            onPressed: () {
                              BlocProvider.of<EditProfileBloc>(context).add(
                                  DeleteUserBlocksEvent(
                                      id: widget.blocksList[widget.index].id
                                          .toString()));
                            },
                            child: Text('Supprimer')),
                      ),
                      Expanded(
                        child: TextButton(
                          onPressed: () {
                            /* String url =
                                BlocProvider.of<EditProfileBloc>(context)
                                    .state
                                    .blockUrl;*/
                            BlocProvider.of<EditProfileBloc>(context).add(
                                ItemSelectedEvent(
                                    index: widget.index, data: inputUrl));
                            BlocProvider.of<EditProfileBloc>(context)
                                .add(GetBlocksEvent());
                            Navigator.of(context).pop(false);
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
                  child: Image.network(widget.img)),
            ),
          ],
        ));
  }

  contentBox(context) {}
  InputDecoration buildInputDecoration(String text) {
    return InputDecoration(
      enabledBorder: OutlineInputBorder(
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
      border: OutlineInputBorder(),
      labelText: text,
    );
  }
}
