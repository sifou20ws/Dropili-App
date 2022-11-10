import 'dart:developer';

import 'package:dropili/Presentation/widgets_model/snackbar.dart';
import 'package:dropili/data/models/url_prefix_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:url_launcher/url_launcher.dart';

class ProfileDialogBox extends StatelessWidget {
  //final String editText;
  final String url;
  final Image iconImage;
  final int blockId;

  const ProfileDialogBox({
    required this.blockId,
    required this.url,
    required this.iconImage,
  });

  Future<void> _launchUrl(String url) async {
    final Uri _url = Uri.parse(url);

    if (!await launchUrl(_url, mode: LaunchMode.externalApplication))
      log(
        'could not launch your url',
      );
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        backgroundColor: Colors.transparent,
        child: Stack(
          children: <Widget>[
            Container(
              padding:
                  EdgeInsets.only(left: 10, top: 50, right: 10, bottom: 10),
              margin: EdgeInsets.only(top: 40),
              decoration: BoxDecoration(
                shape: BoxShape.rectangle,
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(top: 20, right: 5, left: 5),
                    child: GestureDetector(
                      onTap: () async {
                        await Clipboard.setData(ClipboardData(text: url));
                        SnackBars.showSucessSnackBar(
                            context, 'Profile link copied to clipboard');
                      },
                      child: copy_filed_widget(
                        url: url,
                      ),
                    ),
                  ),
                  SizedBox(height: 5),
                  (URLPrefixModel.prefix[blockId] != null)
                      ? Container(
                          child: TextButton(
                              onPressed: () {
                                String furl = URLPrefixModel.prefix[blockId]!;
                                log(furl + url.replaceAll(' ', ''));
                                _launchUrl('$furl' + url.replaceAll(' ', ''));
                              },
                              child: Text('Redirect to link')),
                        )
                      : SizedBox(height: 20),
                ],
              ),
            ),
            Positioned(
              left: 20,
              right: 20,
              child: Container(
                width: 80,
                height: 80,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  color: Colors.transparent,
                ),
                child: iconImage,
              ),
            ),
            Positioned(
              right: 5,
              top: 5,
              child: GestureDetector(
                onTap: () {
                  Navigator.of(context).pop(false);
                },
                child: Container(
                  margin: EdgeInsets.only(top: 40),
                  width: 30,
                  height: 30,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(50),
                    color: Colors.black12,
                  ),
                  child: Icon(
                    Icons.close_rounded,
                    color: Colors.black,
                  ),
                ),
              ),
            )
          ],
        ));
  }
}

class copy_filed_widget extends StatelessWidget {
  const copy_filed_widget({required this.url});

  final String url;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.8,
      decoration: BoxDecoration(
        color: Colors.grey.shade200,
        border: Border.all(width: 0.5, color: Colors.grey.shade400),
        borderRadius: new BorderRadius.circular(15.0),
      ),
      child: Padding(
        padding: EdgeInsets.only(left: 20, right: 15, top: 15, bottom: 15),
        child:
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          Text(
            url,
            style: TextStyle(fontSize: 17, fontWeight: FontWeight.w400),
          ),
          Icon(Icons.copy_outlined),
        ]),
      ),
    );
  }
}
