import 'dart:developer';

import 'package:dropili/data/models/get_blocks_model.dart';
import 'package:flutter/material.dart';

class ProfileGrid extends StatelessWidget {
  final String title, type;
  final List<UserBlocksItem> myList;
  const ProfileGrid({
    required this.title,
    required this.myList,
    required this.type,
  });

  @override
  Widget build(BuildContext context) {

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          title,
          style: TextStyle(fontSize: 30, fontWeight: FontWeight.w600),
        ),
        SizedBox(height: 10),
        GridView.builder(
          physics: ClampingScrollPhysics(),
          shrinkWrap: true,
          gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
              maxCrossAxisExtent: 100, crossAxisSpacing: 10, mainAxisSpacing: 10),
          itemCount: myList.length,
          itemBuilder: (BuildContext ctx, index) {
            return Container(
              alignment: Alignment.center,
              child: GestureDetector(
                onTap: () {
                  log('index $index');
                },
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(Radius.circular(15)),
                    //border: Border.all(color: MalinColors.AppGreen, width: 3),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.3),
                        spreadRadius: 3,
                        blurRadius: 4,
                        offset: Offset(0, 3),
                      )
                    ],
                  ),
                  child: Padding(
                    padding: EdgeInsets.symmetric(vertical: 5, horizontal: 5),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        myList[index].icon.previewUrl != ''
                            ? Expanded(
                                child: Image.network(
                                  myList[index].icon.originalUrl,
                                  width:
                                      MediaQuery.of(context).size.width * 0.2,
                                ),
                              )
                            : Expanded(
                                child: Image.asset(
                                  'assets/dropili_app_logo.png',
                                  width:
                                      MediaQuery.of(context).size.width * 0.2,
                                ),
                              ),
                        Text(myList[index].title.ar),
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ],
    );
  }
}
