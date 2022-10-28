

import 'package:dropili/core/services/safe_convert.dart';

class GetBlocksModel {
  final List<dynamic> userBlocks;
  final List<BlocksItem> blocks;
  final Types types;

  GetBlocksModel({
    required this.userBlocks,
    required this.blocks,
    required this.types,
  });

  factory GetBlocksModel.fromJson(Map<String, dynamic>? json) => GetBlocksModel(
    userBlocks: asList(json, 'user-blocks').map((e) => e.toString()).toList(),
    blocks: asList(json, 'blocks').map((e) => BlocksItem.fromJson(e)).toList(),
    types: Types.fromJson(asMap(json, 'types')),
  );

  Map<String, dynamic> toJson() => {
    'user-blocks': userBlocks.map((e) => e).toList(),
    'blocks': blocks.map((e) => e.toJson()).toList(),
    'types': types.toJson(),
  };

}

class BlocksItem {
  final int id;
  final Title title;
  final Hint hint;
  final int type;
  final int active;
  final int order;
  final String createdAt;
  final String updatedAt;
  final mIcon icon;
  final List<MediaItem> media;

  BlocksItem({
    this.id = 0,
    required this.title,
    required this.hint,
    this.type = 0,
    this.active = 0,
    this.order = 0,
    this.createdAt = "",
    this.updatedAt = "",
    required this.icon,
    required this.media,
  });

  factory BlocksItem.fromJson(Map<String, dynamic>? json) => BlocksItem(
    id: asInt(json, 'id'),
    title: Title.fromJson(asMap(json, 'title')),
    hint: Hint.fromJson(asMap(json, 'hint')),
    type: asInt(json, 'type'),
    active: asInt(json, 'active'),
    order: asInt(json, 'order'),
    createdAt: asString(json, 'created_at'),
    updatedAt: asString(json, 'updated_at'),
    icon: mIcon.fromJson(asMap(json, 'icon')),
    media: asList(json, 'media').map((e) => MediaItem.fromJson(e)).toList(),

  );

  Map<String, dynamic> toJson() => {
    'id': id,
    'title': title.toJson(),
    'hint': hint.toJson(),
    'type': type,
    'active': active,
    'order': order,
    'created_at': createdAt,
    'updated_at': updatedAt,
    'icon': icon.toJson(),
    'media': media.map((e) => e.toJson()).toList(),
    'icon_&^#': icon,
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


class Hint {
  final String ar;
  final String fr;

  Hint({
    this.ar = "",
    this.fr = "",
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


class mIcon {
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

  mIcon({
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

  factory mIcon.fromJson(Map<String, dynamic>? json) => mIcon(
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

class Types {
  final String one;
  final String two;
  final String three;
  final String four;

  Types({
    this.one = "",
    this.two = "",
    this.three = "",
    this.four = "",
  });

  factory Types.fromJson(Map<String, dynamic>? json) => Types(
    one: asString(json, '1'),
    two: asString(json, '2'),
    three: asString(json, '3'),
    four: asString(json, '4'),
  );

  Map<String, dynamic> toJson() => {
    '1': one,
    '2': two,
    '3': three,
    '4': four,
  };
}

