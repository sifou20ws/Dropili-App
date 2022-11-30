import 'dart:developer';
import 'dart:io';
import 'dart:ui' as ui;

import 'package:dropili/Presentation/home/ProfilePage/bloc/profileScreen_bloc.dart';
import 'package:dropili/Presentation/home/qr_page/copy_field_widget.dart';
import 'package:dropili/Presentation/home/qr_page/share_button_widget.dart';
import 'package:dropili/Presentation/widgets_model/snackbar.dart';
import 'package:dropili/common/constant/colors.dart';
import 'package:dropili/common/extensions/translation_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_share/flutter_share.dart';
import 'package:gallery_saver/gallery_saver.dart';
import 'package:http/http.dart';
import 'package:path_provider/path_provider.dart';
import 'package:qr_flutter/qr_flutter.dart';

class QrPage extends StatefulWidget {
  const QrPage({super.key});

  @override
  State<QrPage> createState() => _QrPageState();
}

class _QrPageState extends State<QrPage> {
  Future<bool?> _saveQrToGallery(data) async {
    final painter = QrPainter(
      data: data,
      version: QrVersions.auto,
      // color: Colors.white,
      gapless: true,
      emptyColor: Colors.white,
    );

    Directory tempDir = await getTemporaryDirectory();
    String tempPath = tempDir.path;
    final ts = 'Dropili';
    String path = '$tempPath/$ts.png';
    var picData =
        await painter.toImageData(2048, format: ui.ImageByteFormat.png);
    await writeToFile(picData!, path);

    final success = await GallerySaver.saveImage(path);
    return success;
  }

  Future<void> writeToFile(ByteData data, String path) async {
    final buffer = data.buffer;
    await File(path).writeAsBytes(
        buffer.asUint8List(data.offsetInBytes, data.lengthInBytes));
  }

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
          GestureDetector(
            onTap: () async {
              try {
                bool? saved =
                    await _saveQrToGallery('dropili.co/link/abdenourgnx');
                if (saved == null || saved == false) {
                  SnackBars.showErrorSnackBar(
                      context, 'Error in saving image'.t(context));
                } else if (saved) {
                  SnackBars.showSucessSnackBar(
                      context, 'Image saved succesfully'.t(context));
                }
              } catch (e) {
                SnackBars.showErrorSnackBar(
                    context, 'Error in saving image'.t(context));
              }
            },
            child: Container(
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
                    // spreadRadius: 5,
                  ),
                ],
              ),
              child: QrImage(
                data: 'Dropili.co/link/' +
                    context
                        .read<ProfileBloc>()
                        .state
                        .showProfile!
                        .user
                        .username,
                size: MediaQuery.of(context).size.width * 0.6,
                version: QrVersions.auto,
                embeddedImage: AssetImage('assets/dropili_rounded_black.png'),
                embeddedImageStyle: QrEmbeddedImageStyle(
                  size: Size(
                    30,
                    30,
                  ),
                ),

                // gapless: false,
              ),
            ),
          ),
          SizedBox(
            height: 30,
          ),
          Text(
            'Tap to save'.t(context),
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
          ),
          SizedBox(
            height: 30,
          ),
          GestureDetector(
              onTap: () async {
                await Clipboard.setData(
                  ClipboardData(
                      text: 'Dropili.co/link/' +
                          context
                              .read<ProfileBloc>()
                              .state
                              .showProfile!
                              .user
                              .username),
                );
                SnackBars.showSucessSnackBar(
                    context, 'Profile link copied to clipboard'.t(context));
              },
              child: CopyLinkWidget()),
          SizedBox(
            height: 30,
          ),
          GestureDetector(
            onTap: (() async {
              await FlutterShare.share(
                title: 'Dropili profile',
                text: context.read<ProfileBloc>().state.showProfile!.user.name +
                    ' Profile',
                linkUrl: 'dorpili.co/link/' +
                    context
                        .read<ProfileBloc>()
                        .state
                        .showProfile!
                        .user
                        .username,
              );
            }),
            child: ShareButton(),
          ),
        ],
      ),
    );
  }
}
