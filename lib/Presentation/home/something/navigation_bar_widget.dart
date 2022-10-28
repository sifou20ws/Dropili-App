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
    return SnakeNavigationBar.color(
      behaviour: SnakeBarBehaviour.pinned,
      snakeShape: SnakeShape.indicator,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      // padding: EdgeInsets.only(bottom: 20, right: 10, left: 10),
      snakeViewColor: MalinColors.AppGreen,
      selectedItemColor: MalinColors.AppGreen,
      unselectedItemColor: Colors.black.withAlpha(150),
      showSelectedLabels: true,
      height: 75,
      showUnselectedLabels: true,
      currentIndex: context.read<NavigationBloc>().state.index,
      elevation: 30,

      onTap: (value) {
        BlocProvider.of<NavigationBloc>(context).add(NavigationEvent(value));
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
            label: 'Scanner'.t(context)),
        BottomNavigationBarItem(
            icon: Icon(
              Icons.qr_code_2_rounded,
              size: 25,
            ),
            label: 'QR code'.t(context)),
        BottomNavigationBarItem(
            icon: Icon(
              Icons.people,
              size: 25,
            ),
            label: 'Collection'.t(context)),
      ],
    );
    // return CustomNavigationBar(
    //     // isFloating: true,
    //     strokeColor: Colors.transparent,
    //     scaleFactor: 0.1,
    //     bubbleCurve: Curves.ease,
    //     currentIndex: selected,

    //     iconSize: 30,
    //     borderRadius: Radius.circular(15),
    //     // backgroundColor: MalinColors.navBarBackground,
    //     selectedColor: MalinColors.AppGreen,
    //     // unSelectedColor: Colors.white.withAlpha(150),
    //     onTap: ((p0) {
    //       setState(() {
    //         selected = p0;
    //       });
    //     }),
    //     // elevation: 1,
    //     items: [
    //       CustomNavigationBarItem(
    //           // title: Text(
    //           //   'pislk',
    //           //   style: TextStyle(color: Colors.white, fontSize: 12),
    //           // ),
    //           icon: Icon(
    //         Icons.person_outline,
    //         size: 31,
    //       )),
    //       CustomNavigationBarItem(
    //           icon: Icon(
    //         Icons.nfc_rounded,
    //         size: 31,
    //       )),
    //       CustomNavigationBarItem(
    //           icon: Icon(
    //         Icons.qr_code_2_rounded,
    //         size: 31,
    //       )),
    //       CustomNavigationBarItem(
    //           icon: Icon(
    //         Icons.history_outlined,
    //         size: 31,
    //       )),
    //     ]);

    // return BottomNavigationBar(
    //   //currentIndex: CurrentIndex,
    //   //onTap: (index) => setState(()=>CurrentIndex = index) ,
    //   type: BottomNavigationBarType.fixed,
    //   backgroundColor: MalinColors.AppBlue,
    //   selectedItemColor: Colors.white,
    //   unselectedItemColor: Colors.white54,
    //   items: const <BottomNavigationBarItem>[
    //     BottomNavigationBarItem(
    //       icon: ImageIcon(
    //         AssetImage("assets/appIcons/profile.png"),
    //         size: 24,
    //       ),
    //       label: '',
    //     ),
    //     BottomNavigationBarItem(
    //       icon: ImageIcon(
    //         AssetImage("assets/appIcons/scan.png"),
    //         size: 24,
    //       ),
    //       label: '',
    //     ),
    //     BottomNavigationBarItem(
    //       icon: ImageIcon(
    //         AssetImage("assets/appIcons/qr.png"),
    //       ),
    //       label: '',
    //     ),
    //     BottomNavigationBarItem(
    //       icon: Icon(Icons.amp_stories),
    //       label: '',
    //     ),
    //   ],
    // );
  }
}
