import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class LoadingIndicatorWidget extends StatelessWidget {
  final String text;
  const LoadingIndicatorWidget({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: CircularProgressIndicator(color: Colors.white),
    );
  }
}
