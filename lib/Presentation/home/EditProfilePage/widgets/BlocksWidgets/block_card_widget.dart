import 'package:cached_network_image/cached_network_image.dart';
import 'package:dropili/common/constant/colors.dart';
import 'package:dropili/data/models/get_blocks_model.dart';
import 'package:flutter/material.dart';

class BlockCardWidget extends StatelessWidget {
  final String blockImage;
  final String title;
  final int id;
  final List<UserBlocksItem> userBlocks;
  const BlockCardWidget(
      {required this.blockImage,
      required this.title,
      required this.id,
      required this.userBlocks});

  @override
  Widget build(BuildContext context) {
    bool selected = false;
    userBlocks.forEach((element) {
      if (element.id == id) selected = true;
    });
    return Container(
      alignment: Alignment.center,
      padding: EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: selected
            ? MalinColors.AppGreen.withAlpha(20)
            : MalinColors.greyElemntsColor,
        borderRadius: BorderRadius.circular(13),
        border: selected
            ? Border.all(color: MalinColors.AppGreen.withAlpha(100), width: 2)
            : null,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            decoration: BoxDecoration(
              color: Colors.transparent,
              borderRadius: BorderRadius.circular(15),
              boxShadow: [
                BoxShadow(
                  color: Color.fromARGB(50, 0, 0, 0),
                  offset: Offset(0.0, 5.0),
                  blurRadius: 10,
                  spreadRadius: 1,
                ),
              ],
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(15),
              child: CachedNetworkImage(
                imageUrl: blockImage,
                fadeOutDuration: Duration.zero,
                fadeInDuration: Duration.zero,
                placeholderFadeInDuration: Duration.zero,
                fit: BoxFit.cover,
              ),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          FittedBox(
            fit: BoxFit.fitWidth,
            child: Text(
              title,
              style: TextStyle(
                color: Colors.black,
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            ),
          )
        ],
      ),
    );
  }
}
