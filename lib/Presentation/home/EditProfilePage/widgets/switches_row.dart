import 'package:dropili/Presentation/home/EditProfilePage/bloc/editProfileScreen_bloc.dart';
import 'package:dropili/common/constant/colors.dart';
import 'package:dropili/common/extensions/translation_extension.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SwitchesWidget extends StatefulWidget {
  const SwitchesWidget({Key? key}) : super(key: key);
  @override
  State<SwitchesWidget> createState() => _EditProfileButtonsWidget();
}

class _EditProfileButtonsWidget extends State<SwitchesWidget> {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Direct'.t(context),
              style: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 18,
                  color: Colors.black),
            ),
            Transform.scale(
              scale: 0.7,
              child: CupertinoSwitch(
                value: BlocProvider.of<EditProfileBloc>(context)
                    .state
                    .switchButton,
                onChanged: (bool state) {
                  BlocProvider.of<EditProfileBloc>(context)
                      .add(SwitchEvent(state: state));
                  if (state == false) {
                    BlocProvider.of<EditProfileBloc>(context).add(
                        DirectOnMeEvent(
                            direct: '0', block_id: '0', url: 'null'));
                  }
                },
                activeColor: MalinColors.AppGreen,
              ),
            ),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Profile active'.t(context),
              style: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 18,
                  color: Colors.black),
            ),
            Transform.scale(
              scale: 0.7,
              child: CupertinoSwitch(
                value: BlocProvider.of<EditProfileBloc>(context)
                    .state
                    .activeButton,
                onChanged: (bool state) {
                  BlocProvider.of<EditProfileBloc>(context)
                      .add(ActiveEvent(state: state));
                },
                activeColor: MalinColors.AppGreen,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
