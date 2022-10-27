import 'package:dropili/common/extensions/translation_extension.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class NfcTagFoundWidget extends StatelessWidget {
  const NfcTagFoundWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Text(
          'Scan Dropili tag'.t(context),
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: 23,
          ),
        ),
        Lottie.asset('assets/lottie/nfc-success.json',
            height: 240, repeat: false),
        Text(
          'Tag found'.t(context),
          style: TextStyle(
            color: Color.fromARGB(255, 61, 199, 114),
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
