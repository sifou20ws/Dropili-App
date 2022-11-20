import 'package:dropili/Presentation/home/EditProfilePage/bloc/editProfileScreen_bloc.dart';
import 'package:dropili/Presentation/home/EditProfilePage/widgets/CustomDialogBox.dart';
import 'package:dropili/Presentation/home/EditProfilePage/widgets/eprofile_card_widget.dart';
import 'package:dropili/data/models/get_blocks_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:lottie/lottie.dart';

class Grid extends StatelessWidget {
  final String title;
  final List<BlocksItem> blocksList;
  final List<UserBlocksItem> userBlocks;
  final int type;
  const Grid({
    required this.title,
    required this.blocksList,
    required this.type,
    required this.userBlocks,
  });

  String blockExist(int id) {
    String ret = '';
    userBlocks.forEach((element) {
      if (element.id == id) ret = element.pivot.url;
    });
    return ret;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          title,
          style: TextStyle(fontSize: 30, fontWeight: FontWeight.w600),
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
          itemCount: blocksList.length,
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
                        child: CustomDialogBox(
                          index: blocksList[index].id,
                          img: blocksList[index].icon.originalUrl,
                          editText: blocksList[index].hint.fr,
                          blocksList: blocksList,
                          url: blockExist(blocksList[index].id),
                        ),
                      );
                    },
                  );
                },
                child: BlockCardWidget(
                  //blockImage: Image.network(blocksList[index].icon.originalUrl),
                  blockImage: CachedNetworkImage(
                    imageUrl: blocksList[index].icon.originalUrl,
                    placeholder: (context, url) => Center(
                        child: Center(
                          child: Lottie.asset(
                            'assets/lottie/loading.json',
                            height: 80,
                          ),
                        )),
                    errorWidget: (context, url, error) =>
                        Icon(Icons.error),
                    fit: BoxFit.cover,
                  ),
                  title: blocksList[index].title.ar,
                  id: blocksList[index].id,
                  userBlocks: userBlocks,
                ),
              ),
            );
          },
        ),
      ],
    );
  }
}
