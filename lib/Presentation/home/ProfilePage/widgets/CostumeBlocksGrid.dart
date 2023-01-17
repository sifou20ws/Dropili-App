import 'dart:developer';

import 'package:dropili/Presentation/home/ProfilePage/bloc/profileScreen_bloc.dart';
import 'package:dropili/Presentation/home/ProfilePage/widgets/user_blocks_dialogue_box.dart';
import 'package:dropili/Presentation/widgets_model/snackbar.dart';
import 'package:dropili/common/constant/colors.dart';
import 'package:dropili/common/extensions/translation_extension.dart';
import 'package:dropili/data/models/get_costume_block_response.dart';
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:url_launcher/url_launcher.dart';

class CostumeBlocksGrid extends StatelessWidget {
  final List<CustomBlocksItem> costumeBlocksList;
  const CostumeBlocksGrid({
    required this.costumeBlocksList,
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
          'Custom'.t(context),
          style: TextStyle(fontSize: 25, fontWeight: FontWeight.w600),
        ),
        SizedBox(height: 10),
        GridView.builder(
          physics: ClampingScrollPhysics(),
          shrinkWrap: true, //fix cross access count
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              crossAxisSpacing: 15,
              mainAxisSpacing: 20,
              // mainAxisExtent: 145,
              childAspectRatio: 0.78),
          itemCount: costumeBlocksList.length,
          itemBuilder: (BuildContext ctx, index) {
            return Container(
              alignment: Alignment.center,
              child: GestureDetector(
                onTap: () async {
                  if (costumeBlocksList[index].file!.fileName == '') {
                    showDialog<void>(
                      context: context,
                      barrierDismissible: false, // user must tap button!
                      builder: (_) {
                        return BlocProvider.value(
                          value: context.read<ProfileBloc>(),
                          child: UserBlocksDialogBox(
                            text: costumeBlocksList[index].url,
                            img: costumeBlocksList[index].icon!.originalUrl,
                            block: costumeBlocksList[index],
                            url: costumeBlocksList[index].url,
                            file: false,
                          ),
                        );
                      },
                    );

                  } else {
                    log(costumeBlocksList[index].file!.fileName);
                    showDialog<void>(
                      context: context,
                      barrierDismissible: false, // user must tap button!
                      builder: (_) {
                        return BlocProvider.value(
                          value: context.read<ProfileBloc>(),
                          child: UserBlocksDialogBox(
                            text: costumeBlocksList[index].file!.fileName,
                            img: costumeBlocksList[index].icon!.originalUrl,
                            block: costumeBlocksList[index],
                            url: costumeBlocksList[index].file!.fileName,
                            file: true,
                          ),
                        );
                      },
                    );
                    log(costumeBlocksList[index].file!.fileName);
                    //_launchUrl(costumeBlocksList[index].file!.originalUrl);
                  }
                },
                child: Container(
                  alignment: Alignment.center,
                  padding: EdgeInsets.all(15),
                  decoration: BoxDecoration(
                    color: MalinColors.greyElemntsColor,
                    borderRadius: BorderRadius.circular(13),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.transparent,
                          boxShadow: [
                            BoxShadow(
                              color: Color.fromARGB(50, 0, 0, 0),
                              offset: Offset(0.0, 5.0),
                              blurRadius: 10,
                              spreadRadius: 1,
                            ),
                          ],
                        ),
                        child: (costumeBlocksList[index].icon!.originalUrl ==
                                '')
                            ? ClipRRect(
                                borderRadius: BorderRadius.circular(15),
                                child:
                                    Image.asset('assets/dropili_app_logo.png'))
                            : AspectRatio(
                                aspectRatio: 1,
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(15),
                                  child: CachedNetworkImage(
                                    imageUrl: costumeBlocksList[index]
                                        .icon!
                                        .originalUrl,
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
                                ),
                              ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      FittedBox(
                        fit: BoxFit.fitWidth,
                        child: Text(
                          costumeBlocksList[index].title.ar,
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 15,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ],
    );
  }
}
