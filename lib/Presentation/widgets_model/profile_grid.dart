import 'package:dropili/Presentation/widgets_model/profile_icon.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/models/item_models.dart';
import '../EditProfilePage/widgets/CustomDialogBox.dart';
import '../EditProfilePage/widgets/show_popup.dart';

import 'dart:developer';

class Grid extends StatelessWidget {
  final String title, type;
  final List<Item> myList;
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
                maxCrossAxisExtent: 130,
                crossAxisSpacing: 0,
                mainAxisSpacing: 0),
            itemCount: size,
            itemBuilder: (BuildContext ctx, index) {
              return Container(
                alignment: Alignment.center,
                child: GestureDetector(
                    onTap: () {
                      /*BlocProvider.of<EditProfileBloc>(context)
                          .add(ItemSelectedEvent(index: index, id: type));
                      log(index.toString());
                      log(type);*/
                      /*showDialog<void>(
                        context: context,
                        barrierDismissible: false, // user must tap button!
                        builder: (BuildContext context) {
                          return ShowPopUp(index:index,);
                        },
                      );*/
                      showDialog<void>(
                        context: context,
                        barrierDismissible: false, // user must tap button!
                        builder: (BuildContext context) {
                          return CustomDialogBox(
                            index: index + start,
                            img: 'assets/IconsFR/call.png',
                            editText: 'Entrez votre numéro de téléphone',
                          );
                        },
                      );

                      log('message');
                    },
                    child: IconProfile(
                        image1: myList[index + start].imageUrl,
                        selected: myList[index + start].selected)),
              );
            },
          ),
        ]);
  }
}
