import 'package:dropili/core/services/safe_convert.dart';

class PostProfileResp {
  final bool success;
  final User user;
  final String message;

 PostProfileResp({
    this.success = false,
    required this.user,
    this.message = '',
  });

  factory PostProfileResp.fromJson(Map<String, dynamic>? json) => PostProfileResp(
    success: asBool(json, 'success'),
    user: User.fromJson(asMap(json, 'user')),
    message: asString(json, 'message'),
  );

  Map<String, dynamic> toJson() => {
    'success': success,
    'user': user.toJson(),
    'message': message,
  };
}

class User {
  final int id;
  final String name;
  final String email;
  final dynamic emailVerifiedAt;
  final bool active;
  final dynamic description;
  final String lang;
  final bool directOnMe;
  final dynamic url;
  final dynamic profilePhotoPath;
  final String createdAt;
  final String updatedAt;
  final UserProfile userProfile;
  final UserBackground userBackground;
  final List<MediaItem> media;

  User({
    this.id = 0,
    this.name = '',
    this.email = '',
    this.emailVerifiedAt,
    this.active = false,
    this.description,
    this.lang = '',
    this.directOnMe = false,
    this.url,
    this.profilePhotoPath,
    this.createdAt = '',
    this.updatedAt = '',
    required this.userProfile,
    required this.userBackground,
    required this.media,
  });

  factory User.fromJson(Map<String, dynamic>? json) => User(
    id: asInt(json, 'id'),
    name: asString(json, 'name'),
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
    media: asList(json, 'media').map((e) => MediaItem.fromJson(e)).toList(),
  );

  Map<String, dynamic> toJson() => {
    'id': id,
    'name': name,
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
    manipulations: asList(json, 'manipulations').map((e) => e.toString()).toList(),
    customProperties: asList(json, 'custom_properties').map((e) => e.toString()).toList(),
    generatedConversions: GeneratedConversions.fromJson(asMap(json, 'generated_conversions')),
    responsiveImages: asList(json, 'responsive_images').map((e) => e.toString()).toList(),
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

  factory GeneratedConversions.fromJson(Map<String, dynamic>? json) => GeneratedConversions(
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
    manipulations: asList(json, 'manipulations').map((e) => e.toString()).toList(),
    customProperties: asList(json, 'custom_properties').map((e) => e.toString()).toList(),
    generatedConversions: GeneratedConversions.fromJson(asMap(json, 'generated_conversions')),
    responsiveImages: asList(json, 'responsive_images').map((e) => e.toString()).toList(),
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
    manipulations: asList(json, 'manipulations').map((e) => e.toString()).toList(),
    customProperties: asList(json, 'custom_properties').map((e) => e.toString()).toList(),
    generatedConversions: GeneratedConversions.fromJson(asMap(json, 'generated_conversions')),
    responsiveImages: asList(json, 'responsive_images').map((e) => e.toString()).toList(),
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