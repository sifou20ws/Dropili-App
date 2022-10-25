import 'package:dropili/common/extensions/translation_extension.dart';
import 'package:flutter/material.dart';

class ThirdPage extends StatelessWidget {
  const ThirdPage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      // padding: EdgeInsets.only(left: , right: 90),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 120, right: 120),
            child: Image(image: AssetImage('assets/dropili.png')),
          ),
          SizedBox(
            height: 50,
          ),
          SizedBox(
              height: 55,
              width: MediaQuery.of(context).size.width * 0.7,
              child: ElevatedButton(
                onPressed: () {
                  // BlocProvider.of<LanguageBloc>(context)
                  //     .add(ToggleLanguageEvent(Languages.languages[1]));
                  Navigator.pushReplacementNamed(context, '/signin');
                },
                child: Text(
                  'Signin'.t(context),
                  style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 19,
                      color: Color.fromARGB(255, 0, 123, 206)),
                ),
                style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15))),
              )),
          SizedBox(
            height: 20,
          ),
          SizedBox(
              height: 55,
              width: MediaQuery.of(context).size.width * 0.7,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pushReplacementNamed(context, '/register');
                },
                child: Text(
                  'Signup'.t(context),
                  style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 19,
                      color: Color.fromARGB(255, 0, 123, 206)),
                ),
                style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15))),
              )),
        ],
        // child: PageView.builder(itemBuilder: ((context, index) => Container())),
      ),
    );
  }
}
