import 'dart:developer';

import 'package:dropili/Presentation/home/qr_page/copy_field_widget.dart';
import 'package:dropili/Presentation/home/qr_page/share_button_widget.dart';
import 'package:dropili/Presentation/widgets_model/snackbar.dart';
import 'package:dropili/common/constant/colors.dart';
import 'package:dropili/common/extensions/translation_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_share/flutter_share.dart';
import 'package:qr_flutter/qr_flutter.dart';

class QrPage extends StatefulWidget {
  const QrPage({super.key});

  @override
  State<QrPage> createState() => _QrPageState();
}

class _QrPageState extends State<QrPage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 30),
      width: MediaQuery.of(context).size.width,
      child: Column(
        // mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'Sharing Dropili Profile'.t(context),
            style: TextStyle(
              fontSize: 25,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(
            height: 30,
          ),
          Container(
            padding: EdgeInsets.all(8),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  // color: Color.fromARGB(10, 29, 29, 29),
                  color: MalinColors.AppGreen.withAlpha(80),
                  offset: Offset(0.0, 2.0),
                  blurRadius: 10,
                ),
              ],
            ),
            child: QrImage(
              data: 'https://www.google.com',
              size: MediaQuery.of(context).size.width * 0.6,
              version: QrVersions.auto,
              // embeddedImage: AssetImage('assets/dropili_Logo_PNG.png'),
              // gapless: false,
            ),
          ),
          SizedBox(
            height: 30,
          ),
          Text(
            'Tap to save QR Code to photos'.t(context),
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
          ),
          SizedBox(
            height: 30,
          ),
          GestureDetector(
              onTap: () async {
                await Clipboard.setData(ClipboardData(text: 'www.google.com'));
                SnackBars.showSucessSnackBar(
                    context, 'Profile link copied to clipboard'.t(context));
              },
              child: CopyLinkWidget()),
          SizedBox(
            height: 30,
          ),
          GestureDetector(
            onTap: (() async {
              log('someth');
              await FlutterShare.share(
                title: 'Dropili profile',
                text: 'Abdenourgnx Profile',
                linkUrl: 'dorpili.co/link/abdenourgnx',
              );
              // Share.share('www.profile.com');
              // await Share.share('somethins', subject: 'somethins');
            }),
            child: ShareButton(),
          ),
        ],
      ),
    );
  }
}
