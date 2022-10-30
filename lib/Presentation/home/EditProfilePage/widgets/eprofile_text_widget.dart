import 'package:dropili/common/constant/colors.dart';
import 'package:flutter/material.dart';

class EditProfileTextWidget extends StatefulWidget {
  const EditProfileTextWidget({Key? key}) : super(key: key);

  @override
  State<EditProfileTextWidget> createState() => _EditProfileMediaWidgetState();
}

class _EditProfileMediaWidgetState extends State<EditProfileTextWidget> {
  @override
  Widget build(BuildContext context) {

    return Column(
      children: [
        SizedBox(height: 15),
        TextFormField(
          onChanged: (value){

          },
          decoration: buildInputDecoration('Nom'),
        ),
        SizedBox(height: 15),
        TextFormField(
          onChanged: (value){

          },
          decoration: buildInputDecoration('A propos de moi'),
          maxLines: 4,
        ),
      ],
    );
  }

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

