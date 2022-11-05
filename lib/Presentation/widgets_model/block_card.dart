import 'package:dropili/common/constant/colors.dart';
import 'package:flutter/material.dart';

class BlockCardWidget extends StatelessWidget {
  final Image blockImage;
  final String blockName;
  final bool selected;

  const BlockCardWidget(
      {super.key,
      required this.blockImage,
      required this.blockName,
      this.selected = false});

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      padding: EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: selected
            ? MalinColors.AppGreen.withAlpha(20)
            : MalinColors.greyElemntsColor,
        borderRadius: BorderRadius.circular(13),
        border:
            selected ? Border.all(color: MalinColors.AppGreen, width: 2) : null,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            decoration: BoxDecoration(
              color: Colors.transparent,
              boxShadow: [
                BoxShadow(
                  color: Color.fromARGB(20, 29, 29, 29),
                  offset: Offset(0.0, 4.0),
                  blurRadius: 10,
                  spreadRadius: 5,
                ),
              ],
            ),
            child: blockImage,
          ),
          SizedBox(
            height: 10,
          ),
          Text(
            blockName,
            style: TextStyle(
              color: Colors.black,
              fontSize: 13,
              fontWeight: FontWeight.w500,
            ),
          )
        ],
      ),
    );
  }
}
