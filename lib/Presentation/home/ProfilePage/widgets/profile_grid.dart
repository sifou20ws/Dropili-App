
import 'package:dropili/Presentation/home/ProfilePage/widgets/block_card.dart';
import 'package:dropili/data/models/get_blocks_model.dart';
import 'package:flutter/material.dart';

class BlockTypeGrid extends StatelessWidget {
  final String title;
  final List<UserBlocksItem> blocksList;
  const BlockTypeGrid({
    required this.title,
    required this.blocksList,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
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
          // itemCount: blocksList.length,
          itemCount: blocksList.length,
          itemBuilder: (BuildContext ctx, index) {
            return GestureDetector(
                onTap: () {
                },
                child: BlockCardWidget(
                    blockImage: Image.network(blocksList[index].icon.originalUrl),
                    blockName: blocksList[index].title.ar));
          },
        ),
      ],
    );
  }
}
