import 'package:json_annotation/json_annotation.dart';

part 'image.g.dart';

@JsonSerializable(explicitToJson: true, includeIfNull: false)
class ImageData {
  num id;
  String name;
  String mimeType;
  num size;

  ImageData({this.id, this.name, this.mimeType, this.size});

  factory ImageData.fromJson(Map<String, dynamic> json) =>
      _$ImageDataFromJson(json);
  Map<String, dynamic> toJson() => _$ImageDataToJson(this);
}
