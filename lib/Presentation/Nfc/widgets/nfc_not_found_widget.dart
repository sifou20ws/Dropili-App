import 'package:dropili/common/extensions/translation_extension.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class NoNfcFoundWidget extends StatelessWidget {
  const NoNfcFoundWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Text(
          'Activate Dropili tag'.t(context),
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: 23,
          ),
        ),
        Lottie.asset('assets/lottie/error.json', height: 240, repeat: false),
        Text(
          'No Nfc found'.t(context),
          style: TextStyle(
            color: Colors.red,
            fontWeight: FontWeight.w600,
            fontSize: 21,
          ),
        ),
        SizedBox(
          height: 10,
        ),
        // state is NfcSearchingState
        Text(
          'nfc not found text'.t(context),
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Colors.grey,
            fontWeight: FontWeight.w400,
            fontSize: 14,
          ),
        )
      ],
    );
  }
}
