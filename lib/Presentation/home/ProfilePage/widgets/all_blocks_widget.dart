import 'package:dropili/Presentation/home/ProfilePage/widgets/CostumeBlocksGrid.dart';
import 'package:dropili/Presentation/home/ProfilePage/widgets/profile_grid.dart';
import 'package:dropili/common/extensions/translation_extension.dart';
import 'package:flutter/material.dart';

class AllBlockWidget extends StatelessWidget {
  final userBlocks, costumeBlocks;
  const AllBlockWidget({
    Key? key,
    this.userBlocks,
    this.costumeBlocks,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListView.separated(
          physics: NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemCount: userBlocks.length,
          itemBuilder: (context, index) {
            var title = '';
            switch (userBlocks[index][0].type) {
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
              blocksList: userBlocks[index],
            );
          },
          separatorBuilder: (context, index) => SizedBox(height: 25),
        ),
        SizedBox(height: 20),
        (costumeBlocks.length != 0)
            ? CostumeBlocksGrid(
                costumeBlocksList: costumeBlocks,
              )
            : Container(),
      ],
    );
  }
}
