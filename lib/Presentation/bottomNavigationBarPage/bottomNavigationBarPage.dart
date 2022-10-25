import 'package:dropili/common/constant/colors.dart';
import 'package:flutter/material.dart';

class BottomNavigationBarPage extends StatefulWidget {
  const BottomNavigationBarPage({Key? key}) : super(key: key);

  @override
  State<BottomNavigationBarPage> createState() =>
      _BottomNavigationBarPageState();
}

class _BottomNavigationBarPageState extends State<BottomNavigationBarPage> {
  /*int CurrentIndex=0;
  final screens = [
    ChatPage(),
    CallsPage(),
    PeoplePage(),
    StoriesPage(),
  ];*/
  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      //currentIndex: CurrentIndex,
      //onTap: (index) => setState(()=>CurrentIndex = index) ,
      type: BottomNavigationBarType.fixed,
      backgroundColor: MalinColors.AppBlue,
      selectedItemColor: Colors.white,
      unselectedItemColor: Colors.white54,
      items: const <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: ImageIcon(
            AssetImage("assets/appIcons/profile.png"),
            size: 24,
          ),
          label: '',
        ),
        BottomNavigationBarItem(
          icon: ImageIcon(
            AssetImage("assets/appIcons/scan.png"),
            size: 24,
          ),
          label: '',
        ),
        BottomNavigationBarItem(
          icon: ImageIcon(
            AssetImage("assets/appIcons/qr.png"),
          ),
          label: '',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.amp_stories),
          label: '',
        ),
      ],
    );
  }
}
