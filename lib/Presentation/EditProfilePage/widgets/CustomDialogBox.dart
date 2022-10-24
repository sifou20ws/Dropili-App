import 'dart:developer';

import 'package:dropili/Presentation/EditProfilePage/widgets/text_field.dart';
import 'package:flutter/material.dart';

import '../../widgets_model/icons_lists.dart';
import '../bloc/editProfileScreen_bloc.dart';

class CustomDialogBox extends StatefulWidget {
  final String editText;
  final String img;
  final int index;

  const CustomDialogBox({
    required this.editText,
    required this.img,
    required this.index,
  });

  @override
  _CustomDialogBoxState createState() => _CustomDialogBoxState();
}

class _CustomDialogBoxState extends State<CustomDialogBox> {
  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      elevation: 0,
      backgroundColor: Colors.transparent,
      child: contentBox(context),
    );
  }

  contentBox(context) {
    return Stack(
      children: <Widget>[
        Container(
          padding:
              EdgeInsets.only(left: 10, top: 45 + 10, right: 10, bottom: 10),
          margin: EdgeInsets.only(top: 30),
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
                padding: const EdgeInsets.only(top: 25),
                child: EditProfileTextField(text: IconsLists.allItems[widget.index].text),
              ),
              SizedBox(
                height: 15,
              ),
              Row(
                children: [
                  Expanded(
                    child: TextButton(
                        onPressed: () {
                          Navigator.of(context).pop(false);
                        },
                        child: Text('Supprimer')),
                  ),
                  Expanded(
                    child: TextButton(
                      onPressed: () {
                        Navigator.of(context).pop(false);
                       // context
                         //   .read<EditProfileBloc>()
                          //  .add(ItemSelectedEvent(
                          //  index: widget.index));
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
            width: 100,
            height: 100,
            child: ClipRRect(
              borderRadius: BorderRadius.all(Radius.circular(10)),
              child: Image.asset(
                //widget.img,
                IconsLists.allItems[widget.index].imageUrl,
                width: 100.0,
                height: 100.0,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
