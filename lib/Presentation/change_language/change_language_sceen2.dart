import 'package:dropili/common/constant/colors.dart';
import 'package:dropili/common/extensions/translation_extension.dart';
import 'package:flutter/material.dart';
import 'package:dropili/Presentation/localization/bloc/language_bloc.dart';
import 'package:dropili/common/constant/languages.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LanguageChangeScreen extends StatefulWidget {
  const LanguageChangeScreen({super.key});

  @override
  State<LanguageChangeScreen> createState() => _LanguageChangeScreenState();
}

class _LanguageChangeScreenState extends State<LanguageChangeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.only(bottom: 20),
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          // padding: EdgeInsets.only(left: 100, right: 100),
          decoration: BoxDecoration(
              color: Colors.white,
              image: DecorationImage(
                  image: AssetImage('assets/Background.png'),
                  fit: BoxFit.cover)),
          child: SafeArea(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                SizedBox(
                  height: 20,
                ),
                Row(
                  children: [
                    SizedBox(
                      width: 20,
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Icon(
                        Icons.arrow_back_ios_new,
                        color: Colors.white,
                        size: 30,
                      ),
                    )
                  ],
                ),
                Spacer(),
                Text(
                  'Change Language'.t(context),
                  style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.w500,
                      color: Colors.white),
                ),
                SizedBox(
                  height: 20,
                ),
                SizedBox(
                  height: 30,
                ),
                LanguageListWidget(),
                Spacer(),
                SizedBox(
                  height: 200,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class LanguageListWidget extends StatefulWidget {
  const LanguageListWidget({super.key});

  @override
  State<LanguageListWidget> createState() => _LanguageListWidgetState();
}

class _LanguageListWidgetState extends State<LanguageListWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 25, right: 25, left: 25, bottom: 20),
      alignment: Alignment.center,
      width: MediaQuery.of(context).size.width * 0.9,
      // height: 300,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Color.fromARGB(50, 29, 29, 29),
            offset: Offset(0.0, 2.0),
            blurRadius: 10,
          ),
        ],
      ),
      child: Column(
        children: [
          Text(
            'Choose Language'.t(context),
            style: TextStyle(
              fontSize: 19,
              fontWeight: FontWeight.w400,
            ),
          ),
          SizedBox(
            height: 20,
          ),
          ListView.builder(
            physics: NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: Languages.languages.length,
            itemBuilder: (context, index) {
              bool selected = Languages.languages[index].code ==
                  Localizations.localeOf(context).languageCode.toLowerCase();

              return GestureDetector(
                onTap: () async {
                  if (selected) {
                    return;
                  }
                  BlocProvider.of<LanguageBloc>(context)
                      .add(ToggleLanguageEvent(Languages.languages[index]));
                  await Future.delayed(Duration(milliseconds: 300));
                  Navigator.pop(context);
                },
                child: Container(
                  margin: EdgeInsets.all(10),
                  alignment: Alignment.center,
                  height: 60,
                  decoration: BoxDecoration(
                    color: MalinColors.cardsColor,
                    border: selected
                        ? Border.all(color: MalinColors.AppGreen, width: 3)
                        // : null,
                        : Border.all(color: Colors.grey.shade300, width: 0.5),
                    borderRadius: BorderRadius.circular(15),
                    // boxShadow: [
                    //   BoxShadow(
                    //       color: Color.fromARGB(20, 29, 29, 29),
                    //       offset: Offset(8, 8.0),
                    //       blurRadius: 10,
                    //       spreadRadius: 5),
                    // ],
                  ),
                  child: Text(
                    Languages.languages[index].value,
                    style: TextStyle(
                      color: Colors.grey.shade900,
                      fontSize: 20,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
