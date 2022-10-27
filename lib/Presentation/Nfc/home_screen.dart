import 'dart:developer';

import 'package:dropili/Presentation/Nfc/widgets/nfc_dialoge.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: ElevatedButton(
          child: Text('Open NFC'),
          onPressed: (() {
            showModalBottomSheet(
              backgroundColor: Colors.transparent,
              enableDrag: true,
              context: context,
              builder: (context) {
                return NfcScanWidget();
              },
            );
          }),
        ),
      ),
    );
  }
}
