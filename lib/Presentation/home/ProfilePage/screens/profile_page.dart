import 'package:dropili/Presentation/home/ProfilePage/bloc/profileScreen_bloc.dart';
import 'package:dropili/Presentation/home/ProfilePage/widgets/CostumeBlocksGrid.dart';
import 'package:dropili/Presentation/home/ProfilePage/widgets/edite_profile_btn_widget.dart';
import 'package:dropili/Presentation/home/ProfilePage/widgets/profile_grid.dart';
import 'package:dropili/Presentation/widgets_model/cachedImage_widget.dart';
import 'package:dropili/Presentation/widgets_model/loading_widget.dart';
import 'package:dropili/Presentation/widgets_model/profile_information_widget.dart';
import 'package:dropili/Presentation/widgets_model/snackbar.dart';
import 'package:dropili/common/constant/colors.dart';
import 'package:dropili/common/extensions/translation_extension.dart';
import 'package:dropili/data/models/get_blocks_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dropili/Presentation/widgets_model/rounded_profile_picture.dart';
import 'package:dropili/di/get_it.dart' as getIt;

class ProfilePageWidget extends StatefulWidget {
  const ProfilePageWidget({Key? key}) : super(key: key);
  @override
  State<ProfilePageWidget> createState() => _ProfilePageWidgetState();
}

class _ProfilePageWidgetState extends State<ProfilePageWidget>
    with AutomaticKeepAliveClientMixin {
  late ProfileBloc _profileBloc;
  late List<List<UserBlocksItem>> userBlocksLists;

  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();
    _profileBloc = getIt.getItInstace<ProfileBloc>();
    _profileBloc.add(GetUserBlocksEvent());
    _profileBloc.add(GetProfileEvent());
    _profileBloc.add(GetCostumeBlocksEvent());
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);

    String getProfilePicture = '';
    String getBackgroundPicture = '', getUserDescription = '', getUserName = '';
    return BlocProvider.value(
      value: _profileBloc,
      child: BlocListener<ProfileBloc, ProfileState>(
        listener: (context, state) {
          if (state.status == ProfileStatus.fail) {
            SnackBars.showErrorSnackBar(context, state.messageError);
          }
          if (state.status == ProfileStatus.getSuccess) {
            getProfilePicture =
                _profileBloc.state.showProfile!.user.userProfile.originalUrl;
            getBackgroundPicture =
                _profileBloc.state.showProfile!.user.userBackground.originalUrl;
            getUserName = _profileBloc.state.showProfile!.user.name;
            getUserDescription =
                _profileBloc.state.showProfile!.user.description;
          }
        },
        child: BlocBuilder<ProfileBloc, ProfileState>(
          builder: (context, state) {
            return RefreshIndicator(
              color: MalinColors.AppGreen,
              onRefresh: () async {
                _profileBloc.add(GetUserBlocksEvent());
                _profileBloc.add(GetProfileEvent());
                await Future.delayed(Duration(seconds: 1));
              },
              child: Container(
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                color: Colors.white,
                child: (state.status == ProfileStatus.loading ||
                        state.status == ProfileStatus.loadingBlocks ||
                        state.status == ProfileStatus.getCostumeBlocks)
                    ? LoadingWidget()
                    : SingleChildScrollView(
                        physics: BouncingScrollPhysics(),
                        child: Stack(
                          children: <Widget>[
                            Container(
                              color: Colors.white,
                              height: MediaQuery.of(context).size.height,
                            ),
                            Container(
                              height: MediaQuery.of(context).size.height * 0.25,
                              width: MediaQuery.of(context).size.width,
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                  fit: BoxFit.fill,
                                  image: AssetImage('assets/transparent.png'),
                                  alignment: Alignment.topCenter,
                                ),
                              ),
                              child: cachedImageModelWidget(
                                image: getBackgroundPicture,
                              ),
                            ),
                            Column(
                              children: [
                                SizedBox(
                                  height: 200,
                                ),
                                Container(
                                  // color: Colors.white,
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(20),
                                        topRight: Radius.circular(20),
                                      )),
                                  child: Padding(
                                    padding: EdgeInsets.only(
                                        top: 20,
                                        left: 20,
                                        right: 20,
                                        bottom: 50),
                                    child: Column(
                                      children: [
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.end,
                                          children: [
                                            GestureDetector(
                                                onTap: () async {
                                                  Navigator.pushNamed(context,
                                                          '/editProfile')
                                                      .then(
                                                    (value) {
                                                      _profileBloc.add(
                                                          GetUserBlocksEvent());
                                                      _profileBloc.add(
                                                          GetProfileEvent());
                                                    },
                                                  );
                                                },
                                                child: EditeProfileBtnWidget()),
                                          ],
                                        ),
                                        SizedBox(height: 20),
                                        Padding(
                                            padding: EdgeInsets.only(left: 10),
                                            child: InformationWidget(
                                              name: getUserName,
                                              discrtptio: getUserDescription,
                                            )),
                                        SizedBox(height: 15),
                                        ListView.separated(
                                          physics:
                                              NeverScrollableScrollPhysics(),
                                          shrinkWrap: true,
                                          itemCount: state.userBlocks.length,
                                          itemBuilder: (context, index) {
                                            var title = '';
                                            switch (state
                                                .userBlocks[index][0].type) {
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
                                            return BlockTypeGrid(
                                              title: title,
                                              blocksList:
                                                  state.userBlocks[index],
                                            );
                                          },
                                          separatorBuilder: (context, index) =>
                                              SizedBox(height: 25),
                                        ),
                                        SizedBox(height: 20),
                                        (state.costumeBlocks.length != 0)
                                            ? CostumeBlocksGrid(
                                                costumeBlocksList:
                                                    state.costumeBlocks,
                                              )
                                            : Container(),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            Positioned(
                              top: 120,
                              left: 30,
                              child: Container(
                                padding: EdgeInsets.all(8),
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    shape: BoxShape.circle),
                                child: RoundedProfilePicture(
                                  image: (getProfilePicture == '')
                                      ? 'assets/dropili_Logo_PNG.png'
                                      : getProfilePicture,
                                  get: !(getProfilePicture == ''),
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
      ),
    );
  }
}
