import 'package:dropili/Presentation/Nfc/nfc_dialoge.dart';
import 'package:flutter/material.dart';

void showNfcScanner(context) {
  showModalBottomSheet(
    backgroundColor: Colors.transparent,
    enableDrag: true,
    context: context,
    builder: (context) {
      return NfcScanWidget(
        dataToTag: 'https://www.google.com',
      );
    },
  );
}
