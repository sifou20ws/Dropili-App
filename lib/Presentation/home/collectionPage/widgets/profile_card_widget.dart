import 'dart:developer';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:dropili/Presentation/home/collectionPage/bloc/collection_bloc.dart';
import 'package:dropili/Presentation/widgets_model/snackbar.dart';
import 'package:dropili/common/extensions/translation_extension.dart';
import 'package:dropili/data/models/get_friends_result_model.dart.dart' as frnd;
import 'package:dropili/data/models/url_prefix_model.dart';
import 'package:flutter/material.dart';
import 'package:dropili/Presentation/widgets_model/rounded_profile_picture.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:url_launcher/url_launcher.dart';

class ProfileCardWidget extends StatelessWidget {
  final frnd.FriendsItem profile;
  const ProfileCardWidget({super.key, required this.profile});

  Future<void> _launchUrl(String url) async {
    final Uri _url = Uri.parse(url);

    if (!await launchUrl(_url, mode: LaunchMode.externalApplication))
      log('could not launch your url');
  }

  @override
  Widget build(BuildContext context) {
    var allBlocks = profile.blocks + profile.customBlocks;
    return Container(
      // padding: EdgeInsets.symmetric(horizontal: 10, vertical: 15),
      padding: EdgeInsets.only(right: 10, left: 10, top: 15, bottom: 15),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
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
              if (result == null) return;
              if (result as bool) {
                BlocProvider.of<CollectionBloc>(context)
                    .add(DeleteFriendEvent(id: profile.id.toString()));
              } else {
                return;
              }
            },
            child: Hero(
              tag: profile.name,
              child: RoundedProfilePicture(
                image: profile.userProfile.originalUrl,
                get: true,
                size: 80,
              ),
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
              // Text(
              //   DateTime.now().day.toString() +
              //       '/' +
              //       DateTime.now().month.toString() +
              //       '/' +
              //       DateTime.now().year.toString(),
              //   style: TextStyle(
              //       color: Colors.grey,
              //       fontSize: 14,
              //       fontWeight: FontWeight.w400),
              // ),
              SizedBox(
                height: 10,
              ),
              Container(
                // padding: EdgeInsets.symmetric(horizontal: 5, vertical: 6),
                padding: EdgeInsets.only(left: 5, right: 0, top: 6, bottom: 6),
                height: 50,
                width: 180,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                    color: Colors.grey.shade200,
                    borderRadius: BorderRadius.circular(10)),
                child: profile.active
                    ? ListView.separated(
                        scrollDirection: Axis.horizontal,
                        physics: BouncingScrollPhysics(),
                        // shrinkWrap: true,
                        itemCount: allBlocks.length,
                        itemBuilder: (context, index) {
                          return GestureDetector(
                            onTap: () async {
                              if (URLPrefixModel.prefix[allBlocks[index].id] !=
                                  null) {
                                String furl =
                                    URLPrefixModel.prefix[allBlocks[index].id]!;
                                _launchUrl('$furl' +
                                    allBlocks[index]
                                        .pivot
                                        .url
                                        .replaceAll(' ', ''));
                              } else {
                                await Clipboard.setData(ClipboardData(
                                    text: allBlocks[index].pivot.url));
                                SnackBars.showSucessSnackBar(
                                    context,
                                    'Profile link copied to clipboard'
                                        .t(context));
                              }
                            },
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(7),
                              child: CachedNetworkImage(
                                imageUrl: allBlocks[index].icon.originalUrl,
                                fadeOutDuration: Duration.zero,
                                fadeInDuration: Duration.zero,
                                placeholderFadeInDuration: Duration.zero,
                                fit: BoxFit.cover,
                                errorWidget: (context, url, error) => Image(
                                  image:
                                      AssetImage('assets/dropili_app_logo.png'),
                                ),
                              ),
                            ),
                          );
                        },
                        separatorBuilder: (context, index) => SizedBox(
                          width: 5,
                        ),
                      )
                    : Text(
                        'Profile not active'.t(context),
                        style: TextStyle(
                            color: Colors.grey.shade700, fontSize: 14),
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
                  value: 'Show',
                  child: Text('Show'.t(context)),
                ),
                PopupMenuItem<String>(
                  value: 'Delete',
                  child: Text('Delete'.t(context)),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
