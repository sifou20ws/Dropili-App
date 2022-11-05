import 'package:dropili/Presentation/authentification/comun_widgets/message_widget.dart';
import 'package:dropili/Presentation/home/EditProfilePage/bloc/editProfileScreen_bloc.dart';
import 'package:dropili/Presentation/home/EditProfilePage/widgets/eProfile_buttons_row.dart';
import 'package:dropili/Presentation/home/EditProfilePage/widgets/eprofile_media_widget.dart';
import 'package:dropili/Presentation/home/EditProfilePage/widgets/eprofile_text_widget.dart';
import 'package:dropili/common/constant/colors.dart';
import 'package:dropili/data/models/get_blocks_model.dart';
import 'package:dropili/domain/repositories/edit_profile_repository.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dropili/Presentation/home/EditProfilePage/widgets/eprofile_grid.dart';
import 'package:dropili/di/get_it.dart' as getIt;
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:lottie/lottie.dart';

class EditProfilePage extends StatefulWidget {
  const EditProfilePage({Key? key}) : super(key: key);

  @override
  State<EditProfilePage> createState() => _MyOffersPageState();
}

class _MyOffersPageState extends State<EditProfilePage> {
  late EditProfileBloc _editProfileBloc;
  List<BlocksItem> blocks = [],
      contactBlocks = [],
      reseauxBlocks = [],
      paymentsBlocks = [],
      diverBlocks = [];
  List<UserBlocksItem> userBlocks = [];

  @override
  void initState() {
    super.initState();
    _editProfileBloc = EditProfileBloc(
        editProfileRepository: getIt.getItInstace<EditProfileRepository>());
    _editProfileBloc.add(GetProfileEvent());
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
          /* if (state.status == Status.fail) {
            ScaffoldMessenger.of(context)
              ..hideCurrentSnackBar()
              ..showSnackBar(
                MalinSnackBars.errorSnackBar(state.messageError),
              );
          }*/
          if (state.status == Status.getBlocksSuccess) {
            blocks = state.blocks;
            userBlocks = state.userBlocks;
            contactBlocks = [];
            reseauxBlocks = [];
            paymentsBlocks = [];
            diverBlocks = [];
            blocks.forEach((element) {
              if (element.type == 1) contactBlocks.add(element);
              if (element.type == 2) reseauxBlocks.add(element);
              if (element.type == 3) paymentsBlocks.add(element);
              if (element.type == 4) diverBlocks.add(element);
            });
          }
          if (state.status == Status.postBlockSuccess) {
            _editProfileBloc.add(GetBlocksEvent());
            userBlocks = state.userBlocks;
          }
        },
        child: BlocBuilder<EditProfileBloc, EditProfileState>(
          builder: (context, state) {
            return SafeArea(
              child: Scaffold(
                backgroundColor: Colors.white,
                resizeToAvoidBottomInset: false,
                /*appBar: EditProfileAppBar(
                  appBar: AppBar(),
                ),*/
                body: (state.status == Status.loadingBlocks ||
                        state.status == Status.loadingProfile)
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
                                              userBlocks: userBlocks,
                                              type: 1,
                                              title: 'Contacts',
                                              blocksList: contactBlocks),
                                          SizedBox(height: 25),
                                          Grid(
                                              userBlocks: userBlocks,
                                              type: 2,
                                              title: "Réseaux Sociaux",
                                              blocksList: reseauxBlocks),
                                          SizedBox(height: 25),
                                          Grid(
                                              userBlocks: userBlocks,
                                              type: 3,
                                              title: 'Mode de paiments',
                                              blocksList: paymentsBlocks),
                                          SizedBox(height: 25),
                                          Grid(
                                              userBlocks: userBlocks,
                                              type: 4,
                                              title: 'Divers',
                                              blocksList: diverBlocks),
                                          SizedBox(height: 50),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Positioned(
                              bottom: 0,
                              child: Column(
                                children: [
                                  state.status == Status.fail
                                      ? MessageWidget(
                                          color: 'red',
                                          text: state.messageError)
                                      : state.status == Status.success
                                          ? MessageWidget(
                                              color: 'green',
                                              text: state.messageError,
                                            )
                                          : Container(),
                                  Container(
                                    padding: EdgeInsets.only(
                                        top: 13,
                                        bottom: 13,
                                        left: 10,
                                        right: 10),
                                    width: MediaQuery.of(context).size.width,
                                    height: MediaQuery.of(context).size.height *
                                        0.07,
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(0)),
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
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        InkWell(
                                          onTap: () {
                                            Navigator.pop(context);
                                          },
                                          child: ButtomBtn(
                                            text: 'Annuler',
                                            save: false,
                                          ),
                                        ),
                                        GestureDetector(
                                          onTap: () async {
                                            _editProfileBloc.add(
                                                PostProfileUpdateEvent(
                                                    name: state.userName,
                                                    description:
                                                        state.userDescription,
                                                    profile: state.profileImg,
                                                    background:
                                                        state.backgroundImg));
                                          },
                                          child: ButtomBtn(text: 'Enregistrer'),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
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
        borderRadius: BorderRadius.all(Radius.circular(50)),
      ),
      height: 35,
      width: MediaQuery.of(context).size.width * 0.35,
      child: Center(
        child: Text(
          text,
          style: TextStyle(
              color: save ? Colors.white : Colors.black,
              fontSize: 20,
              fontWeight: FontWeight.w400),
        ),
      ),
    );
  }
}
