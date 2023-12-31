
import 'package:cached_network_image/cached_network_image.dart';
import 'package:dropili/Presentation/home/EditProfilePage/bloc/editProfileScreen_bloc.dart';
import 'package:dropili/Presentation/home/EditProfilePage/widgets/icon_container.dart';
import 'package:dropili/common/constant/colors.dart';
import 'package:dropili/data/models/get_blocks_model.dart';
import 'package:dropili/domain/repositories/profile_repository.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dropili/di/get_it.dart' as getIt;
import 'package:lottie/lottie.dart';

class DirectSurWidget extends StatefulWidget {
  final List<UserBlocksItem> userBlocks;
  final int profileUrl;

  const DirectSurWidget({
    required this.userBlocks,
    required this.profileUrl,
  });

  @override
  State<DirectSurWidget> createState() =>
      _DirectSurWidgetState(profileUrl : profileUrl);
}

class _DirectSurWidgetState extends State<DirectSurWidget> {
  int profileUrl;

  _DirectSurWidgetState({required this.profileUrl});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => EditProfileBloc(
          ProfileRepository: getIt.getItInstace<ProfileRepository>()),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 5),
        child: Container(
          height: MediaQuery.of(context).size.height * 0.5,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(25),
              topRight: Radius.circular(25),
            ),
          ),
          child: BlocListener<EditProfileBloc, EditProfileState>(
            listener: (context, state) async {
              if (state.status == Status.directOnMeSuccess) {
                profileUrl = state.profileUserUrl;
                await Future.delayed(Duration(milliseconds: 500));
                Navigator.of(context, rootNavigator: true).pop();
              }
              if (state.status == Status.directOnMeFail) {
                //await Future.delayed(Duration(milliseconds:500 ));
                Navigator.of(context, rootNavigator: true).pop();
              }
            },
            child: BlocBuilder<EditProfileBloc, EditProfileState>(
                builder: (context, state) {
              return SingleChildScrollView(
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(10),
                          child: GestureDetector(
                            onTap: () {
                              Navigator.pop(context);
                            },
                            child: Container(
                              height: 30,
                              width: 30,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(50),
                                //color: Colors.black12,
                              ),
                              // child: Icon(
                              //   CupertinoIcons.xmark_circle,
                              //   size: 30,
                              // ),
                              child: IconContainer(
                                icon: Icon(
                                  CupertinoIcons.xmark,
                                  size: 20,
                                  color: MalinColors.AppBlue,
                                ),
                                outline: false,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    DialogeGrid(
                      userBlocks: widget.userBlocks,
                      profileUrl: profileUrl,
                    ),
                  ],
                ),
              );
            }),
          ),
        ),
      ),
    );
  }
}

class DialogeGrid extends StatelessWidget {
  final List<UserBlocksItem> userBlocks;
  final int profileUrl;
  const DialogeGrid({
    required this.userBlocks,
    required this.profileUrl,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 15, horizontal: 50),
      child: GridView.builder(
        physics: ClampingScrollPhysics(),
        shrinkWrap: true, //fix cross access count
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 4,
          crossAxisSpacing: 15,
          mainAxisSpacing: 10,
          mainAxisExtent: 60,
        ),
        itemCount: userBlocks.length,
        itemBuilder: (BuildContext ctx, index) {
          return Container(
            alignment: Alignment.center,
            child: GestureDetector(
              onTap: () {
                BlocProvider.of<EditProfileBloc>(context).add(
                  DirectOnMeEvent(
                    direct: '1',
                    url: userBlocks[index].pivot.url,
                    block_id: userBlocks[index].id.toString(),
                  ),
                );
              },
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(13),
                  border: userBlocks[index].id == profileUrl
                      ? Border.all(
                          color: MalinColors.AppGreen.withAlpha(100), width: 2)
                      : null,
                ),
                child: Padding(
                  padding: EdgeInsets.all(2),
                  //child: Image.network(userBlocks[index].icon.originalUrl),
                  child: CachedNetworkImage(
                    imageUrl: userBlocks[index].icon.originalUrl,
                    placeholder: (context, url) => Center(
                        child: Center(
                      child: Lottie.asset(
                        'assets/lottie/loading-green.json',
                        height: 80,
                      ),
                    )),
                    errorWidget: (context, url, error) => Icon(Icons.error),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
