import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/constant/snackbars.dart';
import '../../../core/constant/colors.dart';
import '../bloc/onBoarding_bloc.dart';
  
class OnBoardingPage extends StatefulWidget {
  const OnBoardingPage({Key? key}) : super(key: key);

  @override
  State<OnBoardingPage> createState() => _MyOffersPageState();
}

class _MyOffersPageState extends State<OnBoardingPage> {
  @override
  Widget build(BuildContext context) {
    return BlocListener<OnBoardingBloc, OnBoardingState>(
      listener: (context, state) {
        if (state.status == Status.fail) {
          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              MalinSnackBars.errorSnackBar(state.messageError!.message),
            );
        }
      },
      child: BlocBuilder<OnBoardingBloc, OnBoardingState>(
        builder: (context, state) {
          return SafeArea(
            child: Scaffold(
                backgroundColor: Colors.white,
                appBar: AppBar(
                  elevation: 0,
                  leading: Padding(
                    padding: const EdgeInsets.only(left: 15.0),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        GestureDetector(
                          onTap: (() {
                            Navigator.of(context).pop();
                          }),
                          child: Container(
                            width: 40,
                            height: 40,
                            child: Card(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30),
                              ),
                              elevation: 5,
                              child: Center(
                                child: Icon(
                                  CupertinoIcons.back,
                                  size: 20,
                                  color: Colors.black,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  backgroundColor: Colors.white,
                  title: const Text(
                    "OnBoarding Page",
                    style: TextStyle(color: Colors.black),
                  ),
                ),
                body: state.status == Status.loading
                    ? Center(
                        child: CircularProgressIndicator(
                          color: MalinColors.MalinJobOrange,
                        ),
                      )
                    : Container(
                        color: Colors.red,
                      )),
          );
        },
      ),
    );
  }
}
