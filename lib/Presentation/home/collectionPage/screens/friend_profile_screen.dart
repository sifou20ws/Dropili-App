import 'package:cached_network_image/cached_network_image.dart';
import 'package:dropili/Presentation/home/ProfilePage/widgets/profile_grid.dart';
import 'package:dropili/Presentation/widgets_model/cachedImage_widget.dart';
import 'package:dropili/Presentation/widgets_model/rounded_profile_picture.dart';
import 'package:dropili/common/extensions/translation_extension.dart';
import 'package:dropili/data/models/get_blocks_model.dart';
import 'package:dropili/data/models/get_friends_result_model.dart.dart' as frnd;
import 'package:flutter/material.dart';

class FriendProfileScreen extends StatefulWidget {
  FriendProfileScreen({super.key}) {}

  @override
  State<FriendProfileScreen> createState() => _FriendProfileScreenState();
}

class _FriendProfileScreenState extends State<FriendProfileScreen> {
  late frnd.FriendsItem _freindProfile;

  @override
  Widget build(BuildContext context) {
    _freindProfile =
        ModalRoute.of(context)?.settings.arguments as frnd.FriendsItem;

    List<List<UserBlocksItem>> blocksTypesList = [
      _freindProfile.blocks.where((element) => element.type == 1).toList(),
      _freindProfile.blocks.where((element) => element.type == 2).toList(),
      _freindProfile.blocks.where((element) => element.type == 3).toList(),
      _freindProfile.blocks.where((element) => element.type == 4).toList(),
    ]..removeWhere((element) => element.isEmpty);

    return Scaffold(
      body: SafeArea(
        child: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          color: Colors.white,
          child: SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: Stack(
              children: <Widget>[
                Container(
                  height: MediaQuery.of(context).size.height * 0.25,
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      fit: BoxFit.fill,
                      image: AssetImage('assets/transparent.png'),
                      alignment: Alignment.topCenter,
                    ),
                  ),
                  child: cachedImageModelWidget(
                      image: _freindProfile.userBackground.originalUrl),
                ),
                Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(10),
                      child: Row(
                        children: [
                          ElevatedButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: Icon(
                              Icons.arrow_back_rounded,
                              color: Colors.black,
                              size: 30,
                            ),
                            style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.white,
                                elevation: 20,
                                shape: CircleBorder(),
                                shadowColor: Colors.black.withAlpha(150),
                                padding: EdgeInsets.all(8)),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 150,
                    ),
                    Container(
                      // color: Colors.white,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(20),
                            topRight: Radius.circular(20),
                          )),
                      child: Padding(
                        padding: EdgeInsets.only(
                            top: 20, left: 20, right: 20, bottom: 50),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                GestureDetector(
                                    onTap: () async {
                                      Navigator.pushNamed(
                                              context, '/editProfile')
                                          .then((value) {});
                                    },
                                    child: Container()),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    Navigator.pop(context, true);
                                  },
                                  child: Container(
                                    alignment: Alignment.center,
                                    height: 40,
                                    width: 130,
                                    decoration: BoxDecoration(
                                      color: Colors.red.shade400,
                                      // color: Colors.white,
                                      borderRadius: BorderRadius.circular(15),
                                    ),
                                    child: Text(
                                      'Delete friend'.t(context),
                                      style: TextStyle(
                                          // color: MalinColors.AppGreen,
                                          color: Colors.white,
                                          fontSize: 15,
                                          fontWeight: FontWeight.w500),
                                    ),
                                  ),
                                )
                              ],
                            ),
                            SizedBox(height: 20),
                            Padding(
                              padding: EdgeInsets.only(left: 10),
                              child: Row(
                                children: [
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        _freindProfile.userProfile.name,
                                        style: TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.w500,
                                            color: Colors.black),
                                      ),
                                      SizedBox(height: 5),
                                      SizedBox(
                                        width: 300,
                                        child: Text(
                                          _freindProfile.description,
                                          style: TextStyle(
                                            fontSize: 15,
                                            color: Colors.grey.shade700,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(height: 35),
                            ListView.separated(
                              physics: NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              itemCount: blocksTypesList.length,
                              itemBuilder: (context, index) {
                                var title = '';
                                switch (blocksTypesList[index][0].type) {
                                  case 1:
                                    title = 'Contacts'.t(context);
                                    break;
                                  case 2:
                                    title = 'Social Media'.t(context);
                                    break;
                                  case 3:
                                    title = 'Payment methods'.t(context);
                                    break;
                                  case 4:
                                    title = 'Others'.t(context);
                                    break;
                                  default:
                                }
                                return BlockTypeGrid(
                                  title: title,
                                  blocksList: blocksTypesList[index],
                                );
                              },
                              separatorBuilder: (context, index) => SizedBox(
                                height: 25,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                Positioned(
                  top: 120,
                  left: 30,
                  child: Container(
                    padding: EdgeInsets.all(8),
                    decoration: BoxDecoration(
                        color: Colors.white, shape: BoxShape.circle),
                    child: Hero(
                      tag: _freindProfile.name,
                      child: RoundedProfilePicture(
                        image: (_freindProfile.userProfile.originalUrl == '')
                            ? 'assets/dropili_Logo_PNG.png'
                            : _freindProfile.userProfile.originalUrl,
                        get: !(_freindProfile.userProfile.originalUrl == ''),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
