import 'package:dropili/core/services/safe_convert.dart';


class CostumeBlockResponse {
  final bool success;
  final CustomBlock customBlock;
  final String message;

  CostumeBlockResponse({
    this.success = false,
    required this.customBlock,
    this.message = "",
  });

  factory CostumeBlockResponse.fromJson(Map<String, dynamic>? json) => CostumeBlockResponse(
    success: asBool(json, 'success'),
    customBlock: CustomBlock.fromJson(asMap(json, 'custom_block')),
    message: asString(json, 'message'),
  );

  Map<String, dynamic> toJson() => {
    'success': success,
    'custom_block': customBlock.toJson(),
    'message': message,
  };
}

class CustomBlock {
  final String url;
  final Title title;
  final int userId;
  final String updatedAt;
  final String createdAt;
  final int id;
  final Icon icon;
  final List<MediaItem> media;

  CustomBlock({
    this.url = "",
    required this.title,
    this.userId = 0,
    this.updatedAt = "",
    this.createdAt = "",
    this.id = 0,
    required this.icon,
    required this.media,
  });

  factory CustomBlock.fromJson(Map<String, dynamic>? json) => CustomBlock(
    url: asString(json, 'url'),
    title: Title.fromJson(asMap(json, 'title')),
    userId: asInt(json, 'user_id'),
    updatedAt: asString(json, 'updated_at'),
    createdAt: asString(json, 'created_at'),
    id: asInt(json, 'id'),
    icon: Icon.fromJson(asMap(json, 'icon')),
    media: asList(json, 'media').map((e) => MediaItem.fromJson(e)).toList(),
  );

  Map<String, dynamic> toJson() => {
    'url': url,
    'title': title.toJson(),
    'user_id': userId,
    'updated_at': updatedAt,
    'created_at': createdAt,
    'id': id,
    'icon': icon.toJson(),
    'media': media.map((e) => e.toJson()).toList(),
  };
}

class Title {
  final String ar;
  final String fr;

  Title({
    this.ar = "",
    this.fr = "",
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
    this.modelType = "",
    this.modelId = 0,
    this.uuid = "",
    this.collectionName = "",
    this.name = "",
    this.fileName = "",
    this.mimeType = "",
    this.disk = "",
    this.conversionsDisk = "",
    this.size = 0,
    required this.manipulations,
    required this.customProperties,
    required this.generatedConversions,
    required this.responsiveImages,
    this.orderColumn = 0,
    this.createdAt = "",
    this.updatedAt = "",
    this.originalUrl = "",
    this.previewUrl = "",
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
    this.modelType = "",
    this.modelId = 0,
    this.uuid = "",
    this.collectionName = "",
    this.name = "",
    this.fileName = "",
    this.mimeType = "",
    this.disk = "",
    this.conversionsDisk = "",
    this.size = 0,
    required this.manipulations,
    required this.customProperties,
    required this.generatedConversions,
    required this.responsiveImages,
    this.orderColumn = 0,
    this.createdAt = "",
    this.updatedAt = "",
    this.originalUrl = "",
    this.previewUrl = "",
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


