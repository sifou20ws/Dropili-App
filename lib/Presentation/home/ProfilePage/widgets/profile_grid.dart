import 'dart:developer';

import 'package:dropili/Presentation/home/ProfilePage/widgets/block_card.dart';
import 'package:dropili/Presentation/home/ProfilePage/widgets/profile_dialogue_box.dart';
import 'package:dropili/Presentation/widgets_model/cachedImage_widget.dart';
import 'package:dropili/Presentation/widgets_model/snackbar.dart';
import 'package:dropili/data/models/get_blocks_model.dart';
import 'package:dropili/data/models/url_prefix_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:url_launcher/url_launcher.dart';

class BlockTypeGrid extends StatelessWidget {
  final String title;
  final List<UserBlocksItem> blocksList;
  const BlockTypeGrid({
    required this.title,
    required this.blocksList,
  });

  Future<void> _launchUrl(String url) async {
    final Uri _url = Uri.parse(url);

    if (!await launchUrl(_url, mode: LaunchMode.externalApplication))
      log('could not launch your url');
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          title,
          style: TextStyle(fontSize: 25, fontWeight: FontWeight.w600),
        ),
        SizedBox(height: 10),
        GridView.builder(
          physics: ClampingScrollPhysics(),
          shrinkWrap: true,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            crossAxisSpacing: 15,
            mainAxisSpacing: 20,
            // mainAxisExtent: 150,
            childAspectRatio: 0.78,
          ),
          itemCount: blocksList.length,
          itemBuilder: (BuildContext ctx, index) {
            return GestureDetector(
              onTap: () async {
                if (blocksList[index].urlPrefix != 'null') {
                  String furl = URLPrefixModel.prefix[blocksList[index].id]!;
                  log(furl + blocksList[index].pivot.url.replaceAll(' ', ''));
                  _launchUrl('$furl' +
                      blocksList[index].pivot.url.replaceAll(' ', ''));
                } else {
                  await Clipboard.setData(
                      ClipboardData(text: blocksList[index].pivot.url));
                  String url = blocksList[index].pivot.url;
                  SnackBars.showSucessSnackBar(
                      context, '\"$url\" copied to clipboard');
                }
              },
              child: BlockCardWidget(
                  blockImageUrl: blocksList[index].icon.originalUrl,
                  blockName: blocksList[index].title.ar),
            );
          },
        ),
      ],
    );
  }
}
