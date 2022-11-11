import 'package:dropili/Presentation/home/ProfilePage/widgets/profile_dialogue_box.dart';
import 'package:dropili/Presentation/home/collectionPage/bloc/collection_bloc.dart';
import 'package:dropili/common/extensions/translation_extension.dart';
import 'package:dropili/data/models/get_friends_result_model.dart.dart' as frnd;
import 'package:flutter/material.dart';
import 'package:dropili/Presentation/widgets_model/rounded_profile_picture.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProfileCardWidget extends StatelessWidget {
  final frnd.FriendsItem profile;
  const ProfileCardWidget({super.key, required this.profile});

  @override
  Widget build(BuildContext context) {
    return Container(
      // padding: EdgeInsets.symmetric(horizontal: 10, vertical: 15),
      padding: EdgeInsets.only(right: 10, left: 10, top: 15, bottom: 15),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Color.fromARGB(20, 29, 29, 29),
            offset: Offset(0.0, 2.0),
            blurRadius: 10,
            spreadRadius: 5,
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          GestureDetector(
            onTap: () async {
              var result = await Navigator.pushNamed(context, '/showFriend',
                  arguments: profile);
              if (result as bool) {
                BlocProvider.of<CollectionBloc>(context)
                    .add(DeleteFriendEvent(id: profile.id.toString()));
              } else {
                return;
              }
            },
            child: RoundedProfilePicture(
              image: profile.userProfile.originalUrl,
              get: true,
              size: 80,
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                profile.name,
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 18,
                    fontWeight: FontWeight.w600),
              ),
              Text(
                DateTime.now().day.toString() +
                    '/' +
                    DateTime.now().month.toString() +
                    '/' +
                    DateTime.now().year.toString(),
                style: TextStyle(
                    color: Colors.grey,
                    fontSize: 14,
                    fontWeight: FontWeight.w400),
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                // padding: EdgeInsets.symmetric(horizontal: 5, vertical: 6),
                padding: EdgeInsets.only(left: 5, right: 0, top: 6, bottom: 6),
                height: 50,
                width: 180,
                decoration: BoxDecoration(
                    color: Colors.grey.shade200,
                    borderRadius: BorderRadius.circular(10)),
                // child: Image.network(
                //     state.blocks[0].icon.originalUrl),
                child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  physics: BouncingScrollPhysics(),
                  // shrinkWrap: true,
                  itemCount: profile.blocks.length,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () {
                        showDialog(
                            context: context,
                            builder: ((context) {
                              return ProfileDialogBox(
                                blockId: profile.blocks[index].id,
                                url: profile.blocks[index].hint.ar,
                                iconImage: Image.network(
                                  profile.blocks[index].icon.originalUrl,
                                ),
                              );
                            }));
                      },
                      child: Image.network(
                        profile.blocks[index].icon.originalUrl,
                        // height: 30,
                        // width: 30,
                      ),
                    );
                  },
                  separatorBuilder: (context, index) => SizedBox(
                    width: 5,
                  ),
                ),
              ),
            ],
          ),
          Container(
            height: 40,
            width: 40,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Color.fromARGB(20, 29, 29, 29),
                  offset: Offset(0.0, 2.0),
                  blurRadius: 5,
                  spreadRadius: 2,
                ),
              ],
            ),
            // child: Icon(Icons.more_horiz),
            child: PopupMenuButton<String>(
              icon: Icon(Icons.more_horiz),
              elevation: 2,
              onSelected: ((value) async {
                if (value == 'Delete') {
                  BlocProvider.of<CollectionBloc>(context)
                      .add(DeleteFriendEvent(id: profile.id.toString()));
                } else if (value == 'Show') {
                  var result = await Navigator.pushNamed(context, '/showFriend',
                      arguments: profile);
                  if (result as bool) {
                    BlocProvider.of<CollectionBloc>(context)
                        .add(DeleteFriendEvent(id: profile.id.toString()));
                  } else {
                    return;
                  }
                }
              }),
              itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
                PopupMenuItem<String>(
                  value: 'Delete',
                  child: Text('Delete'.t(context)),
                ),
                PopupMenuItem<String>(
                  value: 'Show',
                  child: Text('Show'.t(context)),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
