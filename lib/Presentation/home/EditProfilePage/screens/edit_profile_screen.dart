import 'dart:developer';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:dropili/Presentation/home/EditProfilePage/bloc/editProfileScreen_bloc.dart';
import 'package:dropili/Presentation/home/EditProfilePage/widgets/add_C_block_widget.dart';
import 'package:dropili/Presentation/home/EditProfilePage/widgets/costume_block_widget.dart';
import 'package:dropili/Presentation/home/EditProfilePage/widgets/direct_sur_dialoge.dart';
import 'package:dropili/Presentation/home/EditProfilePage/widgets/eProfile_buttons_row.dart';
import 'package:dropili/Presentation/home/EditProfilePage/widgets/eprofile_card_widget.dart';
import 'package:dropili/Presentation/home/EditProfilePage/widgets/eprofile_media_widget.dart';
import 'package:dropili/Presentation/home/EditProfilePage/widgets/eprofile_text_widget.dart';
import 'package:dropili/Presentation/widgets_model/snackbar.dart';
import 'package:dropili/common/constant/colors.dart';
import 'package:dropili/common/extensions/translation_extension.dart';
import 'package:dropili/data/models/get_blocks_model.dart';
import 'package:dropili/domain/repositories/profile_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dropili/Presentation/home/EditProfilePage/widgets/eprofile_grid.dart';
import 'package:dropili/di/get_it.dart' as getIt;
import 'package:lottie/lottie.dart';

class EditProfilePage extends StatefulWidget {
  const EditProfilePage({Key? key}) : super(key: key);

  @override
  State<EditProfilePage> createState() => _MyOffersPageState();
}

class _MyOffersPageState extends State<EditProfilePage> {
  late EditProfileBloc _editProfileBloc;
  List<BlocksItem> blocks = [];
  List<List<BlocksItem>> blocksList = [];
  List<UserBlocksItem> userBlocks = [];
  String name = '', description = '', profileUserUrl = '';
  int blockId = 0;
  String getProfilePicture = '', getBackgroundPicture = '';
  @override
  void initState() {
    super.initState();
    _editProfileBloc = EditProfileBloc(
        ProfileRepository: getIt.getItInstace<ProfileRepository>());
    _editProfileBloc.add(GetProfileEvent());
    _editProfileBloc.add(GetBlocksEvent());
    _editProfileBloc.add(GetCostumeBlocksEvent());
  }

  @override
  void dispose() {
    _editProfileBloc.close();
    super.dispose();
  }

  bool selected = false;
  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: _editProfileBloc,
      child: BlocListener<EditProfileBloc, EditProfileState>(
        listener: (context, state) async {
          if (state.status == Status.getBlocksSuccess) {
            blocks = state.blocks;
            userBlocks = state.userBlocks;
            blocksList = state.blocksList;
          }
          if (state.status == Status.getProfileSuccess) {
            name = state.showProfile!.user.name;
            description = state.showProfile!.user.description;
            profileUserUrl = state.showProfile!.user.url;
            blockId = state.showProfile!.user.blockId;
            getProfilePicture = BlocProvider.of<EditProfileBloc>(context)
                .state
                .showProfile!
                .user
                .userProfile
                .originalUrl;
            getBackgroundPicture = BlocProvider.of<EditProfileBloc>(context)
                .state
                .showProfile!
                .user
                .userBackground
                .originalUrl;
            _editProfileBloc.add(PostUserNameEvent(name: name));
            _editProfileBloc
                .add(PostDescriptionEvent(description: description));
          }
          if (state.status == Status.postBlockSuccess) {
            _editProfileBloc.add(GetBlocksEvent());
            userBlocks = state.userBlocks;
          }
          if (state.status == Status.deleteSuccess) {
            _editProfileBloc.add(GetBlocksEvent());
            userBlocks = state.userBlocks;
          }
          if (state.status == Status.postCostumeBlocksSuccess) {
            _editProfileBloc.add(GetCostumeBlocksEvent());
          }
          if (state.status == Status.deleteCostumeBlocksSuccess) {
            _editProfileBloc.add(GetCostumeBlocksEvent());
          }
          if (state.openDirectMeDialogue) {
            state.openDirectMeDialogue = false;
            showModalBottomSheet(
              isScrollControlled: true,
              backgroundColor: Colors.transparent,
              context: context,
              builder: (context) {
                return DirectSurWidget(
                  userBlocks: state.userBlocks,
                  profileUrl: profileUserUrl,
                );
              },
            ).then((value) {
              _editProfileBloc.add(GetProfileEvent());
            });
          } else if (state.status == Status.profileUpdateSucess) {
            SnackBars.showSucessSnackBar(context, state.messageError);
            await Future.delayed(Duration(milliseconds: 500));
            Navigator.pop(context);
          }
          if (state.status == Status.profileUpdateFail) {
            SnackBars.showErrorSnackBar(context, state.messageError);
          }
          if (state.status == Status.fail) {
            SnackBars.showErrorSnackBar(context, state.messageError);
          } else if (state.status == Status.success) {
            SnackBars.showSucessSnackBar(context, state.messageError);
          }
        },
        child: BlocBuilder<EditProfileBloc, EditProfileState>(
          builder: (context, state) {
            return SafeArea(
              child: Scaffold(
                backgroundColor: Colors.white,
                resizeToAvoidBottomInset: true,
                //state.status == Status.loadingBlocks ||
                //state.status == Status.loadingProfile ||
                //state.status == Status.getCostumeBlocks
                body: (state.blocksStatus == BlocksStatus.getBlocks ||
                        state.status == Status.loadingProfile ||
                        state.costumeBlocksStatus ==
                            CostumeBlocksStatus.getCostumeBlocks)
                    ? Center(
                        child: Lottie.asset(
                          'assets/lottie/loading-green.json',
                          height: 100,
                          frameRate: FrameRate(120),
                        ),
                      )
                    : Container(
                        height: MediaQuery.of(context).size.height,
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            fit: BoxFit.fill,
                            image: AssetImage(
                              'assets/background2.png',
                            ),
                            alignment: Alignment.topCenter,
                          ),
                        ),
                        child: Stack(
                          children: <Widget>[
                            SingleChildScrollView(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  EditProfileMediaWidget(
                                    getProfilePicture: getProfilePicture,
                                    getBackgroundPicture: getBackgroundPicture,
                                  ),
                                  Container(
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                    ),
                                    child: Padding(
                                      padding: EdgeInsets.only(
                                          left: 20, right: 20, bottom: 50),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: <Widget>[
                                          EditProfileTextWidget(
                                            name: name,
                                            description: description,
                                          ),
                                          SizedBox(height: 15),
                                          EditProfileButtonsWidget(),
                                          SizedBox(height: 15),
                                          ListView.separated(
                                            physics:
                                                NeverScrollableScrollPhysics(),
                                            shrinkWrap: true,
                                            itemCount: state.blocksList.length,
                                            itemBuilder: (context, index) {
                                              var title = '';
                                              switch (state
                                                  .blocksList[index][0].type) {
                                                case 1:
                                                  title = 'Contacts'.t(context);
                                                  break;
                                                case 2:
                                                  title =
                                                      'Social Media'.t(context);
                                                  break;
                                                case 3:
                                                  title = 'Payment methods'
                                                      .t(context);
                                                  break;
                                                case 4:
                                                  title = 'Divers'.t(context);
                                                  break;
                                                default:
                                              }
                                              return Grid(
                                                userBlocks: userBlocks,
                                                type: 4,
                                                title: title,
                                                blocksList:
                                                    state.blocksList[index],
                                              );
                                            },
                                            separatorBuilder:
                                                (context, index) => SizedBox(
                                              height: 25,
                                            ),
                                          ),
                                          SizedBox(height: 15),
                                          (state.costumeBlocks.length != 0)
                                              ? CostumeBlocksGrid(
                                                  costumeBlocksList:
                                                      state.costumeBlocks,
                                                )
                                              : Container(),
                                          SizedBox(height: 15),
                                          (state.costumeBlocks.length == 0)
                                              ? Column(
                                                  children: [
                                                    Text(
                                                      'Custom Blocks',
                                                      style: TextStyle(
                                                          fontSize: 30,
                                                          fontWeight:
                                                              FontWeight.w600),
                                                    ),
                                                    SizedBox(height: 15),
                                                  ],
                                                )
                                              : Container(),
                                          AddCostumeBlocksIcon(
                                            imagePath:
                                                state.addCostumeBlockImgPath,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                bottomNavigationBar: Container(
                  padding:
                      EdgeInsets.only(top: 13, bottom: 13, left: 10, right: 10),
                  width: MediaQuery.of(context).size.width,
                  height: 72,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.3),
                        spreadRadius: 3,
                        blurRadius: 4,
                        offset: Offset(0, -1),
                      )
                    ],
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      GestureDetector(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: ButtomBtn(
                          text: 'Back'.t(context),
                          save: false,
                        ),
                      ),
                      GestureDetector(
                        onTap: () async {
                          _editProfileBloc.add(PostProfileUpdateEvent(
                            name: state.userName,
                            description: state.userDescription,
                            profile: state.profileImg,
                            background: state.backgroundImg,
                          ));
                        },
                        child: (state.status != Status.loadingProfileUpdate)
                            ? ButtomBtn(text: 'Save'.t(context))
                            : Container(
                                decoration: BoxDecoration(
                                  color: Colors.grey.withOpacity(0.1),
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                width: MediaQuery.of(context).size.width * 0.40,
                                child: Center(
                                  child: Lottie.asset(
                                    'assets/lottie/loading-green.json',
                                    height: 60,
                                  ),
                                ),
                              ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

class ButtomBtn extends StatelessWidget {
  final String text;
  final bool save;
  const ButtomBtn({required this.text, this.save = true});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: save ? MalinColors.AppGreen : Colors.grey.withOpacity(0.3),
        borderRadius: BorderRadius.circular(12),
      ),
      width: MediaQuery.of(context).size.width * 0.40,
      child: Center(
        child: Text(
          text,
          style: TextStyle(
            color: save ? Colors.white : Colors.black,
            fontSize: 17,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }
}
