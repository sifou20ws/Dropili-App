import 'package:dropili/common/constant/colors.dart';
import 'package:flutter/material.dart';


class AddCustomBlockButton extends StatelessWidget {
  const AddCustomBlockButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      padding: EdgeInsets.all(15),
      decoration: BoxDecoration(
        // color: MalinColors.AppGreen.withAlpha(20),
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
                  color: Color.fromARGB(50, 0, 0, 0).withAlpha(20),
                  offset: Offset(0.0, 5.0),
                  blurRadius: 10,
                  spreadRadius: 1,
                ),
              ],
            ),
            child: Image.asset('assets/add.png'),
          ),
          SizedBox(
            height: 10,
          ),
          FittedBox(
            fit: BoxFit.fitWidth,
            child: Text(
              'Add',
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
  }
}