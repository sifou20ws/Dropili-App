import 'package:dropili/common/constant/colors.dart';
import 'package:dropili/common/constant/snackbars.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/usecases/editProfileUsecase.dart';
import '../../EditProfilePage/bloc/editProfileScreen_bloc.dart';
import '../../EditProfilePage/screens/editProfilePage.dart';
import '../../EditProfilePage/widgets/button.dart';
import '../../bottomNavigationBarPage/bottomNavigationBarPage.dart';
import '../../drawerPage/drawerPage.dart';
import '../../widgets_model/rounded_profile_picture.dart';
import '../bloc/profileScreen_bloc.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _MyOffersPageState();
}

class _MyOffersPageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    return BlocListener<ProfileBloc, ProfileState>(
      listener: (context, state) {
        if (state.status == ProfileStatus.fail) {
          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              MalinSnackBars.errorSnackBar(state.messageError!.message),
            );
        }
      },
      child: BlocBuilder<ProfileBloc, ProfileState>(
        builder: (context, state) {
          return SafeArea(
            child: Scaffold(
              backgroundColor: Colors.white,
              appBar: AppBar(
                elevation: 0,
                backgroundColor: Colors.white,
                iconTheme: IconThemeData(color: Colors.black),
                title: Center(
                  child: Image.asset(
                    'assets/dropili_Logo_PNG.png',
                    fit: BoxFit.contain,
                    height: 50,
                  ),
                ),
                actions: <Widget>[
                  IconButton(
                    icon: Icon(
                      Icons.share,
                      color: Colors.black54,
                    ),
                    onPressed: () {
                      // do something
                    },
                  )
                ],
              ),
              body: Stack(
                children: <Widget>[
                  SingleChildScrollView(
                    child: Container(
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage("assets/background2.png"),
                          alignment: Alignment.topCenter,
                        ),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Container(
                            height: MediaQuery.of(context).size.height * 0.25,
                            child: Stack(
                              children: <Widget>[
                                Image.asset(
                                  'assets/transparent.png',
                                  height:
                                      MediaQuery.of(context).size.height * 0.20,
                                  width: MediaQuery.of(context).size.width,
                                  fit: BoxFit.cover,
                                  color: MalinColors.AppBlue,
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
                                    image: 'assets/dropili_Logo_PNG.png',
                                  ),
                                ),
                                Align(
                                  alignment: Alignment(0.8, 0.95),
                                  child: GestureDetector(
                                    onTap: (){
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (BuildContext context) => BlocProvider(
                                            create: (_) => EditProfileBloc( editProfileUseCase: EditProfileUseCase() ),
                                            child: EditProfilePage(),
                                          ),
                                        ),
                                      );
                                    },
                                    child: EditProfileButton(
                                      child: Text(
                                        'Editer mon profile',
                                        style: TextStyle(
                                            color: Colors.blue,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 18),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 1000,
                            child: Container(
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              drawer: DrawerPage(),
              bottomNavigationBar: BottomNavigationBarPage(),
            ),
          );
        },
      ),
    );
  }
}
