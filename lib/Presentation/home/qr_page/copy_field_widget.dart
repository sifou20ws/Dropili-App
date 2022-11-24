import 'package:dropili/Presentation/home/ProfilePage/bloc/profileScreen_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CopyLinkWidget extends StatelessWidget {
  const CopyLinkWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.8,
      decoration: BoxDecoration(
        color: Colors.grey.shade200,
        border: Border.all(width: 0.5, color: Colors.grey.shade400),
        borderRadius: new BorderRadius.circular(15.0),
      ),
      child: Padding(
        padding: EdgeInsets.only(left: 20, right: 15, top: 15, bottom: 15),
        child:
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          Expanded(
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Text(
                'Dropili.co/link/' +
                    context
                        .read<ProfileBloc>()
                        .state
                        .showProfile!
                        .user
                        .username
                        .toString(),
                style: TextStyle(fontSize: 17, fontWeight: FontWeight.w400),
              ),
            ),
          ),
          SizedBox(width: 10,),
          Icon(Icons.copy_outlined),
        ]),
      ),
    );
  }
}
