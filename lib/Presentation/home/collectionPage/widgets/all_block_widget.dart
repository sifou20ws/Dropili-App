import 'package:dropili/Presentation/home/ProfilePage/widgets/profile_grid.dart';
import 'package:dropili/Presentation/home/collectionPage/widgets/friend_Custom_Blocks_grid.dart';
import 'package:dropili/common/extensions/translation_extension.dart';
import 'package:dropili/data/models/get_blocks_model.dart';
import 'package:flutter/material.dart';
import 'package:dropili/data/models/get_friends_result_model.dart.dart' as frnd;

class AllBlockWidget extends StatelessWidget {
  const AllBlockWidget({
    Key? key,
    required this.blocksTypesList,
    required frnd.FriendsItem freindProfile,
  }) : _freindProfile = freindProfile, super(key: key);

  final List<List<UserBlocksItem>> blocksTypesList;
  final frnd.FriendsItem _freindProfile;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
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
        SizedBox(height: 20),
        !_freindProfile.customBlocks.isEmpty
            ? FriendCostumeBlocksGrid(
                costumeBlocksList:
                    _freindProfile.customBlocks)
            : Container(),
      ],
    );
  }
}