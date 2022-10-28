import 'package:dropili/core/services/safe_convert.dart';

class PostUserBlocks {
  final int id;
  final String url;

  PostUserBlocks({
    this.id = 0,
    this.url = "",
  });

  factory PostUserBlocks.fromJson(Map<String, dynamic>? json) => PostUserBlocks(
    id: asInt(json, 'id'),
    url: asString(json, 'url'),
  );

  Map<String, dynamic> toJson() => {
    'id': id,
    'url': url,
  };
}

