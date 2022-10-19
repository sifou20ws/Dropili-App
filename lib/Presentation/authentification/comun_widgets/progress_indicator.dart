import 'package:flutter/material.dart';

class LoadingIndicatorWidget extends StatelessWidget {
  final String text;
  const LoadingIndicatorWidget({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircularProgressIndicator(
            color: Colors.white,
          ),
          SizedBox(
            width: 10,
            height: 10,
          ),
          Text(
            text,
            style: TextStyle(
                color: Colors.white, fontSize: 20, fontWeight: FontWeight.w300),
          )
        ],
      ),
    );
  }
}
