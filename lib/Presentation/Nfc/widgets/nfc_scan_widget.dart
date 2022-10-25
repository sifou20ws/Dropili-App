import 'package:dropili/common/extensions/translation_extension.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class NfcScanWidget extends StatefulWidget {
  const NfcScanWidget({super.key});

  @override
  State<NfcScanWidget> createState() => _NfcScanWidgetState();
}

class _NfcScanWidgetState extends State<NfcScanWidget> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 5),
      child: Container(
        padding: EdgeInsets.only(
          top: 30,
          right: 30,
          left: 30,
        ),
        height: 420,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(25),
            topRight: Radius.circular(25),
          ),
        ),
        child: Column(
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
            Lottie.asset('assets/lottie/nfc.json', height: 240),
            Text(
              'Still looking'.t(context) + '...',
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.w600,
                fontSize: 21,
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              'nfc looking text'.t(context),
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.grey,
                fontWeight: FontWeight.w400,
                fontSize: 14,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
