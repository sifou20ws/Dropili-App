import 'package:dropili/common/extensions/translation_extension.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class NfcTagErrorWidget extends StatelessWidget {
  const NfcTagErrorWidget({super.key});

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
        Lottie.asset('assets/lottie/nfc-fail.json', height: 240, repeat: false),
        Text(
          'Wrong tag'.t(context),
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
          'nfc looking text'.t(context),
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
