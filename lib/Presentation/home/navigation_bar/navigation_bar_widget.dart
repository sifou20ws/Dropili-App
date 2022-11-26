import 'package:dropili/Presentation/home/root/bloc/navigation_bloc.dart';
import 'package:dropili/common/constant/colors.dart';
import 'package:dropili/common/extensions/translation_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_snake_navigationbar/flutter_snake_navigationbar.dart';

class NavigatioBarWidget extends StatefulWidget {
  const NavigatioBarWidget({Key? key}) : super(key: key);

  @override
  State<NavigatioBarWidget> createState() => _BottomNavigationBarPageState();
}

class _BottomNavigationBarPageState extends State<NavigatioBarWidget> {
  @override
  Widget build(BuildContext context) {
    return SnakeNavigationBar.gradient(
      behaviour: SnakeBarBehaviour.pinned,
      snakeShape: SnakeShape.indicator,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      // padding: EdgeInsets.only(bottom: 20, right: 10, left: 10),
      // snakeViewColor: MalinColors.AppBlue,
      // selectedItemColor: MalinColors.AppBlue,
      // unselectedItemColor: Colors.black.withAlpha(150),

      unselectedItemGradient: LinearGradient(
          begin: Alignment.topRight,
          end: Alignment.topLeft,
          colors: [
            Colors.black.withAlpha(159),
            Colors.black.withAlpha(159),
          ]),
      snakeViewGradient: MalinColors.greenGradient,
      selectedItemGradient: LinearGradient(
          begin: Alignment.topRight,
          end: Alignment.topLeft,
          colors: [MalinColors.AppGreen, MalinColors.AppGreen]),
      showSelectedLabels: true,
      height: 70,
      showUnselectedLabels: true,
      currentIndex: context.read<NavigationBloc>().state.index,
      elevation: 30,
      selectedLabelStyle: TextStyle(fontSize: 13),
      unselectedLabelStyle: TextStyle(fontSize: 13),

      onTap: (value) async {
        BlocProvider.of<NavigationBloc>(context).add(NavigationEvent(value));
        await Future.delayed(Duration(seconds: 1));
      },
      items: [
        BottomNavigationBarItem(
            icon: Icon(
              Icons.person_outline,
              size: 25,
            ),
            label: 'Profile'.t(context)),
        BottomNavigationBarItem(
            icon: Icon(
              Icons.nfc_outlined,
              size: 25,
            ),
            label: 'Activate'.t(context)),
        BottomNavigationBarItem(
            icon: Icon(
              Icons.qr_code_2_rounded,
              size: 25,
            ),
            label: 'Share'.t(context)),
        BottomNavigationBarItem(
            icon: Icon(
              Icons.people,
              size: 25,
            ),
            label: 'Collection'.t(context)),
      ],
    );
  }
}
