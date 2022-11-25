import 'package:dropili/Presentation/home/EditProfilePage/bloc/editProfileScreen_bloc.dart';
import 'package:dropili/Presentation/home/EditProfilePage/widgets/CustomBlocksDialogBox.dart';
import 'package:dropili/Presentation/home/EditProfilePage/widgets/CustomDialogBox.dart';
import 'package:dropili/common/constant/colors.dart';
import 'package:dropili/data/models/get_costume_block_response.dart';
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';

class CostumeBlocksGrid extends StatelessWidget {
  final List<CustomBlocksItem> costumeBlocksList;
  const CostumeBlocksGrid({
    required this.costumeBlocksList,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          'Custom Blocks',
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
            mainAxisExtent: 138,
          ),
          itemCount: costumeBlocksList.length,
          itemBuilder: (BuildContext ctx, index) {
            return Container(
              alignment: Alignment.center,
              child: GestureDetector(
                onTap: () {
                  showDialog<void>(
                    context: context,
                    barrierDismissible: false, // user must tap button!
                    builder: (_) {
                      return BlocProvider.value(
                        value: context.read<EditProfileBloc>(),
                        //child: CustomDialogBox(
                        child: CustomBlocksDialogBox(
                          id: index,
                          img: costumeBlocksList[index].icon!.originalUrl,
                          index: costumeBlocksList[index].id,
                          costumeBlocksList: costumeBlocksList,
                          url: costumeBlocksList[index].url,
                        ),
                      );
                    },
                  );
                },
                child: Container(
                  alignment: Alignment.center,
                  padding: EdgeInsets.all(15),
                  decoration: BoxDecoration(
                    color: MalinColors.AppGreen.withAlpha(20),
                    borderRadius: BorderRadius.circular(13),
                    border: Border.all(
                        color: MalinColors.AppGreen.withAlpha(100), width: 2),
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
