import 'package:dropili/Presentation/home/root/bloc/navigation_bloc.dart';
import 'package:dropili/Presentation/widgets_model/rounded_profile_picture.dart';
import 'package:dropili/common/constant/colors.dart';
import 'package:dropili/common/extensions/translation_extension.dart';
import 'package:dropili/core/utils/token.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DrawerPage extends StatelessWidget {
  const DrawerPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 30, horizontal: 10),
        child: Column(
          // padding: EdgeInsets.zero,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                SizedBox(height: 10),
                IconButton(
                  icon: Icon(
                    Icons.arrow_back_ios_new,
                    color: Colors.black,
                  ),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
              ],
            ),
            SizedBox(
              height: 20,
            ),
            RoundedProfilePicture(
              image: 'assets/mee.jpeg',
            ),
            SizedBox(
              height: 20,
            ),
            Text(
              'Abdennour kharouri',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
            ),
            Padding(
              padding: EdgeInsets.only(top: 15, bottom: 20),
              child: SizedBox(
                height: 4,
                width: 150,
                // child: Divider(color: MalinColors.AppGreen, thickness: 2),
                child: Container(
                  decoration:
                      BoxDecoration(gradient: MalinColors.greenGradient),
                ),
              ),
            ),
            DrawerItem(
              icon: Icons.person_outlined,
              title: 'Edite my profile'.t(context),
              onDrawerItemTap: () {
                Navigator.pop(context);
              },
            ),
            DrawerItem(
              icon: Icons.qr_code_2_rounded,
              title: 'Share profile'.t(context),
              onDrawerItemTap: () {
                BlocProvider.of<NavigationBloc>(context)
                    .add(NavigationEvent(2));
                Navigator.pop(context);
              },
            ),
            DrawerItem(
              icon: Icons.storefront_outlined,
              title: 'Work mode'.t(context),
              onDrawerItemTap: () {
                Navigator.pop(context);
              },
            ),
            DrawerItem(
              icon: Icons.language_outlined,
              title: 'Change language'.t(context),
              onDrawerItemTap: () {
                Navigator.pop(context);
                Navigator.pushNamed(context, '/changeLanguage');
              },
            ),
            DrawerItem(
              icon: Icons.info_outline_rounded,
              title: 'About dropili'.t(context),
              onDrawerItemTap: () {
                Navigator.pop(context);
              },
            ),
            DrawerItem(
              icon: Icons.logout_rounded,
              title: 'Log out'.t(context),
              onDrawerItemTap: () {
                logOut(context);
              },
            ),
            Spacer(),
            Center(
              child: Container(
                child: Image.asset(
                  'assets/dropili_Logo_PNG.png',
                  scale: 10,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> logOut(context) async {
    await TokenHandler.deleteToken();
    Navigator.pushReplacementNamed(context, '/signin');
  }
}

class DrawerItem extends StatelessWidget {
  final String title;
  final IconData icon;
  final onDrawerItemTap;
  const DrawerItem(
      {required this.icon, required this.title, this.onDrawerItemTap});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Row(
        children: <Widget>[
          Icon(
            icon,
            size: 28,
            color: MalinColors.AppBlue2,
          ),
          SizedBox(width: 20),
          Text(
            title,
            style: TextStyle(fontSize: 19, fontWeight: FontWeight.w400),
          ),
        ],
      ),
      onTap: onDrawerItemTap,
    );
  }
}
