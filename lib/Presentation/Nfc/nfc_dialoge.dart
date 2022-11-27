import 'package:dropili/Presentation/Nfc/bloc/nfc_bloc.dart';
import 'package:dropili/Presentation/Nfc/widgets/nfc_not_found_widget.dart';
import 'package:dropili/Presentation/Nfc/widgets/nfc_searching_widget.dart';
import 'package:dropili/Presentation/Nfc/widgets/nfc_tag_error_widget.dart';
import 'package:dropili/Presentation/Nfc/widgets/nfc_tag_found_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dropili/di/get_it.dart' as getIt;

class NfcScanWidget extends StatefulWidget {
  final String dataToTag;
  const NfcScanWidget({super.key, required this.dataToTag});

  @override
  State<NfcScanWidget> createState() => _NfcScanWidgetState();
}

class _NfcScanWidgetState extends State<NfcScanWidget> {
  late NfcBloc _nfcBloc;

  @override
  void initState() {
    super.initState();
    _nfcBloc = getIt.getItInstace<NfcBloc>();
    _nfcBloc.add(WriteTagEvent(widget.dataToTag));
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: _nfcBloc,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 5),
        child: Container(
          padding: EdgeInsets.only(
            top: 30,
            right: 30,
            left: 30,
          ),
          height: MediaQuery.of(context).size.height * 0.5,
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
              } else {
                await Future.delayed(Duration(seconds: 3));
                try {
                  Navigator.of(context).pop();
                } catch (e) {}
              }
            },
            child: BlocBuilder<NfcBloc, NfcState>(
              builder: (context, state) {
                if (state is NfcNotFoundState) {
                  return NoNfcFoundWidget();
                } else if (state is NfcSearchingState) {
                  return NfcSearchingWidget();
                } else if (state is NfcTagWrittenState) {
                  return NfcTagFoundWidget();
                } else if (state is NfcWriteErrorState) {
                  return NfcTagErrorWidget();
                } else {
                  return Container();
                }
              },
            ),
          ),
        ),
      ),
    );
  }
}
