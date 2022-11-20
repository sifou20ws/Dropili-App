import 'package:dropili/core/services/safe_convert.dart';
import 'package:dropili/data/models/get_blocks_model.dart';

class GetFriendsModel {
  final List<FriendsItem> friends;

  GetFriendsModel({
    required this.friends,
  });

  factory GetFriendsModel.fromJson(Map<String, dynamic>? json) =>
      GetFriendsModel(
        friends: asList(json, 'friends')
            .map((e) => FriendsItem.fromJson(e))
            .toList(),
      );

  Map<String, dynamic> toJson() => {
        'friends': friends.map((e) => e.toJson()).toList(),
      };
}

class FriendsItem {
  final int id;
  final String name;
  final String username;
  final String email;
  final dynamic emailVerifiedAt;
  final bool active;
  final String description;
  final String lang;
  final bool directOnMe;
  final dynamic url;
  final dynamic profilePhotoPath;
  final String createdAt;
  final String updatedAt;
  final UserProfile userProfile;
  final UserBackground userBackground;
  final Pivot pivot;
  final List<UserBlocksItem> blocks;
  final List<dynamic> customBlocks;
  final List<MediaItem> media;

  FriendsItem({
    this.id = 0,
    this.name = '',
    this.username = '',
    this.email = '',
    this.emailVerifiedAt,
    this.active = false,
    this.description = '',
    this.lang = '',
    this.directOnMe = false,
    this.url,
    this.profilePhotoPath,
    this.createdAt = '',
    this.updatedAt = '',
    required this.userProfile,
    required this.userBackground,
    required this.pivot,
    required this.blocks,
    required this.customBlocks,
    required this.media,
  });

  factory FriendsItem.fromJson(Map<String, dynamic>? json) => FriendsItem(
        id: asInt(json, 'id'),
        name: asString(json, 'name'),
        username: asString(json, 'username'),
        email: asString(json, 'email'),
        emailVerifiedAt: asString(json, 'email_verified_at'),
        active: asBool(json, 'active'),
        description: asString(json, 'description'),
        lang: asString(json, 'lang'),
        directOnMe: asBool(json, 'direct_on_me'),
        url: asString(json, 'url'),
        profilePhotoPath: asString(json, 'profile_photo_path'),
        createdAt: asString(json, 'created_at'),
        updatedAt: asString(json, 'updated_at'),
        userProfile: UserProfile.fromJson(asMap(json, 'user_profile')),
        userBackground: UserBackground.fromJson(asMap(json, 'user_background')),
        pivot: Pivot.fromJson(asMap(json, 'pivot')),
        blocks: asList(json, 'blocks')
            .map((e) => UserBlocksItem.fromJson(e))
            .toList(),
        customBlocks:
            asList(json, 'custom_blocks').map((e) => e.toString()).toList(),
        media: asList(json, 'media').map((e) => MediaItem.fromJson(e)).toList(),
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'username': username,
        'email': email,
        'email_verified_at': emailVerifiedAt,
        'active': active,
        'description': description,
        'lang': lang,
        'direct_on_me': directOnMe,
        'url': url,
        'profile_photo_path': profilePhotoPath,
        'created_at': createdAt,
        'updated_at': updatedAt,
        'user_profile': userProfile.toJson(),
        'user_background': userBackground.toJson(),
        'pivot': pivot.toJson(),
        'blocks': blocks.map((e) => e.toJson()).toList(),
        'custom_blocks': customBlocks.map((e) => e).toList(),
        'media': media.map((e) => e.toJson()).toList(),
      };
}

class UserProfile {
  final int id;
  final String modelType;
  final int modelId;
  final String uuid;
  final String collectionName;
  final String name;
  final String fileName;
  final String mimeType;
  final String disk;
  final String conversionsDisk;
  final int size;
  final List<dynamic> manipulations;
  final List<dynamic> customProperties;
  final GeneratedConversions generatedConversions;
  final List<dynamic> responsiveImages;
  final int orderColumn;
  final String createdAt;
  final String updatedAt;
  final String originalUrl;
  final String previewUrl;

  UserProfile({
    this.id = 0,
    this.modelType = '',
    this.modelId = 0,
    this.uuid = '',
    this.collectionName = '',
    this.name = '',
    this.fileName = '',
    this.mimeType = '',
    this.disk = '',
    this.conversionsDisk = '',
    this.size = 0,
    required this.manipulations,
    required this.customProperties,
    required this.generatedConversions,
    required this.responsiveImages,
    this.orderColumn = 0,
    this.createdAt = '',
    this.updatedAt = '',
    this.originalUrl = '',
    this.previewUrl = '',
  });

  factory UserProfile.fromJson(Map<String, dynamic>? json) => UserProfile(
        id: asInt(json, 'id'),
        modelType: asString(json, 'model_type'),
        modelId: asInt(json, 'model_id'),
        uuid: asString(json, 'uuid'),
        collectionName: asString(json, 'collection_name'),
        name: asString(json, 'name'),
        fileName: asString(json, 'file_name'),
        mimeType: asString(json, 'mime_type'),
        disk: asString(json, 'disk'),
        conversionsDisk: asString(json, 'conversions_disk'),
        size: asInt(json, 'size'),
        manipulations:
            asList(json, 'manipulations').map((e) => e.toString()).toList(),
        customProperties:
            asList(json, 'custom_properties').map((e) => e.toString()).toList(),
        generatedConversions:
            GeneratedConversions.fromJson(asMap(json, 'generated_conversions')),
        responsiveImages:
            asList(json, 'responsive_images').map((e) => e.toString()).toList(),
        orderColumn: asInt(json, 'order_column'),
        createdAt: asString(json, 'created_at'),
        updatedAt: asString(json, 'updated_at'),
        originalUrl: asString(json, 'original_url'),
        previewUrl: asString(json, 'preview_url'),
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'model_type': modelType,
        'model_id': modelId,
        'uuid': uuid,
        'collection_name': collectionName,
        'name': name,
        'file_name': fileName,
        'mime_type': mimeType,
        'disk': disk,
        'conversions_disk': conversionsDisk,
        'size': size,
        'manipulations': manipulations.map((e) => e).toList(),
        'custom_properties': customProperties.map((e) => e).toList(),
        'generated_conversions': generatedConversions.toJson(),
        'responsive_images': responsiveImages.map((e) => e).toList(),
        'order_column': orderColumn,
        'created_at': createdAt,
        'updated_at': updatedAt,
        'original_url': originalUrl,
        'preview_url': previewUrl,
      };
}

class GeneratedConversions {
  final bool preview;

  GeneratedConversions({
    this.preview = false,
  });

  factory GeneratedConversions.fromJson(Map<String, dynamic>? json) =>
      GeneratedConversions(
        preview: asBool(json, 'preview'),
      );

  Map<String, dynamic> toJson() => {
        'preview': preview,
      };
}

class UserBackground {
  final int id;
  final String modelType;
  final int modelId;
  final String uuid;
  final String collectionName;
  final String name;
  final String fileName;
  final String mimeType;
  final String disk;
  final String conversionsDisk;
  final int size;
  final List<dynamic> manipulations;
  final List<dynamic> customProperties;
  final GeneratedConversions generatedConversions;
  final List<dynamic> responsiveImages;
  final int orderColumn;
  final String createdAt;
  final String updatedAt;
  final String originalUrl;
  final String previewUrl;

  UserBackground({
    this.id = 0,
    this.modelType = '',
    this.modelId = 0,
    this.uuid = '',
    this.collectionName = '',
    this.name = '',
    this.fileName = '',
    this.mimeType = '',
    this.disk = '',
    this.conversionsDisk = '',
    this.size = 0,
    required this.manipulations,
    required this.customProperties,
    required this.generatedConversions,
    required this.responsiveImages,
    this.orderColumn = 0,
    this.createdAt = '',
    this.updatedAt = '',
    this.originalUrl = '',
    this.previewUrl = '',
  });

  factory UserBackground.fromJson(Map<String, dynamic>? json) => UserBackground(
        id: asInt(json, 'id'),
        modelType: asString(json, 'model_type'),
        modelId: asInt(json, 'model_id'),
        uuid: asString(json, 'uuid'),
        collectionName: asString(json, 'collection_name'),
        name: asString(json, 'name'),
        fileName: asString(json, 'file_name'),
        mimeType: asString(json, 'mime_type'),
        disk: asString(json, 'disk'),
        conversionsDisk: asString(json, 'conversions_disk'),
        size: asInt(json, 'size'),
        manipulations:
            asList(json, 'manipulations').map((e) => e.toString()).toList(),
        customProperties:
            asList(json, 'custom_properties').map((e) => e.toString()).toList(),
        generatedConversions:
            GeneratedConversions.fromJson(asMap(json, 'generated_conversions')),
        responsiveImages:
            asList(json, 'responsive_images').map((e) => e.toString()).toList(),
        orderColumn: asInt(json, 'order_column'),
        createdAt: asString(json, 'created_at'),
        updatedAt: asString(json, 'updated_at'),
        originalUrl: asString(json, 'original_url'),
        previewUrl: asString(json, 'preview_url'),
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'model_type': modelType,
        'model_id': modelId,
        'uuid': uuid,
        'collection_name': collectionName,
        'name': name,
        'file_name': fileName,
        'mime_type': mimeType,
        'disk': disk,
        'conversions_disk': conversionsDisk,
        'size': size,
        'manipulations': manipulations.map((e) => e).toList(),
        'custom_properties': customProperties.map((e) => e).toList(),
        'generated_conversions': generatedConversions.toJson(),
        'responsive_images': responsiveImages.map((e) => e).toList(),
        'order_column': orderColumn,
        'created_at': createdAt,
        'updated_at': updatedAt,
        'original_url': originalUrl,
        'preview_url': previewUrl,
      };
}

class Pivot {
  final int userId;
  final int friendId;

  Pivot({
    this.userId = 0,
    this.friendId = 0,
  });

  factory Pivot.fromJson(Map<String, dynamic>? json) => Pivot(
        userId: asInt(json, 'user_id'),
        friendId: asInt(json, 'friend_id'),
      );

  Map<String, dynamic> toJson() => {
        'user_id': userId,
        'friend_id': friendId,
      };
}

// class BlocksItem {
//   final int id;
//   final Title title;
//   final Hint hint;
//   final int type;
//   final int active;
//   final int order;
//   final String createdAt;
//   final String updatedAt;
//   final Icon icon;
//   final Pivot pivot;
//   final List<MediaItem> media;

//   BlocksItem({
//     this.id = 0,
//     required this.title,
//     required this.hint,
//     this.type = 0,
//     this.active = 0,
//     this.order = 0,
//     this.createdAt = '',
//     this.updatedAt = '',
//     required this.icon,
//     required this.pivot,
//     required this.media,
//   });

//   factory BlocksItem.fromJson(Map<String, dynamic>? json) => BlocksItem(
//         id: asInt(json, 'id'),
//         title: Title.fromJson(asMap(json, 'title')),
//         hint: Hint.fromJson(asMap(json, 'hint')),
//         type: asInt(json, 'type'),
//         active: asInt(json, 'active'),
//         order: asInt(json, 'order'),
//         createdAt: asString(json, 'created_at'),
//         updatedAt: asString(json, 'updated_at'),
//         icon: Icon.fromJson(asMap(json, 'icon')),
//         pivot: Pivot.fromJson(asMap(json, 'pivot')),
//         media: asList(json, 'media').map((e) => MediaItem.fromJson(e)).toList(),
//       );

//   Map<String, dynamic> toJson() => {
//         'id': id,
//         'title': title.toJson(),
//         'hint': hint.toJson(),
//         'type': type,
//         'active': active,
//         'order': order,
//         'created_at': createdAt,
//         'updated_at': updatedAt,
//         'icon': icon.toJson(),
//         'pivot': pivot.toJson(),
//         'media': media.map((e) => e.toJson()).toList(),
//       };
// }

class Title {
  final String ar;
  final String fr;

  Title({
    this.ar = '',
    this.fr = '',
  });

  factory Title.fromJson(Map<String, dynamic>? json) => Title(
        ar: asString(json, 'ar'),
        fr: asString(json, 'fr'),
      );

  Map<String, dynamic> toJson() => {
        'ar': ar,
        'fr': fr,
      };
}

class Hint {
  final String ar;
  final String fr;

  Hint({
    this.ar = '',
    this.fr = '',
  });

  factory Hint.fromJson(Map<String, dynamic>? json) => Hint(
        ar: asString(json, 'ar'),
        fr: asString(json, 'fr'),
      );

  Map<String, dynamic> toJson() => {
        'ar': ar,
        'fr': fr,
      };
}

class Icon {
  final int id;
  final String modelType;
  final int modelId;
  final String uuid;
  final String collectionName;
  final String name;
  final String fileName;
  final String mimeType;
  final String disk;
  final String conversionsDisk;
  final int size;
  final List<dynamic> manipulations;
  final List<dynamic> customProperties;
  final GeneratedConversions generatedConversions;
  final List<dynamic> responsiveImages;
  final int orderColumn;
  final String createdAt;
  final String updatedAt;
  final String originalUrl;
  final String previewUrl;

  Icon({
    this.id = 0,
    this.modelType = '',
    this.modelId = 0,
    this.uuid = '',
    this.collectionName = '',
    this.name = '',
    this.fileName = '',
    this.mimeType = '',
    this.disk = '',
    this.conversionsDisk = '',
    this.size = 0,
    required this.manipulations,
    required this.customProperties,
    required this.generatedConversions,
    required this.responsiveImages,
    this.orderColumn = 0,
    this.createdAt = '',
    this.updatedAt = '',
    this.originalUrl = '',
    this.previewUrl = '',
  });

  factory Icon.fromJson(Map<String, dynamic>? json) => Icon(
        id: asInt(json, 'id'),
        modelType: asString(json, 'model_type'),
        modelId: asInt(json, 'model_id'),
        uuid: asString(json, 'uuid'),
        collectionName: asString(json, 'collection_name'),
        name: asString(json, 'name'),
        fileName: asString(json, 'file_name'),
        mimeType: asString(json, 'mime_type'),
        disk: asString(json, 'disk'),
        conversionsDisk: asString(json, 'conversions_disk'),
        size: asInt(json, 'size'),
        manipulations:
            asList(json, 'manipulations').map((e) => e.toString()).toList(),
        customProperties:
            asList(json, 'custom_properties').map((e) => e.toString()).toList(),
        generatedConversions:
            GeneratedConversions.fromJson(asMap(json, 'generated_conversions')),
        responsiveImages:
            asList(json, 'responsive_images').map((e) => e.toString()).toList(),
        orderColumn: asInt(json, 'order_column'),
        createdAt: asString(json, 'created_at'),
        updatedAt: asString(json, 'updated_at'),
        originalUrl: asString(json, 'original_url'),
        previewUrl: asString(json, 'preview_url'),
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'model_type': modelType,
        'model_id': modelId,
        'uuid': uuid,
        'collection_name': collectionName,
        'name': name,
        'file_name': fileName,
        'mime_type': mimeType,
        'disk': disk,
        'conversions_disk': conversionsDisk,
        'size': size,
        'manipulations': manipulations.map((e) => e).toList(),
        'custom_properties': customProperties.map((e) => e).toList(),
        'generated_conversions': generatedConversions.toJson(),
        'responsive_images': responsiveImages.map((e) => e).toList(),
        'order_column': orderColumn,
        'created_at': createdAt,
        'updated_at': updatedAt,
        'original_url': originalUrl,
        'preview_url': previewUrl,
      };
}

class MediaItem {
  final int id;
  final String modelType;
  final int modelId;
  final String uuid;
  final String collectionName;
  final String name;
  final String fileName;
  final String mimeType;
  final String disk;
  final String conversionsDisk;
  final int size;
  final List<dynamic> manipulations;
  final List<dynamic> customProperties;
  final GeneratedConversions generatedConversions;
  final List<dynamic> responsiveImages;
  final int orderColumn;
  final String createdAt;
  final String updatedAt;
  final String originalUrl;
  final String previewUrl;

  MediaItem({
    this.id = 0,
    this.modelType = '',
    this.modelId = 0,
    this.uuid = '',
    this.collectionName = '',
    this.name = '',
    this.fileName = '',
    this.mimeType = '',
    this.disk = '',
    this.conversionsDisk = '',
    this.size = 0,
    required this.manipulations,
    required this.customProperties,
    required this.generatedConversions,
    required this.responsiveImages,
    this.orderColumn = 0,
    this.createdAt = '',
    this.updatedAt = '',
    this.originalUrl = '',
    this.previewUrl = '',
  });

  factory MediaItem.fromJson(Map<String, dynamic>? json) => MediaItem(
        id: asInt(json, 'id'),
        modelType: asString(json, 'model_type'),
        modelId: asInt(json, 'model_id'),
        uuid: asString(json, 'uuid'),
        collectionName: asString(json, 'collection_name'),
        name: asString(json, 'name'),
        fileName: asString(json, 'file_name'),
        mimeType: asString(json, 'mime_type'),
        disk: asString(json, 'disk'),
        conversionsDisk: asString(json, 'conversions_disk'),
        size: asInt(json, 'size'),
        manipulations:
            asList(json, 'manipulations').map((e) => e.toString()).toList(),
        customProperties:
            asList(json, 'custom_properties').map((e) => e.toString()).toList(),
        generatedConversions:
            GeneratedConversions.fromJson(asMap(json, 'generated_conversions')),
        responsiveImages:
            asList(json, 'responsive_images').map((e) => e.toString()).toList(),
        orderColumn: asInt(json, 'order_column'),
        createdAt: asString(json, 'created_at'),
        updatedAt: asString(json, 'updated_at'),
        originalUrl: asString(json, 'original_url'),
        previewUrl: asString(json, 'preview_url'),
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'model_type': modelType,
        'model_id': modelId,
        'uuid': uuid,
        'collection_name': collectionName,
        'name': name,
        'file_name': fileName,
        'mime_type': mimeType,
        'disk': disk,
        'conversions_disk': conversionsDisk,
        'size': size,
        'manipulations': manipulations.map((e) => e).toList(),
        'custom_properties': customProperties.map((e) => e).toList(),
        'generated_conversions': generatedConversions.toJson(),
        'responsive_images': responsiveImages.map((e) => e).toList(),
        'order_column': orderColumn,
        'created_at': createdAt,
        'updated_at': updatedAt,
        'original_url': originalUrl,
        'preview_url': previewUrl,
      };
}
