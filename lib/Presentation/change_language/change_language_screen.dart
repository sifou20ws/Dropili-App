import 'package:dropdown_button2/custom_dropdown_button2.dart';
import 'package:dropili/Presentation/localization/bloc/language_bloc.dart';
import 'package:dropili/common/constant/colors.dart';
import 'package:dropili/common/constant/languages.dart';
import 'package:dropili/common/extensions/translation_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ChangeLanguageScreen extends StatefulWidget {
  const ChangeLanguageScreen({super.key});

  @override
  State<ChangeLanguageScreen> createState() => _ChangeLanguageState();
}

class _ChangeLanguageState extends State<ChangeLanguageScreen> {
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
                DropDownMenueWidget(),
                SizedBox(
                  height: 30,
                ),
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

class DropDownMenueWidget extends StatefulWidget {
  const DropDownMenueWidget({super.key});

  @override
  State<DropDownMenueWidget> createState() => _DropDownMenueWidgetState();
}

class _DropDownMenueWidgetState extends State<DropDownMenueWidget> {
  String _languageValue = 'English';

  @override
  void initState() {
    super.initState();
    getCurrent();
  }

  void getCurrent() {
    String code = Languages.deviceLanguageCode();
    Languages.languages.forEach((element) {
      if (code == element.code) _languageValue = element.value;
    });
  }

  // String getCurrent(){
  // }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(right: 20, left: 20),
      alignment: Alignment.center,
      width: MediaQuery.of(context).size.width * 0.9,
      height: 80,
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
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'Choose Language'.t(context),
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
          ),
          CustomDropdownButton2(
            hint: 'Choose language',
            value: _languageValue,
            iconSize: 17,
            icon: Icon(Icons.list_rounded),
            valueAlignment: Alignment.center,
            dropdownItems: Languages.languages.map((e) => e.value).toList(),
            offset: const Offset(0, -10),
            
            buttonDecoration: BoxDecoration(
              color: Colors.grey[100],
              // color: MalinColors.AppGreen.withAlpha(100),
              borderRadius: BorderRadius.circular(10),
              boxShadow: [
                BoxShadow(
                  color: Color.fromARGB(50, 29, 29, 29),
                  // color: MalinColors.AppGreen.withAlpha(100),
                  offset: Offset(0.0, 2.0),
                  blurRadius: 10,
                ),
              ],
            ),
            onChanged: ((value) {
              Languages.languages.forEach((element) {
                if (value == element.value) {
                  BlocProvider.of<LanguageBloc>(context)
                      .add(ToggleLanguageEvent(element));
                }
                setState(() {
                  _languageValue = value!;
                });
              });
            }),
          ),
        ],
      ),
    );
  }
}
