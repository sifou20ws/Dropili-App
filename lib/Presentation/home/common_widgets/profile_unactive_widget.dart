import 'package:dropili/common/extensions/translation_extension.dart';
import 'package:flutter/material.dart';

class ProfileUnactiveWidget extends StatelessWidget {
  const ProfileUnactiveWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height,
      alignment: Alignment.center,
      child: Center(
          child: Column(
        children: [
          SizedBox(
            height: 50,
          ),
          Icon(
            Icons.no_accounts_outlined,
            size: 90,
            color: Colors.grey.shade600,
            // color: Colors.red,
          ),
          SizedBox(
            height: 10,
          ),
          Text(
            'Profile not active'.t(context),
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w400,
              color: Colors.grey.shade600,
            ),
          ),
        ],
      )),
    );
  }
}
