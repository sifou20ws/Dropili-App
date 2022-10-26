import 'dart:developer';

import 'package:dropili/Presentation/Nfc/bloc/nfc_bloc.dart';
import 'package:dropili/common/extensions/translation_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';

class NfcScanWidget extends StatefulWidget {
  const NfcScanWidget({super.key});

  @override
  State<NfcScanWidget> createState() => _NfcScanWidgetState();
}

class _NfcScanWidgetState extends State<NfcScanWidget> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => NfcBloc(),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 5),
        child: Container(
          padding: EdgeInsets.only(
            top: 30,
            right: 30,
            left: 30,
          ),
          height: 420,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(25),
              topRight: Radius.circular(25),
            ),
          ),
          child: BlocListener<NfcBloc, NfcState>(
            listener: (context, state) async {
              if (state is NfcSearchingState) {
                log('somethin');
              } else if (state is NfcFoundState) {
                await Future.delayed(
                  Duration(seconds: 4),
                );
                Navigator.pop(context, state.content);
              } else if (state is NfcErroState) {
                await Future.delayed(Duration(seconds: 4));
                Navigator.pop(context);
              }
            },
            child: BlocBuilder<NfcBloc, NfcState>(
              builder: (context, state) {
                return Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      'Scan Dropili tag'.t(context),
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 23,
                      ),
                    ),
                    state is NfcSearchingState
                        ? Lottie.asset('assets/lottie/nfc.json', height: 240)
                        : state is NfcErroState
                            ? Lottie.asset('assets/lottie/nfc-fail.json',
                                height: 240, repeat: false)
                            : Lottie.asset(
                                'assets/lottie/nfc-success.json',
                                height: 240,
                                repeat: false,
                              ),
                    GestureDetector(
                      onTap: () {
                        BlocProvider.of<NfcBloc>(context).add(NfcStartEvent());
                        // BlocProvider.of<NfcBloc>(context)
                        //     .add(NfcTagFoundEvent('TAG'));
                      },
                      child: state is NfcSearchingState
                          ? Text(
                              'Still looking'.t(context) + '...',
                              style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.w600,
                                fontSize: 21,
                              ),
                            )
                          : state is NfcFoundState
                              ? Text(
                                  'Profile found'.t(context),
                                  style: TextStyle(
                                    color: Color.fromARGB(255, 61, 199, 114),
                                    fontWeight: FontWeight.w600,
                                    fontSize: 21,
                                  ),
                                )
                              : Text(
                                  'Wrong tag'.t(context),
                                  style: TextStyle(
                                    color: Colors.red,
                                    fontWeight: FontWeight.w600,
                                    fontSize: 21,
                                  ),
                                ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    // state is NfcSearchingState
                    Text(
                      'nfc looking text'.t(context),
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.grey,
                        fontWeight: FontWeight.w400,
                        fontSize: 14,
                      ),
                    )
                    // : Container(),
                  ],
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
