import 'package:dropili/common/constant/colors.dart';
import 'package:flutter/material.dart';

class BlockCardWidget extends StatelessWidget {
  final Image blockImage;
  final String blockName;

  const BlockCardWidget({
    super.key,
    required this.blockImage,
    required this.blockName,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      padding: EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: MalinColors.greyElemntsColor,
        borderRadius: BorderRadius.circular(13),
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
            height: 10,
          ),
          Text(
            blockName,
            style: TextStyle(
              color: Colors.black,
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
          )
        ],
      ),
    );
  }
}
