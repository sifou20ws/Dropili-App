import 'package:dropili/common/extensions/translation_extension.dart';
import 'package:flutter/material.dart';

class NoConnectionDialogue extends StatelessWidget {
  const NoConnectionDialogue({super.key});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      backgroundColor: Colors.transparent,
      elevation: 10,
      child: Container(
        height: 320,
        padding: EdgeInsets.only(top: 30),
        // alignment: Alignment.center,
        decoration: BoxDecoration(
          // shape: BoxShape.rectangle,
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image(
              image: AssetImage('assets/no-connection.jpg'),
              width: 120,
            ),
            SizedBox(height: 25),
            Text(
              'Whoops'.t(context),
              style: TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.w600,
                color: Colors.red,
              ),
            ),
            SizedBox(height: 10),
            Text(
              'No internet connection'.t(context),
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w400,
                color: Colors.grey,
              ),
            ),
            SizedBox(height: 30),
            GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
              child: Container(
                alignment: Alignment.center,
                height: 40,
                width: 130,
                decoration: BoxDecoration(
                  color: Colors.red,
                  // color: Colors.white,
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
                child: Text(
                  'Retry'.t(context),
                  style: TextStyle(
                      // color: MalinColors.AppGreen,
                      color: Colors.white,
                      fontSize: 15,
                      fontWeight: FontWeight.w500),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
