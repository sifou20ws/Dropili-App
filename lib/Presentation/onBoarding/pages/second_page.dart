import 'package:dropili/common/extensions/translation_extension.dart';
import 'package:flutter/material.dart';

class SecondPage extends StatelessWidget {
  const SecondPage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 60, right: 60),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image(image: AssetImage('assets/linkwithin.png')),
          SizedBox(
            height: 10,
          ),
          Text(
            'Share title'.t(context),
            style: TextStyle(fontSize: 22, color: Colors.white),
          ),
          SizedBox(
            height: 20,
          ),
          Text(
            'Share text'.t(context),
            style: TextStyle(fontSize: 17, color: Colors.white),
            textAlign: TextAlign.center,
          ),
        ],
        // child: PageView.builder(itemBuilder: ((context, index) => Container())),
      ),
    );
  }
}
