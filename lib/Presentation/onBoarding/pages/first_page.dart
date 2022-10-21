
import 'package:flutter/material.dart';


class FirstPage extends StatelessWidget {
  const FirstPage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 49, right: 50),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: EdgeInsets.only(left: 59, right: 60),
            child: Hero(
                tag: 'logo',
                child: Image(image: AssetImage('assets/dropili.png'))),
          ),
          SizedBox(
            height: 79,
          ),
          Text(
            'Bienvenue sur dropili',
            style: TextStyle(fontSize: 22, color: Colors.white),
          ),
          SizedBox(
            height: 19,
          ),
          Text(
            'Partagez vos coordonnees, reseaux sociaux et bien plus avec dropili',
            style: TextStyle(fontSize: 16, color: Colors.white),
            textAlign: TextAlign.center,
          ),
        ],
        // child: PageView.builder(itemBuilder: ((context, index) => Container())),
      ),
    );
  }
}
