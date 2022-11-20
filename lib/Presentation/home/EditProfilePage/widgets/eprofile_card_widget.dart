import 'package:cached_network_image/cached_network_image.dart';
import 'package:dropili/common/constant/colors.dart';
import 'package:dropili/data/models/get_blocks_model.dart';
import 'package:flutter/material.dart';

class BlockCardWidget extends StatelessWidget {
  final CachedNetworkImage blockImage;
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
              boxShadow: [
                BoxShadow(
                  color: Color.fromARGB(50, 0, 0, 0),
                  offset: Offset(0.0, 5.0),
                  blurRadius: 10,
                  spreadRadius: 1,
                ),
              ],
            ),
            child: blockImage,
          ),
          SizedBox(
            height: 5,
          ),
          FittedBox(
            fit: BoxFit.fitWidth,
            child: Text(
              title,
              style: TextStyle(
                color: Colors.black,
                fontSize: 15,
                fontWeight: FontWeight.w500,
              ),
            ),
          )
        ],
      ),
    );
    // return Container(
    //   decoration: BoxDecoration(
    //     color: selected
    //         ? MalinColors.AppGreen.withOpacity(0.5)
    //         : Colors.grey.shade100,
    //     borderRadius: BorderRadius.all(Radius.circular(15)),
    //   ),
    //   child: Padding(
    //       padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
    //       child: Column(
    //         crossAxisAlignment: CrossAxisAlignment.center,
    //         children: [
    //           Expanded(
    //             child: Container(
    //               decoration: BoxDecoration(
    //                 borderRadius: BorderRadius.all(Radius.circular(15)),
    //                 boxShadow: [
    //                   BoxShadow(
    //                     color: Colors.black.withOpacity(0.1),
    //                     spreadRadius: 4,
    //                     blurRadius: 5,
    //                   )
    //                 ],
    //               ),
    //               child: Image.network(
    //                 imageUrl,
    //                 width: MediaQuery.of(context).size.width * 0.2,
    //               ),
    //             ),
    //           ),
    //           SizedBox(height: 5),
    //           Text(title),
    //         ],
    //       )),
    // );
  }
}
