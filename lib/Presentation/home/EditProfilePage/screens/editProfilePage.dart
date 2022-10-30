import 'package:dropili/Presentation/home/EditProfilePage/bloc/editProfileScreen_bloc.dart';
import 'package:dropili/Presentation/home/EditProfilePage/widgets/eProfile_buttons_row.dart';
import 'package:dropili/Presentation/home/EditProfilePage/widgets/editProfile_app_bar.dart';
import 'package:dropili/Presentation/home/EditProfilePage/widgets/eprofile_media_widget.dart';
import 'package:dropili/Presentation/home/EditProfilePage/widgets/eprofile_text_widget.dart';
import 'package:dropili/common/constant/colors.dart';
import 'package:dropili/common/constant/snackbars.dart';
import 'package:dropili/data/models/get_blocks_model.dart';
import 'package:dropili/domain/repositories/edit_profile_repository.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dropili/Presentation/widgets_model/profile_grid.dart';
import 'package:dropili/di/get_it.dart' as getIt;
import 'package:flutter_spinkit/flutter_spinkit.dart';

class EditProfilePage extends StatefulWidget {
  const EditProfilePage({Key? key}) : super(key: key);

  @override
  State<EditProfilePage> createState() => _MyOffersPageState();
}

class _MyOffersPageState extends State<EditProfilePage> {
  late EditProfileBloc _editProfileBloc;
  List<BlocksItem> blocks = [];
  @override
  void initState() {
    super.initState();
    _editProfileBloc = EditProfileBloc(
        editProfileRepository: getIt.getItInstace<EditProfileRepository>());
    _editProfileBloc.add(GetBlocksEvent());
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
        listener: (context, state) {
          if (state.status == Status.fail) {
            ScaffoldMessenger.of(context)
              ..hideCurrentSnackBar()
              ..showSnackBar(
                MalinSnackBars.errorSnackBar(state.messageError!.message),
              );
          }
          if (state.status == Status.getSuccess) {
            blocks = state.blocks;
          }
        },
        child: BlocBuilder<EditProfileBloc, EditProfileState>(
          builder: (context, state) {
            return Scaffold(
              backgroundColor: MalinColors.AppBlue,
              resizeToAvoidBottomInset: false,
              appBar: EditProfileAppBar(
                appBar: AppBar(),
              ),
              body: (state.status == Status.loading)
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
                                EditProfileMediaWidget(),
                                Container(
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(0),
                                      topRight: Radius.circular(0),
                                    ),
                                  ),
                                  child: Padding(
                                    padding: EdgeInsets.only(
                                        left: 20, right: 20, bottom: 50),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: <Widget>[
                                        EditProfileTextWidget(),
                                        SizedBox(height: 15),
                                        EditProfileButtonsWidget(),
                                        SizedBox(height: 15),
                                        Grid(
                                            start: 0,
                                            size: 11,
                                            type: 'contactItems',
                                            title: 'Contacts',
                                            myList: blocks),
                                        SizedBox(height: 15),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Positioned(
                            bottom: 0,
                            child: Container(
                              color: MalinColors.AppBlue,
                              height: 60,
                              width: MediaQuery.of(context).size.width,
                              child: Center(
                                child: Text(
                                  'Enregistrer mon profile',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 30,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
            );
          },
        ),
      ),
    );
  }
}
