import 'package:flutter/material.dart';
import 'package:dropili/Presentation/widgets_model/rounded_profile_picture.dart';
import 'package:dropili/Presentation/home/collectionPage/bloc/collection_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
        crossAxisAlignment: CrossAxisAlignment.start,
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
              Text(
                DateTime.now().day.toString() +
                    '/' +
                    DateTime.now().month.toString() +
                    '/' +
                    DateTime.now().year.toString(),
                style: TextStyle(
                    color: Colors.grey,
                    fontSize: 14,
                    fontWeight: FontWeight.w400),
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
