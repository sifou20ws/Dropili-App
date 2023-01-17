import 'dart:developer';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:dropili/Presentation/authentification/comun_widgets/message_widget.dart';
import 'package:dropili/Presentation/home/EditProfilePage/bloc/editProfileScreen_bloc.dart';
import 'package:dropili/Presentation/home/ProfilePage/bloc/profileScreen_bloc.dart';
import 'package:dropili/Presentation/widgets_model/snackbar.dart';
import 'package:dropili/common/constant/colors.dart';
import 'package:dropili/common/extensions/translation_extension.dart';
import 'package:dropili/data/models/get_blocks_model.dart';
import 'package:dropili/data/models/get_costume_block_response.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:url_launcher/url_launcher.dart';

class UserBlocksDialogBox extends StatefulWidget {
  final String text, url;
  final String img;
  final CustomBlocksItem block;
  final bool file;
  const UserBlocksDialogBox({
    required this.text,
    required this.img,
    required this.block,
    required this.url,
    required this.file,
  });

  @override
  _UserBlocksDialogBoxState createState() => _UserBlocksDialogBoxState();
}

class _UserBlocksDialogBoxState extends State<UserBlocksDialogBox> {
  @override
  Widget build(BuildContext context) {
    Future<void> _launchUrl(String url) async {
      final Uri _url = Uri.parse(url);

      if (!await launchUrl(_url, mode: LaunchMode.externalApplication))
        log('could not launch your url');
    }

    return BlocListener<ProfileBloc, ProfileState>(
      listener: (context, state) async {},
      child: BlocBuilder<ProfileBloc, ProfileState>(
        builder: (context, state) {
          return Dialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            backgroundColor: Colors.transparent,
            child: Stack(
              children: <Widget>[
                Container(
                  padding:
                      EdgeInsets.only(left: 10, top: 50, right: 10, bottom: 0),
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
                        padding:
                            const EdgeInsets.only(top: 20, right: 5, left: 5),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            state.linkCopied
                                ? Padding(
                                    padding: const EdgeInsets.only(bottom: 5),
                                    child: MessageWidget(
                                      color: 'green',
                                      text: 'Link copied to clipboard',
                                    ),
                                  )
                                : Container(),
                            GestureDetector(
                              onTap: () async {
                                if (widget.file) {
                                  _launchUrl(widget.block.file!.originalUrl);
                                } else {
                                  await Clipboard.setData(
                                      ClipboardData(text: widget.block.url));
                                  BlocProvider.of<ProfileBloc>(context)
                                      .add(LinkCopiedEvent(copy: true));
                                }
                              },
                              child: Container(
                                width: MediaQuery.of(context).size.width * 0.8,
                                decoration: BoxDecoration(
                                  color: Colors.grey.shade200,
                                  border: Border.all(
                                      width: 0.5, color: Colors.grey.shade400),
                                  borderRadius: new BorderRadius.circular(15.0),
                                ),
                                child: Padding(
                                  padding: EdgeInsets.only(
                                      left: 20, right: 15, top: 10, bottom: 10),
                                  child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Expanded(
                                          child: SingleChildScrollView(
                                            scrollDirection: Axis.horizontal,
                                            child: Text(
                                              widget.url,
                                              style: TextStyle(
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.w400),
                                            ),
                                          ),
                                        ),
                                        SizedBox(
                                          width: 10,
                                        ),
                                        !widget.file ? Icon(Icons.copy_outlined) : Icon() ,
                                      ]),
                                ),
                              ),
                            ),
                            // Padding(
                            //   padding: const EdgeInsets.only(left: 10),
                            //   child: Text(
                            //     widget.file
                            //         ? 'Tap to download the file'
                            //         : 'Tap to copy the link',
                            //     style: TextStyle(
                            //       fontSize: 16,
                            //       fontWeight: FontWeight.w400,
                            //     ),
                            //   ),
                            // ),
                          ],
                        ),
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: TextButton(
                              onPressed: () {
                                BlocProvider.of<ProfileBloc>(context)
                                    .add(LinkCopiedEvent());
                                Navigator.of(context).pop(false);
                              },
                              child: Text('Back'.t(context)),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: 80,
                      height: 80,
                      decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                            color: Color.fromARGB(50, 0, 0, 0),
                            offset: Offset(0.0, 5.0),
                            blurRadius: 10,
                            spreadRadius: 1,
                          ),
                        ],
                      ),
                      child: (widget.block.icon!.originalUrl != '')
                          ? ClipRRect(
                              borderRadius: BorderRadius.circular(15),
                              child: CachedNetworkImage(
                                imageUrl: widget.block.icon!.originalUrl,
                                placeholder: (context, url) => Center(
                                    child: Center(
                                  child: Lottie.asset(
                                    'assets/lottie/loading-green.json',
                                    height: 80,
                                  ),
                                )),
                                errorWidget: (context, url, error) =>
                                    Icon(Icons.error),
                                fit: BoxFit.cover,
                              ),
                            )
                          : ClipRRect(
                              borderRadius: BorderRadius.circular(15),
                              child:
                                  Image.asset('assets/dropili_app_logo.png')),
                    ),
                  ],
                ),
              ],
            ),
          );
        },
      ),
    );
  }

}
