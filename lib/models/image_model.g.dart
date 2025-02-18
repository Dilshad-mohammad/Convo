// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'image_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PixelFormImage _$PixelFormImageFromJson(Map<String, dynamic> json) =>
    PixelFormImage(
      downloadUrl: json['download_url'] as String,
      id: json['id'] as String,
      author: json['author'] as String,
      url: json['url'] as String,
    );

Map<String, dynamic> _$PixelFormImageToJson(PixelFormImage instance) =>
    <String, dynamic>{
      'id': instance.id,
      'author': instance.author,
      'url': instance.url,
      'download_url': instance.downloadUrl,
    };
