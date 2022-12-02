import 'package:dropili/Presentation/home/collectionPage/widgets/all_block_widget.dart';
import 'package:dropili/Presentation/home/common_widgets/profile_unactive_widget.dart';
import 'package:dropili/Presentation/home/scanned_profile/bloc/scanned_profile_bloc.dart';
import 'package:dropili/Presentation/widgets_model/cachedImage_widget.dart';
import 'package:dropili/Presentation/widgets_model/loading_widget.dart';
import 'package:dropili/Presentation/widgets_model/profile_information_widget.dart';
import 'package:dropili/Presentation/widgets_model/rounded_profile_picture.dart';
import 'package:dropili/common/extensions/translation_extension.dart';
import 'package:dropili/di/get_it.dart' as getIt;
import 'package:dropili/domain/repositories/profile_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ScannedProfileScreen extends StatefulWidget {
  ScannedProfileScreen({super.key}) {}

  @override
  State<ScannedProfileScreen> createState() => _scannedProfileScreen();
}

class _scannedProfileScreen extends State<ScannedProfileScreen> {
  late ScannedProfileBloc _scannedProfileBloc;
  late String _scannedUrl;

  @override
  void initState() {
    _scannedProfileBloc = ScannedProfileBloc(
        profileRepository: getIt.getItInstace<ProfileRepository>());
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    _scannedProfileBloc.close();
  }

  @override
  Widget build(BuildContext context) {
    _scannedUrl = ModalRoute.of(context)?.settings.arguments as String;

    _scannedProfileBloc.add(LoadScannedProfileEvent(_scannedUrl));

    return BlocProvider.value(
        value: _scannedProfileBloc,
        child: Scaffold(
          body: BlocListener<ScannedProfileBloc, ScannedProfileState>(
            listener: (context, state) {},
            child: BlocBuilder<ScannedProfileBloc, ScannedProfileState>(
              builder: (context, state) {
                return SafeArea(
                  child: Container(
                    height: MediaQuery.of(context).size.height,
                    width: MediaQuery.of(context).size.width,
                    color: Colors.white,
                    child: SingleChildScrollView(
                      physics: BouncingScrollPhysics(),
                      child: state is ProfileLoadingState
                          ? Container(
                              height: MediaQuery.of(context).size.height,
                              child: LoadingWidget())
                          : state is ProfileLoadedState
                              ? Stack(
                                  children: <Widget>[
                                    Container(
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.25,
                                      width: MediaQuery.of(context).size.width,
                                      decoration: BoxDecoration(
                                        image: DecorationImage(
                                          fit: BoxFit.fill,
                                          image: AssetImage(
                                              'assets/transparent.png'),
                                          alignment: Alignment.topCenter,
                                        ),
                                      ),
                                      child: cachedImageModelWidget(
                                          image: state.scannedFriend
                                              .userBackground.originalUrl),
                                    ),
                                    Column(
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.all(10),
                                          child: Row(
                                            children: [
                                              ElevatedButton(
                                                onPressed: () {
                                                  Navigator.pop(context);
                                                },
                                                child: Icon(
                                                  Icons.arrow_back_rounded,
                                                  color: Colors.black,
                                                  size: 30,
                                                ),
                                                style: ElevatedButton.styleFrom(
                                                    backgroundColor:
                                                        Colors.white,
                                                    elevation: 20,
                                                    shape: CircleBorder(),
                                                    shadowColor: Colors.black
                                                        .withAlpha(150),
                                                    padding: EdgeInsets.all(8)),
                                              ),
                                            ],
                                          ),
                                        ),
                                        SizedBox(
                                          height: 150,
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
                                                top: 30,
                                                left: 20,
                                                right: 20,
                                                bottom: 50),
                                            child: Column(
                                              children: [
                                                SizedBox(height: 20),
                                                Padding(
                                                  padding:
                                                      EdgeInsets.only(left: 10),
                                                  child: InformationWidget(
                                                    name: state
                                                        .scannedFriend.name,
                                                    description: state
                                                        .scannedFriend
                                                        .description,
                                                  ),
                                                ),
                                                SizedBox(height: 35),
                                                state.scannedFriend.active
                                                    ? AllBlockWidget(
                                                        blocksTypesList: state
                                                            .blocksTypesList,
                                                        freindProfile:
                                                            state.scannedFriend,
                                                      )
                                                    : ProfileUnactiveWidget(),
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
                                        child: Hero(
                                          tag: state.scannedFriend.name,
                                          child: RoundedProfilePicture(
                                            image: (state
                                                        .scannedFriend
                                                        .userProfile
                                                        .originalUrl ==
                                                    '')
                                                ? 'assets/dropili_Logo_PNG.png'
                                                : state.scannedFriend
                                                    .userProfile.originalUrl,
                                            get: !(state.scannedFriend
                                                    .userProfile.originalUrl ==
                                                ''),
                                          ),
                                        ),
                                      ),
                                    )
                                  ],
                                )
                              : Container(
                                  width: MediaQuery.of(context).size.width,
                                  height: MediaQuery.of(context).size.height,
                                  alignment: Alignment.center,
                                  child: Column(
                                    children: [
                                      Icon(
                                        Icons.error_outline,
                                        color: Colors.grey,
                                        size: 40,
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Text(
                                        'Something went wrong'.t(context),
                                        style: TextStyle(
                                            color: Colors.grey, fontSize: 18),
                                      ),
                                    ],
                                  ),
                                ),
                    ),
                  ),
                );
              },
            ),
          ),
        ));
  }
}
