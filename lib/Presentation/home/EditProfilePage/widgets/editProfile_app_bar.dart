import 'package:dropili/common/constant/colors.dart';
import 'package:flutter/material.dart';

class EditProfileAppBar extends StatelessWidget implements PreferredSizeWidget {
  final AppBar appBar;
  EditProfileAppBar({required this.appBar});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: 0,
      backgroundColor: MalinColors.AppBlue,
      iconTheme: IconThemeData(color: Colors.black),
      leading: IconButton(
        icon: Icon(
          Icons.arrow_back_ios_new,
          color: Colors.white,
        ),
        onPressed: () {
          Navigator.pop(context);
        },
      ),
      title: Center(
        child: Text(
          'Modifier mon profil',
          style: TextStyle(color: Colors.white),
        ),
      ),
      actions: <Widget>[
        IconButton(
          icon: Icon(
            Icons.share,
            color: Colors.white,
          ),
          onPressed: () {
            // do something
          },
        )
      ],
    );
  }

  @override
  Size get preferredSize => new Size.fromHeight(appBar.preferredSize.height);
}
