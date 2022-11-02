import 'package:dropili/core/services/safe_convert.dart';
class PostUserProfile {
  //final String background;
  //final String profile;
  final String name;
  final String description;

  PostUserProfile({
    //this.background="",
    //this.profile = "",
    required this.name ,
    this.description = "",
  });

  factory PostUserProfile.fromJson(Map<String, dynamic>? json) => PostUserProfile(
    //background: asString(json, 'background'),
    //profile: asString(json, 'profile'),
    name: asString(json, 'name'),
    description: asString(json, 'description'),
  );

  Map<String, dynamic> toJson() => {
    //'background': background,
    //'profile': profile,
    'name': name,
    'description': description,
  };
}

