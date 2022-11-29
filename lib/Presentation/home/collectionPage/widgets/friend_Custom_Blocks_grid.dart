import 'package:dropili/Presentation/widgets_model/snackbar.dart';
import 'package:dropili/common/constant/colors.dart';
import 'package:dropili/common/extensions/translation_extension.dart';
import 'package:dropili/data/models/get_blocks_model.dart';
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/services.dart';
import 'package:lottie/lottie.dart';

class FriendCostumeBlocksGrid extends StatelessWidget {
  final List<UserBlocksItem> costumeBlocksList;
  const FriendCostumeBlocksGrid({
    required this.costumeBlocksList,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          'Custom Blocks'.t(context),
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
            // mainAxisExtent: 138,
            childAspectRatio: 0.78,
          ),
          itemCount: costumeBlocksList.length,
          itemBuilder: (BuildContext ctx, index) {
            return Container(
              alignment: Alignment.center,
              child: GestureDetector(
                onTap: () async {
                  await Clipboard.setData(
                      ClipboardData(text: costumeBlocksList[index].pivot.url));
                  String url = costumeBlocksList[index].pivot.url;
                  SnackBars.showSucessSnackBar(
                      context, '"$url" copied to clipboard');
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
                        child: (costumeBlocksList[index].icon.originalUrl == '')
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
                                        .icon
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
