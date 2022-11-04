import 'package:dropili/Presentation/home/collectionPage/bloc/collection_bloc.dart';
import 'package:dropili/Presentation/widgets_model/rounded_profile_picture.dart';
import 'package:dropili/common/extensions/translation_extension.dart';
import 'package:dropili/domain/repositories/edit_profile_repository.dart';
import 'package:flutter/material.dart';
import 'package:dropili/di/get_it.dart' as getIt;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_launcher_icons/xml_templates.dart';
import 'package:lottie/lottie.dart';

class CollectionPage extends StatefulWidget {
  const CollectionPage({super.key});

  @override
  State<CollectionPage> createState() => _CollectionPageState();
}

class _CollectionPageState extends State<CollectionPage> {
  late CollectionBloc _collectionBloc;

  @override
  void initState() {
    super.initState();
    _collectionBloc = CollectionBloc(
        editProfileRepository: getIt.getItInstace<EditProfileRepository>());
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: _collectionBloc,
      child: BlocBuilder<CollectionBloc, CollectionState>(
        builder: (context, state) {
          return Container(
            // height: 300,
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
            child: state is CollectionLoadingState
                ? Center(
                    child: Lottie.asset(
                      'assets/lottie/loading.json',
                      height: 100,
                    ),
                  )
                : state is CollectionLoadedState
                    ? SingleChildScrollView(
                        child: Column(
                          children: [
                            Row(
                              children: [
                                Text(
                                  'Collection'.t(context),
                                  textAlign: TextAlign.start,
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.w600,
                                      fontSize: 25),
                                ),
                                Text(
                                  ' (2)',
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w600),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            ProfileCardWidget()
                            // ListView(
                            //   physics: NeverScrollableScrollPhysics(),
                            //   children: [
                            //   ],
                            // )
                          ],
                        ),
                      )
                    : Container(),
          );
        },
      ),
    );
  }
}

class ProfileCardWidget extends StatelessWidget {
  const ProfileCardWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      // padding: EdgeInsets.symmetric(horizontal: 10, vertical: 15),
      padding: EdgeInsets.only(right: 10, left: 10, top: 15, bottom: 15),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Color.fromARGB(20, 29, 29, 29),
            offset: Offset(0.0, 2.0),
            blurRadius: 10,
            spreadRadius: 5,
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          RoundedProfilePicture(
            image:
                (context.read<CollectionBloc>().state as CollectionLoadedState)
                    .profilePicUrl,
            get: true,
            size: 90,
          ),
          // SizedBox(
          //   width: 10,
          // ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                (context.read<CollectionBloc>().state as CollectionLoadedState)
                    .coverPicUrl,
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 18,
                    fontWeight: FontWeight.w600),
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                // padding: EdgeInsets.symmetric(horizontal: 5, vertical: 6),
                padding: EdgeInsets.only(left: 5, right: 0, top: 6, bottom: 6),
                height: 45,
                width: 180,
                decoration: BoxDecoration(
                    color: Colors.grey.shade200,
                    borderRadius: BorderRadius.circular(10)),
                // child: Image.network(
                //     state.blocks[0].icon.originalUrl),
                child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  // shrinkWrap: true,

                  itemCount: (context.read<CollectionBloc>().state
                          as CollectionLoadedState)
                      .blocks
                      .length,
                  itemBuilder: (context, index) {
                    return Image.network(
                      (context.read<CollectionBloc>().state
                              as CollectionLoadedState)
                          .blocks[index]
                          .icon
                          .originalUrl,
                      // height: 30,
                      // width: 30,
                    );
                  },
                  separatorBuilder: (context, index) => SizedBox(
                    width: 5,
                  ),
                ),
              ),
            ],
          ),
          Container(
            height: 40,
            width: 40,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Color.fromARGB(20, 29, 29, 29),
                  offset: Offset(0.0, 2.0),
                  blurRadius: 5,
                  spreadRadius: 2,
                ),
              ],
            ),
            child: Icon(Icons.more_horiz),
          )
        ],
      ),
    );
  }
}
