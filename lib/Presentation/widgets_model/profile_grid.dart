import 'package:dropili/Presentation/home/EditProfilePage/bloc/editProfileScreen_bloc.dart';
import 'package:dropili/Presentation/home/EditProfilePage/widgets/CustomDialogBox.dart';
import 'package:dropili/Presentation/widgets_model/profile_icon.dart';
import 'package:dropili/common/constant/colors.dart';
import 'package:dropili/data/models/get_blocks_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Grid extends StatelessWidget {
  final String title, type;
  final List<BlocksItem> myList;
  final int size, start;
  const Grid({
    required this.title,
    required this.myList,
    required this.type,
    required this.size,
    required this.start,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Center(
            child: Text(
              title,
              style: TextStyle(fontSize: 30, fontWeight: FontWeight.w400),
            ),
          ),
          SizedBox(height: 5),
          GridView.builder(
            physics: ClampingScrollPhysics(),
            shrinkWrap: true,
            gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                maxCrossAxisExtent: 120,
                crossAxisSpacing: 0,
                mainAxisSpacing: 0),
            itemCount: myList.length,
            itemBuilder: (BuildContext ctx, index) {
              return Container(
                alignment: Alignment.center,
                child: GestureDetector(
                  onTap: () {
                    showDialog<void>(
                      context: context,
                      barrierDismissible: false, // user must tap button!
                      builder: (_) {
                        return BlocProvider.value(
                          value: context.read<EditProfileBloc>(),
                          child: CustomDialogBox(
                            index: index + start,
                            img: myList[index].icon.previewUrl,
                            editText: myList[index].hint.fr,
                          ),
                        );
                      },
                    );
                  },
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      myList[index].icon.previewUrl != ''
                          ? Container(
                              child:
                                  Image.network(myList[index].icon.previewUrl),
                              height: 70,
                            )
                          : Container(
                              height: 50,
                              child: Image.asset('assets/dropili_app_logo.png'),
                            ),
                      /*Placeholder(
                              color: MalinColors.AppBlue,
                              child: Container(),
                              fallbackHeight: 40,
                              fallbackWidth: 30,
                            ),*/
                      Text(myList[index].title.ar),
                    ],
                  ),
                ),
              );
            },
          ),
        ]);
  }
}
