import 'package:dropili/Presentation/authentification/bloc/auth_bloc.dart';
import 'package:dropili/Presentation/home/ProfilePage/bloc/profileScreen_bloc.dart';
import 'package:dropili/Presentation/home/collectionPage/bloc/collection_bloc.dart';
import 'package:dropili/Presentation/home/root/bloc/navigation_bloc.dart';
import 'package:dropili/Presentation/localization/bloc/language_bloc.dart';
import 'package:dropili/Presentation/widgets_model/rounded_profile_picture.dart';
import 'package:dropili/common/constant/colors.dart';
import 'package:dropili/common/constant/languages.dart';
import 'package:dropili/common/extensions/translation_extension.dart';
import 'package:dropili/core/utils/storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dropili/di/get_it.dart' as getIt;

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
                    Icons.arrow_back,
                    color: Colors.black,
                  ),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    ProfileTopWidget(),
                    SizedBox(
                      height: 30,
                    ),
                    ElementsWidget(),
                    SizedBox(
                      height: 30,
                    ),
                    LogoutButton(),
                  ],
                ),
              ),
            ),
            // Spacer(),
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
}

class ElementsWidget extends StatelessWidget {
  const ElementsWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Color.fromARGB(10, 29, 29, 29),
            offset: Offset(0.0, 2.0),
            blurRadius: 5,
            spreadRadius: 0,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          DrawerItem(
            icon: Icons.edit,
            title: 'Edit my profile'.t(context),
            onDrawerItemTap: () {
              Navigator.pop(context);
              Navigator.pushNamed(context, '/editProfile').then(
                (value) {},
              );
            },
          ),
          SizedBox(
            height: 10,
            width: 230,
            child: Divider(color: Colors.grey.shade200, thickness: 1),
          ),
          DrawerItem(
            icon: Icons.qr_code_2_rounded,
            title: 'Sharing Dropili Profile'.t(context),
            onDrawerItemTap: () {
              BlocProvider.of<NavigationBloc>(context).add(NavigationEvent(2));
              Navigator.pop(context);
            },
          ),
          SizedBox(
            height: 10,
            width: 230,
            child: Divider(color: Colors.grey.shade200, thickness: 1),
          ),
          // DrawerItem(
          //   icon: Icons.language_outlined,
          //   title: 'Change language'.t(context),
          //   onDrawerItemTap: () {
          //     Navigator.pop(context);
          //     Navigator.pushNamed(context, '/changeLanguage');
          //   },
          // ),
          ChangeLanguageExpensionTile(),
          SizedBox(
            height: 10,
            width: 230,
            child: Divider(color: Colors.grey.shade200, thickness: 1),
          ),
          DrawerItem(
            icon: Icons.storefront_outlined,
            title: 'Work mode'.t(context),
            onDrawerItemTap: () {
              Navigator.pop(context);
            },
          ),
          SizedBox(
            height: 10,
            width: 230,
            child: Divider(color: Colors.grey.shade200, thickness: 1),
          ),
          DrawerItem(
            icon: Icons.info_outline_rounded,
            title: 'About Dropili'.t(context),
            onDrawerItemTap: () {
              Navigator.pop(context);
            },
          ),
        ],
      ),
    );
  }
}

class ChangeLanguageExpensionTile extends StatelessWidget {
  const ChangeLanguageExpensionTile({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
      child: ExpansionTile(
        childrenPadding: EdgeInsets.only(left: 20),
        collapsedIconColor: Colors.grey.shade300,
        title: Row(
          children: <Widget>[
            Icon(
              Icons.language_outlined,
              size: 28,
              color: MalinColors.AppBlue2,
            ),
            SizedBox(width: 20),
            Text(
              'Change Language'.t(context),
              style: TextStyle(
                fontSize: 17,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
        children: [
          for (var language in Languages.languages)
            ListTile(
              dense: true,
              title: Text(
                language.value,
                style: TextStyle(
                  fontSize: 15,
                  color: (context.read<LanguageBloc>().state as LanguageLoaded)
                              .locale
                              .languageCode
                              .toLowerCase() ==
                          language.code
                      ? Colors.blue
                      : Colors.black,
                ),
              ),
              onTap: () {
                Navigator.pop(context);
                BlocProvider.of<LanguageBloc>(context)
                    .add(ToggleLanguageEvent(language));
                BlocProvider.of<ProfileBloc>(context).add(GetEverytihngEvent());
              },
            )
        ],
      ),
    );
  }
}

class ProfileTopWidget extends StatelessWidget {
  const ProfileTopWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        BlocProvider.of<NavigationBloc>(context).add(NavigationEvent(0));
        Navigator.pop(context);
      },
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: Color.fromARGB(10, 29, 29, 29),
              offset: Offset(0.0, 2.0),
              blurRadius: 5,
              spreadRadius: 0,
            ),
          ],
        ),
        padding: EdgeInsets.all(10),
        child: Row(
          children: [
            RoundedProfilePicture(
              image: context
                  .read<ProfileBloc>()
                  .state
                  .showProfile!
                  .user
                  .userProfile
                  .originalUrl,
              get: true,
              size: 60,
            ),
            SizedBox(
              width: 15,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  context.read<ProfileBloc>().state.showProfile!.user.name,
                  textAlign: TextAlign.start,
                  style: TextStyle(fontSize: 17, fontWeight: FontWeight.w500),
                  overflow: TextOverflow.ellipsis,
                ),
                SizedBox(
                  height: 5,
                ),
                Text(
                  'Show my profile'.t(context),
                  textAlign: TextAlign.start,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    color: Colors.grey,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
            Spacer(),
            Icon(
              Icons.arrow_forward_ios_outlined,
              size: 15,
              color: Colors.grey.shade300,
            )
          ],
        ),
      ),
    );
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
    return Container(
      child: ListTile(
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
              style: TextStyle(
                fontSize: 17,
                fontWeight: FontWeight.w500,
              ),
            ),
            Spacer(),
            Icon(
              Icons.arrow_forward_ios_outlined,
              size: 15,
              color: Colors.grey.shade300,
            )
          ],
        ),
        onTap: onDrawerItemTap,
      ),
    );
  }
}

class LogoutButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      // padding: EdgeInsets.all(17),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Color.fromARGB(10, 29, 29, 29),
            offset: Offset(0.0, 2.0),
            blurRadius: 5,
            spreadRadius: 0,
          ),
        ],
      ),
      child: ListTile(
        title: Row(
          // mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Icon(
              Icons.logout_rounded,
              size: 28,
              color: Colors.red.shade400,
            ),
            SizedBox(width: 10),
            Text(
              'Log out'.t(context).toUpperCase(),
              style: TextStyle(
                fontSize: 17,
                fontWeight: FontWeight.w500,
                color: Colors.red.shade400,
              ),
            ),
            Spacer(),
            Icon(
              Icons.arrow_forward_ios_outlined,
              size: 15,
              color: Colors.grey.shade300,
            )
          ],
        ),
        onTap: () {
          BlocProvider.of<AuthBloc>(context).add(LogoutEvent());
          Navigator.pushReplacementNamed(context, '/signin');
        },
      ),
    );
  }
}
