import 'package:flutter/material.dart';

class DrawerPage extends StatelessWidget {
  const DrawerPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 15, horizontal: 10),
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            Column(
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
                SizedBox(height: 35),
                Center(
                  child: Container(
                    child: Image.asset(
                      "assets/dropili_Logo_PNG.png",
                      scale: 10,
                    ),
                  ),
                ),
                SizedBox(height: 35),
              ],
            ),
            DrawerItem(
              image: 'profile.png',
              title: 'Editer mon profile',
              onDrawerItemTap: () {
                Navigator.pop(context);
              },
            ),
            DrawerItem(
              image: 'qr.png',
              title: 'Mon QR Code',
              onDrawerItemTap: () {
                Navigator.pop(context);
              },
            ),
            DrawerItem(
              image: 'profile.png',
              title: 'Mode d\'emploi',
              onDrawerItemTap: () {
                Navigator.pop(context);
              },
            ),
            DrawerItem(
              image: 'profile.png',
              title: 'Changer la langue',
              onDrawerItemTap: () {
                Navigator.pop(context);
              },
            ),
            DrawerItem(
              image: 'profile.png',
              title: 'Se déconnecter',
              onDrawerItemTap: () {
                Navigator.pop(context);
              },
            ),
            DrawerItem(
              image: 'profile.png',
              title: 'A propos de dropili',
              onDrawerItemTap: () {
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
    );
  }
}

class DrawerItem extends StatelessWidget {
  final String image, title;
  final onDrawerItemTap;
  const DrawerItem(
      {required this.image, required this.title, this.onDrawerItemTap});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Row(
        children: <Widget>[
          Image.asset(
            "assets/appIcons/$image",
            scale: 35,
          ),
          SizedBox(width: 25),
          Text(
            title,
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.w400),
          ),
        ],
      ),
      onTap: onDrawerItemTap,
    );
  }
}
