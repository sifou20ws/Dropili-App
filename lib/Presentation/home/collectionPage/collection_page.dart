import 'package:dropili/Presentation/home/collectionPage/bloc/collection_bloc.dart';
import 'package:dropili/Presentation/home/collectionPage/widgets/profile_card_widget.dart';
import 'package:dropili/Presentation/widgets_model/loading_widget.dart';
import 'package:dropili/Presentation/widgets_model/snackbar.dart';
import 'package:dropili/common/constant/colors.dart';
import 'package:dropili/common/extensions/translation_extension.dart';
import 'package:dropili/data/models/get_friends_result_model.dart.dart';
import 'package:dropili/domain/repositories/profile_repository.dart';
import 'package:flutter/material.dart';
import 'package:dropili/di/get_it.dart' as getIt;
import 'package:flutter_bloc/flutter_bloc.dart';

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
        profileRepository: getIt.getItInstace<ProfileRepository>());
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);

    return BlocProvider.value(
      value: _collectionBloc,
      child: BlocListener<CollectionBloc, CollectionState>(
        listener: (context, state) {
          if (state is CollectionErrorState)
            SnackBars.showErrorSnackBar(context, state.errorMassage);

          if (state is CollectionSucessState)
            SnackBars.showSucessSnackBar(context, state.message);
        },
        child: BlocBuilder<CollectionBloc, CollectionState>(
          builder: (context, state) {
            return RefreshIndicator(
              onRefresh: () async {
                _collectionBloc.add(LoadCollectionEvent());
              },
              color: MalinColors.AppGreen,
              child: SingleChildScrollView(
                physics: BouncingScrollPhysics(),
                child: Container(
                  constraints: BoxConstraints(
                      minHeight: MediaQuery.of(context).size.height - 150),
                  padding: EdgeInsets.only(top: 20, left: 20, right: 20),
                  child: state is CollectionLoadingState
                      ? LoadingWidget()
                      : state is CollectionLoadedState
                          ? Column(
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
                                      ' (${state.friendsList.length})',
                                      style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.w600),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                                // FriendsCardsWidget()
                                FriendsListWidget(
                                    friendsList: state.friendsList),
                              ],
                            )
                          : state is CollectionEmptyState
                              ? Center(
                                  child: Text(
                                    'No collection yet'.t(context),
                                    style: TextStyle(
                                        color: Colors.grey.shade500,
                                        fontWeight: FontWeight.w400),
                                  ),
                                )
                              : Container(),
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}

class FriendsListWidget extends StatelessWidget {
  final List<FriendsItem> friendsList;
  const FriendsListWidget({super.key, required this.friendsList});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      physics: BouncingScrollPhysics(),
      itemCount: friendsList.length,
      shrinkWrap: true,
      itemBuilder: (context, index) =>
          ProfileCardWidget(profile: friendsList[index]),
      separatorBuilder: (context, index) => SizedBox(
        height: 20,
      ),
    );
  }
}
