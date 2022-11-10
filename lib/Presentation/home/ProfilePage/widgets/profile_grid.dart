import 'dart:developer';

import 'package:dropili/Presentation/home/ProfilePage/widgets/block_card.dart';
import 'package:dropili/Presentation/home/ProfilePage/widgets/profile_dialogue_box.dart';
import 'package:dropili/data/models/get_blocks_model.dart';
import 'package:flutter/material.dart';

class ProfileGrid extends StatelessWidget {
  final String title, type;
  final List<UserBlocksItem> myList;
  const ProfileGrid({
    required this.title,
    required this.myList,
    required this.type,
  });

  @override
  Widget build(BuildContext context) {
    return (myList.length != 0)
        ? Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                title,
                style: TextStyle(fontSize: 25, fontWeight: FontWeight.w600),
              ),
              SizedBox(height: 10),
              GridView.builder(
                physics: ClampingScrollPhysics(),
                shrinkWrap: true,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  crossAxisSpacing: 15,
                  mainAxisSpacing: 20,
                  mainAxisExtent: 138,
                ),
                // itemCount: myList.length,
                itemCount: myList.length,
                itemBuilder: (BuildContext ctx, index) {
                  return GestureDetector(
                      onTap: () {
                        showDialog<void>(
                          context: context,
                          barrierDismissible: false, // user must tap button!
                          builder: (_) {
                            return ProfileDialogBox(
                              url:myList[index].pivot.url,
                              blocksList: myList,
                              index: myList[index].id,
                              img:
                                  Image.network(myList[index].icon.originalUrl),
                            );
                          },
                        );
                        int id = myList[index].id;
                        log('index $id');
                      },
                      child: BlockCardWidget(
                          blockImage:
                              Image.network(myList[index].icon.originalUrl),
                          blockName: myList[index].icon.name));
                },
              ),
            ],
          )
        : Container();
  }
}
