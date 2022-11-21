import 'package:dropili/Presentation/home/EditProfilePage/bloc/editProfileScreen_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class EditProfileTextWidget extends StatefulWidget {
  final name , description;
  const EditProfileTextWidget({ this.name, this.description});

  @override
  State<EditProfileTextWidget> createState() => _EditProfileMediaWidgetState();
}

class _EditProfileMediaWidgetState extends State<EditProfileTextWidget> {
  @override
  Widget build(BuildContext context) {
    BlocProvider.of<EditProfileBloc>(context)
        .add(PostUserNameEvent(name: widget.name));

    BlocProvider.of<EditProfileBloc>(context)
        .add(PostDescriptionEvent(description: widget.description));
    return Column(
      children: [
        SizedBox(height: 15),
        TextFormField(
          //controller:TextEditingController(text: widget.name),
          initialValue: widget.name,
          onChanged: (value) {
            BlocProvider.of<EditProfileBloc>(context)
                .add(PostUserNameEvent(name: value));
          },
          decoration: buildInputDecoration(hint: 'Nom' , name: true),
        ),
        SizedBox(height: 15),
        TextFormField(
          initialValue: widget.description,
          onChanged: (value) {
            BlocProvider.of<EditProfileBloc>(context)
                .add(PostDescriptionEvent(description: value));
          },
          decoration: buildInputDecoration(hint:'A propos de moi'),
          maxLines: 4,
        ),
      ],
    );
  }

  InputDecoration buildInputDecoration({required String hint, bool name=false ,String text=''}) {
    return InputDecoration(
        errorText: name
            ? BlocProvider.of<EditProfileBloc>(context).state.valideName
                ? null
                : 'Value Can\'t Be Empty'
            : null,
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(7),
          borderSide: BorderSide.none,
        ),
        filled: true,
        fillColor: Color.fromARGB(50, 166, 166, 166),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(7),
          borderSide: BorderSide.none,
        ),
        //border: OutlineInputBorder(),
        border: InputBorder.none,
        errorBorder: InputBorder.none,
        disabledBorder: InputBorder.none,

        hintText: hint,
        hintStyle: TextStyle(color: Colors.grey));
  }
}
