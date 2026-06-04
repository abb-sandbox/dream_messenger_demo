import 'package:dream_messenger_demo/features/chat/domain/entities/message_entity.dart';

class MessageModel extends MessageEntity {
  const MessageModel({
    required super.type,
    required super.content,
    required super.time,
    required super.from,
    required super.to,
  });

  factory MessageModel.fromJson(Map<dynamic, dynamic> json) {
    return MessageModel(
      type: json['type'] ?? "",
      content: json['content'] ?? "",
      time: json['time'] ?? "",
      from: json['from'] ?? "",
      to: json['to'] ?? "",
    );
  }

  Map<String, String> toJson() {
    return {
      'type': type,
      'content': content,
      'time': time,
      'from': from,
      'to': to,
    };
  }

  factory MessageModel.fromEntity(MessageEntity entity) {
    return MessageModel(
      type: entity.type,
      content: entity.content,
      time: entity.time,
      from: entity.from,
      to: entity.to,
    );
  }
}
