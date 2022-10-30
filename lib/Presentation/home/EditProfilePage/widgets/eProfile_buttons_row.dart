import 'package:dropili/Presentation/home/EditProfilePage/bloc/editProfileScreen_bloc.dart';
import 'package:dropili/Presentation/home/EditProfilePage/widgets/edit_profile_buttons.dart';
import 'package:dropili/common/constant/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class EditProfileButtonsWidget extends StatefulWidget {
  const EditProfileButtonsWidget({Key? key}) : super(key: key);

  @override
  State<EditProfileButtonsWidget> createState() => _EditProfileButtonsWidget();
}

class _EditProfileButtonsWidget extends State<EditProfileButtonsWidget> {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        EditProfileButton(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                'Direct sur',
                style: TextStyle(
                    fontWeight: FontWeight.w400,
                    fontSize: 18,
                    color: Colors.blue),
              ),
              SizedBox(width: 3),
              CupertinoSwitch(
                value: BlocProvider.of<EditProfileBloc>(context)
                    .state
                    .switchButton,
                onChanged: (bool state) {
                  BlocProvider.of<EditProfileBloc>(context)
                      .add(SwitchEvent(state: state));
                }, //
                activeColor: MalinColors.AppBlue,
              ),
            ],
          ),
        ),
        GestureDetector(
          onTap: () {
            context.read<EditProfileBloc>().add(ImportCoverImageEvent());
          },
          child: EditProfileButton(
            child: Text(
              'Profile active',
              style: TextStyle(
                  fontWeight: FontWeight.w400,
                  fontSize: 18,
                  color: Colors.blue),
            ),
          ),
        ),
      ],
    );
  }
}
