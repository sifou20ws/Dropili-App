import 'package:dropili/core/services/safe_convert.dart';


class GetCostumeBlocksResponse {
  final List<CustomBlocksItem> customBlocks;

  GetCostumeBlocksResponse({
    required this.customBlocks,
  });

  factory GetCostumeBlocksResponse.fromJson(Map<String, dynamic>? json) => GetCostumeBlocksResponse(
    customBlocks: asList(json, 'customBlocks').map((e) => CustomBlocksItem.fromJson(e)).toList(),
  );

  Map<String, dynamic> toJson() => {
    'customBlocks': customBlocks.map((e) => e.toJson()).toList(),
  };
}

class CustomBlocksItem {
  final int id;
  final Title title;
  final String url;
  final int active;
  final dynamic data;
  final int userId;
  final String createdAt;
  final String updatedAt;
  final CostumeIcon? icon;
  final List<MediaItem> media;

  CustomBlocksItem({
    this.id = 0,
    required this.title,
    this.url = "",
    this.active = 0,
    this.data,
    this.userId = 0,
    this.createdAt = "",
    this.updatedAt = "",
    required this.icon,
    required this.media,
  });

  factory CustomBlocksItem.fromJson(Map<String, dynamic>? json) => CustomBlocksItem(
    id: asInt(json, 'id'),
    title: Title.fromJson(asMap(json, 'title')),
    url: asString(json, 'url'),
    active: asInt(json, 'active'),
    data: asString(json, 'data'),
    userId: asInt(json, 'user_id'),
    createdAt: asString(json, 'created_at'),
    updatedAt: asString(json, 'updated_at'),
    icon: CostumeIcon.fromJson(asMap(json, 'icon')),
    media: asList(json, 'media').map((e) => MediaItem.fromJson(e)).toList(),
  );

  Map<String, dynamic> toJson() => {
    'id': id,
    'title': title.toJson(),
    'url': url,
    'active': active,
    'data': data,
    'user_id': userId,
    'created_at': createdAt,
    'updated_at': updatedAt,
    'icon': icon!.toJson(),
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


class CostumeIcon {
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

  CostumeIcon({
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

  factory CostumeIcon.fromJson(Map<String, dynamic>? json) => CostumeIcon(
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


