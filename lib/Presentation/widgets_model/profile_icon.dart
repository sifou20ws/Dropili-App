import 'package:flutter/material.dart';

class IconProfile extends StatelessWidget {
  final String image1;
  final onTap;
  bool selected = false;
  IconProfile({required this.image1, this.onTap, this.selected = false});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Stack(children: <Widget>[
          Padding(
            padding: selected ? EdgeInsets.all(5) : EdgeInsets.all(0) ,
            child: Container(
              height: selected? MediaQuery.of(context).size.width*0.3 : MediaQuery.of(context).size.width*0.3,
              decoration: BoxDecoration(
                border: selected ? Border.all(color: Colors.amber) : null,
                borderRadius: BorderRadius.circular(15),
              ),
              child: Padding(
                padding: selected ? EdgeInsets.symmetric(horizontal:15, vertical: 15) : EdgeInsets.all(5),
                child: (image1 != '') ? Image.asset(image1) : null,
              ),
            ),
          ),
          Positioned(
            top: 0,
            right: 0,
            child: selected
                ? Container(
              height: 20,
              width: 20,
              decoration: BoxDecoration(
                color: Colors.green,
                borderRadius: BorderRadius.circular(50),
              ),
              child: Icon(
                Icons.check,
                size: 15,
                color: Colors.white,
              ),
            )
                : Container(),
          ),
        ]),
      ],
    );
  }
}