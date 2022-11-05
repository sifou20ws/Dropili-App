import 'dart:developer';

import 'package:dropili/Presentation/home/collectionPage/bloc/collection_bloc.dart';
import 'package:dropili/Presentation/home/collectionPage/widgets/profile_card_widget.dart';
import 'package:dropili/common/extensions/translation_extension.dart';
import 'package:dropili/domain/repositories/edit_profile_repository.dart';
import 'package:flutter/material.dart';
import 'package:dropili/di/get_it.dart' as getIt;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';

class CollectionPage extends StatefulWidget {
  const CollectionPage({super.key});

  @override
  State<CollectionPage> createState() => _CollectionPageState();
}

class _CollectionPageState extends State<CollectionPage>
    with AutomaticKeepAliveClientMixin {
  late CollectionBloc _collectionBloc;

  @override
  void initState() {
    super.initState();
    _collectionBloc = CollectionBloc(
        editProfileRepository: getIt.getItInstace<EditProfileRepository>());
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);

    return BlocProvider.value(
      value: _collectionBloc,
      child: BlocBuilder<CollectionBloc, CollectionState>(
        builder: (context, state) {
          return RefreshIndicator(
            onRefresh: () async {
              await Future.delayed(Duration(seconds: 2));
            },
            child: Container(
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
                            ],
                          ),
                        )
                      : Container(),
            ),
          );
        },
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
