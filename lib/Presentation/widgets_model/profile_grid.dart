import 'package:dropili/Presentation/home/EditProfilePage/bloc/editProfileScreen_bloc.dart';
import 'package:dropili/Presentation/home/EditProfilePage/widgets/CustomDialogBox.dart';
import 'package:dropili/Presentation/home/collectionPage/widgets/profile_card_widget.dart';
import 'package:dropili/Presentation/widgets_model/block_card.dart';
import 'package:dropili/common/constant/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Grid extends StatelessWidget {
  final String title, type;
  final List<dynamic> myList;
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
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          title,
          style: TextStyle(fontSize: 25, fontWeight: FontWeight.w600),
        ),
        SizedBox(height: 10),
        GridView.builder(
          physics: ClampingScrollPhysics(),
          shrinkWrap: true,
          // gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
          //     maxCrossAxisExtent: 120,
          //     mainAxisExtent: 150,
          //     crossAxisSpacing: 0,
          //     mainAxisSpacing: 10),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            crossAxisSpacing: 12,
            mainAxisSpacing: 30,
            mainAxisExtent: 140,
          ),
          // itemCount: myList.length,
          itemCount: myList.length,
          itemBuilder: (BuildContext ctx, index) {
            // return Container(
            //   alignment: Alignment.center,
            //   child: GestureDetector(
            //     onTap: () {
            //       showDialog<void>(
            //         context: context,
            //         barrierDismissible: false, // user must tap button!
            //         builder: (_) {
            //           return BlocProvider.value(
            //             value: context.read<EditProfileBloc>(),
            //             child: CustomDialogBox(
            //               index: index + start,
            //               img: myList[index].icon.previewUrl,
            //               editText: myList[index].hint.fr,
            //             ),
            //           );
            //         },
            //       );
            //     },
            //     child: Container(
            //       decoration: BoxDecoration(
            //         color: Colors.white,
            //         borderRadius: BorderRadius.all(Radius.circular(15)),
            //         border: Border.all(color: MalinColors.AppGreen, width: 2),
            //         boxShadow: [
            //           BoxShadow(
            //             color: Colors.grey.withOpacity(0.2),
            //             spreadRadius: 5,
            //             blurRadius: 10,
            //             offset: Offset(0, 3),
            //           )
            //         ],
            //       ),
            //       child: Padding(
            //         padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
            //         child: Column(
            //           crossAxisAlignment: CrossAxisAlignment.center,
            //           children: [
            //             myList[index].icon.previewUrl != ''
            //                 ? Expanded(
            //                     child: Image.network(
            //                       myList[index].icon.originalUrl,
            //                       width:
            //                           MediaQuery.of(context).size.width * 0.2,
            //                     ),
            //                   )
            //                 : Expanded(
            //                     child: Image.asset(
            //                       'assets/dropili_app_logo.png',
            //                       width:
            //                           MediaQuery.of(context).size.width * 0.2,
            //                     ),
            //                   ),
            //             Text(myList[index].title.ar),
            //           ],
            //         ),
            //       ),
            //     ),
            //   ),
            // );
            return BlockCardWidget(
              blockImage: Image.network(myList[index].icon.originalUrl),
              blockName: myList[index].title.ar,
              // selected: true,
            );
          },
        ),
      ],
    );
  }
}
