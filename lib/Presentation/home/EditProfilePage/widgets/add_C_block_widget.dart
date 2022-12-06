import 'package:dropili/Presentation/home/EditProfilePage/bloc/editProfileScreen_bloc.dart';
import 'package:dropili/Presentation/home/EditProfilePage/widgets/add_C_blocks_dialogueBox.dart';
import 'package:dropili/common/constant/colors.dart';
import 'package:dropili/common/extensions/translation_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AddCostumeBlocksIcon extends StatelessWidget {
  final String imagePath;
  const AddCostumeBlocksIcon({required this.imagePath});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: GestureDetector(
        onTap: () {
          showDialog<void>(
            context: context,
            barrierDismissible: false, // user must tap button!
            builder: (_) {
              return BlocProvider.value(
                value: context.read<EditProfileBloc>(),
                child: AddCustomBlocksDialog(),
              );
            },
          );
        },
        child: Container(
          padding: EdgeInsets.all(15),
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: MalinColors.greyElemntsColor,
            borderRadius: BorderRadius.circular(13),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                decoration: BoxDecoration(
                  color: Colors.transparent,
                  borderRadius: BorderRadius.circular(50),
                  boxShadow: [
                    BoxShadow(
                      offset: Offset(0.0, 5.0),
                      blurRadius: 10,
                      spreadRadius: 1,
                      color: Colors.black12.withAlpha(20),
                    ),
                  ],
                ),
                child: Icon(Icons.add_circle_outline_rounded, size: 90),
              ),
              FittedBox(
                fit: BoxFit.fitWidth,
                child: Text(
                  'Costum'.t(context),
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
