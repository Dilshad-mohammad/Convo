import 'package:json_annotation/json_annotation.dart';

part 'image_model.g.dart';

@JsonSerializable()
class PixelFormImage {
  String id;
  String author;
  String url;

  @JsonKey(name: 'download_url')
  String downloadUrl;

  PixelFormImage({
    required this.downloadUrl,
    required this.id,
    required this.author,
    required this.url,
  });

  /// JSON serialization methods.
  factory PixelFormImage.fromJson(Map<String, dynamic> json) =>
      _$PixelFormImageFromJson(json);

  Map<String, dynamic> toJson() => _$PixelFormImageToJson(this);
}
