import 'package:json_annotation/json_annotation.dart';

part 'messagebody.g.dart';

@JsonSerializable(explicitToJson: true, includeIfNull: false)
class MessageBody {
  String messageText;

  MessageBody({this.messageText});


  factory MessageBody.fromJson(Map<String, dynamic> json) => _$MessageBodyFromJson(json);
  Map<String, dynamic> toJson() => _$MessageBodyToJson(this);
}
