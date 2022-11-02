import 'package:dropili/Presentation/home/EditProfilePage/widgets/edit_profile_buttons.dart';
import 'package:dropili/Presentation/home/ProfilePage/bloc/profileScreen_bloc.dart';
import 'package:dropili/Presentation/widgets_model/profile_grid.dart';
import 'package:dropili/common/constant/colors.dart';
import 'package:dropili/data/models/get_blocks_model.dart';
import 'package:dropili/domain/repositories/edit_profile_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:dropili/Presentation/widgets_model/rounded_profile_picture.dart';
import 'package:dropili/di/get_it.dart' as getIt;
import 'package:flutter_spinkit/flutter_spinkit.dart';

class ProfilePageWidget extends StatefulWidget {
  const ProfilePageWidget({Key? key}) : super(key: key);

  @override
  State<ProfilePageWidget> createState() => _ProfilePageWidgetState();
}

class _ProfilePageWidgetState extends State<ProfilePageWidget> {
  late ProfileBloc _profileBloc;
  List<UserBlocksItem> userBlocks = [];

  @override
  void initState() {
    super.initState();
    _profileBloc = ProfileBloc(
        editProfilerepository: getIt.getItInstace<EditProfileRepository>());
    _profileBloc.add(GetUserBlocksEvent());
    _profileBloc.add(GetProfileEvent());
  }

  @override
  void dispose() {
    _profileBloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    String getProfilePicture = '';
    String getBackgroundPicture = '', getUserDescription = '', getUserName = '';
    return BlocProvider.value(
      value: _profileBloc,
      child: BlocListener<ProfileBloc, ProfileState>(
        listener: (context, state) {
          if (state.status == ProfileStatus.fail) {
            // ScaffoldMessenger.of(context)
            //   ..hideCurrentSnackBar()
            //   ..showSnackBar(
            //     MalinSnackBars.errorSnackBar(state.messageError!.message),
            //   );
          }
          if (state.status == ProfileStatus.getSuccess) {
            userBlocks = state.userBlocks;
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
            return Container(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              color: MalinColors.AppBlue,
              child: (state.status == ProfileStatus.loading)
                  ? SpinKitWanderingCubes(
                      size: 100,
                      itemBuilder: (BuildContext context, int index) {
                        return DecoratedBox(
                          decoration: BoxDecoration(
                            color: Colors.white,
                          ),
                        );
                      },
                    )
                  : Stack(
                      children: <Widget>[
                        SingleChildScrollView(
                          child: Container(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Container(
                                  height:
                                      MediaQuery.of(context).size.height * 0.25,
                                  decoration: BoxDecoration(
                                    image: DecorationImage(
                                      fit: BoxFit.fill,
                                      image:
                                          AssetImage("assets/transparent.png"),
                                      alignment: Alignment.topCenter,
                                    ),
                                  ),
                                  child: Stack(
                                    children: <Widget>[
                                      (getBackgroundPicture == '')
                                          ? Image.asset(
                                              'assets/transparent.png',
                                              height: MediaQuery.of(context)
                                                      .size
                                                      .height *
                                                  0.20,
                                              width: MediaQuery.of(context)
                                                  .size
                                                  .width,
                                              fit: BoxFit.cover,
                                              color: MalinColors.AppBlue,
                                            )
                                          : Image.network(
                                              getBackgroundPicture,
                                              fit: BoxFit.cover,
                                              width: MediaQuery.of(context)
                                                  .size
                                                  .width,
                                            ),
                                      Align(
                                        alignment: Alignment(0.0, 1.05),
                                        child: Container(
                                          height: 60,
                                          decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius: BorderRadius.only(
                                              topLeft: Radius.circular(20),
                                              topRight: Radius.circular(20),
                                            ),
                                          ),
                                        ),
                                      ),
                                      Align(
                                        alignment: Alignment(-0.8, 0.95),
                                        child: RoundedProfilePicture(
                                          image: (getBackgroundPicture == '')
                                              ? 'assets/dropili_Logo_PNG.png'
                                              : getBackgroundPicture,
                                          get: (getBackgroundPicture == '')
                                              ? false
                                              : true,
                                        ),
                                      ),
                                      Align(
                                        alignment: Alignment(0.8, 0.95),
                                        child: GestureDetector(
                                          onTap: () {
                                            Navigator.pushNamed(
                                                context, '/editeProfile');
                                          },
                                          child: EditProfileButton(
                                            child: Text(
                                              'Editer mon profile',
                                              style: TextStyle(
                                                  color: Colors.blue,
                                                  fontWeight: FontWeight.w400,
                                                  fontSize: 18),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Container(
                                  color: Colors.white,
                                  child: Padding(
                                    padding: EdgeInsets.only(
                                        left: 20, right: 20, bottom: 50),
                                    child: Column(
                                      children: [
                                        SizedBox(height: 20),
                                        (getUserName != '')
                                            ? Text(
                                                getUserName,
                                                style: TextStyle(fontSize: 20, color: Colors.black),
                                              )
                                            : Container(),
                                        SizedBox(height: 5),
                                        (getUserDescription != '')
                                            ? Text(
                                                getUserDescription,
                                                style: TextStyle(fontSize: 15, color: Colors.black),
                                              )
                                            : Container(),
                                        SizedBox(height: 25),
                                        Grid(
                                            start: 0,
                                            size: 11,
                                            type: 'contactItems',
                                            title: 'Contacts',
                                            myList: userBlocks),
                                        SizedBox(height: 500),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
            );
          },
        ),
      ),
    );
  }
}
