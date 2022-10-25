import 'package:dropili/Presentation/EditProfilePage/widgets/text_field.dart';
import 'package:dropili/common/constant/colors.dart';
import 'package:flutter/material.dart';
import '../../widgets_model/icons_lists.dart';

class ShowPopUp extends StatelessWidget {
  final int index;

  const ShowPopUp({required this.index});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(index.toString()),
      content: SingleChildScrollView(
          child: Column(
        children: [
          EditProfileTextField(
            text: IconsLists.allItems[index].text,
          ),
          SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              PopUpButton(
                text: 'Sauvegarder',
              ),
              PopUpButton(
                text: 'Supprimer',
              ),
            ],
          )
        ],
      )),
    );
  }
}

class PopUpButton extends StatelessWidget {
  final String text;
  //Function func = (){} ;
  PopUpButton({required this.text});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 35,
      width: MediaQuery.of(context).size.width * 0.25,
      child: Container(
        child: Center(
          child: Text(
            text,
            style: TextStyle(color: MalinColors.AppBlue),
          ),
        ),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(10)),
          border: Border.all(
            color: MalinColors.AppBlue,
            width: 1,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black,
              offset: Offset(0.0, 0.0), //(x,y)
              blurRadius: 1.0,
            ),
          ],
        ),
      ),
    );
  }
}
