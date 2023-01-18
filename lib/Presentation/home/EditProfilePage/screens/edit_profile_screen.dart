import 'package:dropili/Presentation/home/EditProfilePage/bloc/editProfileScreen_bloc.dart';
import 'package:dropili/Presentation/home/EditProfilePage/widgets/CustomBlocksWidgets/grid_widget.dart';
import 'package:dropili/Presentation/home/EditProfilePage/widgets/direct_sur_dialogue.dart';
import 'package:dropili/Presentation/home/EditProfilePage/widgets/switches_row.dart';
import 'package:dropili/Presentation/home/EditProfilePage/widgets/media_widget.dart';
import 'package:dropili/Presentation/home/EditProfilePage/widgets/text_fields.dart';
import 'package:dropili/Presentation/widgets_model/snackbar.dart';
import 'package:dropili/common/constant/colors.dart';
import 'package:dropili/common/extensions/translation_extension.dart';
import 'package:dropili/data/models/get_blocks_model.dart';
import 'package:dropili/data/models/get_costume_block_response.dart';
import 'package:dropili/domain/repositories/profile_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dropili/Presentation/home/EditProfilePage/widgets/BlocksWidgets/grid_widget.dart';
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
  bool active = false, get = false, get2 = false;
  int blockId = 0;
  String getProfilePicture = '', getBackgroundPicture = '';
  List<CustomBlocksItem> costumeBlocks = [];

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
            get = true;
          }
          if (state.status == Status.getProfileSuccess) {
            blockId = state.showProfile!.user.blockId;
            state.profileUserUrl = state.showProfile!.user.blockId;
            _editProfileBloc
                .add(ActiveEvent(state: state.showProfile!.user.active));
            getProfilePicture = state.showProfile!.user.userProfile.originalUrl;
            getBackgroundPicture =
                state.showProfile!.user.userBackground.originalUrl;
            _editProfileBloc
                .add(PostUserNameEvent(name: state.showProfile!.user.name));
            _editProfileBloc.add(PostDescriptionEvent(
                description: state.showProfile!.user.description));
          }
          /** ******* */
          if (state.status == Status.getCostumeBlocksSuccess) {
            costumeBlocks = state.costumeBlocks;
            get2 = true;
          }
          /** ******* */
          if (state.status == Status.postBlockSuccess) {
            _editProfileBloc.add(GetBlocksEvent());
            SnackBars.showSucessSnackBar(context, state.messageError);
            await Future.delayed(Duration(milliseconds: 500));
          }
          if (state.status == Status.postBlockFail) {
            SnackBars.showErrorSnackBar(context, state.messageError);
            await Future.delayed(Duration(milliseconds: 500));
          }
          if (state.status == Status.deleteSuccess) {
            _editProfileBloc.add(GetBlocksEvent());
            SnackBars.showSucessSnackBar(context, state.messageError);
            await Future.delayed(Duration(milliseconds: 500));
          }
          if (state.status == Status.deleteFail) {
            SnackBars.showErrorSnackBar(context, state.messageError);
            await Future.delayed(Duration(milliseconds: 500));
          }
          if (state.status == Status.postCostumeBlocksSuccess) {
            _editProfileBloc.add(GetCostumeBlocksEvent());
            SnackBars.showSucessSnackBar(context, state.messageError);
            await Future.delayed(Duration(milliseconds: 500));
          }
          if (state.status == Status.postCostumeBlocksFail) {
            SnackBars.showErrorSnackBar(context, state.messageError);
            await Future.delayed(Duration(milliseconds: 500));
          }
          if (state.status == Status.deleteCostumeBlocksSuccess) {
            _editProfileBloc.add(GetCostumeBlocksEvent());
            SnackBars.showSucessSnackBar(context, state.messageError);
            await Future.delayed(Duration(milliseconds: 500));
          }
          if (state.status == Status.deleteCostumeBlocksFail) {
            SnackBars.showErrorSnackBar(context, state.messageError);
            await Future.delayed(Duration(milliseconds: 500));
          }
          if (state.status == Status.updateCostumeBlocksSuccess) {
            _editProfileBloc.add(GetCostumeBlocksEvent());
            SnackBars.showSucessSnackBar(context, state.messageError);
            await Future.delayed(Duration(milliseconds: 500));
          }
          if (state.status == Status.updateCostumeBlocksFail) {
            SnackBars.showErrorSnackBar(context, state.messageError);
            await Future.delayed(Duration(milliseconds: 500));
          }

          if (state.status == Status.profileUpdateFail) {
            SnackBars.showErrorSnackBar(context, state.messageError);
            state.status = Status.initial;
          }
          if (state.status == Status.fail) {
            SnackBars.showErrorSnackBar(context, state.messageError);
          } else if (state.status == Status.success) {
            SnackBars.showSucessSnackBar(context, state.messageError);
          }
          if (state.status == Status.directOnMeSuccess) {
            SnackBars.showSucessSnackBar(context, state.messageError);
          } else if (state.status == Status.directOnMeFail) {
            SnackBars.showErrorSnackBar(context, state.messageError);
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
                  profileUrl: state.profileUserUrl,
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
        },
        child: BlocBuilder<EditProfileBloc, EditProfileState>(
          builder: (context, state) {
            return SafeArea(
              child: Scaffold(
                backgroundColor: Colors.white,
                resizeToAvoidBottomInset: true,
                body: (state.blocksStatus == BlocksStatus.getBlocks ||
                        state.status == Status.loadingProfile ||
                        //!get || !get2
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
                        child: Stack(
                          children: <Widget>[
                            SingleChildScrollView(
                              physics: BouncingScrollPhysics(),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  MediaWidget(
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
                                          TextFieldsWidget(
                                            name: state.userName,
                                            description: state.userDescription,
                                          ),
                                          SizedBox(height: 15),
                                          SwitchesWidget(),
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
                                                  title = 'Others'.t(context);
                                                  break;
                                                default:
                                              }
                                              return BlocksGrid(
                                                userBlocks: state.userBlocks,
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
                                          CostumeBlocksGrid(
                                            costumeBlocksList:
                                                state.costumeBlocks,
                                          ),
                                          SizedBox(height: 15),
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
                            active: state.activeButton,
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
