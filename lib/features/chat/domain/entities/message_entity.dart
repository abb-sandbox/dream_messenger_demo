import 'package:dream_messenger_demo/features/chat/data/models/message_model.dart';
import 'package:equatable/equatable.dart';

class MessageEntity extends Equatable {
  final String type;
  final String content;
  final String time;
  final String from;
  final String to;

  const MessageEntity({
    required this.type,
    required this.content,
    required this.time,
    required this.from,
    required this.to,
  });

  @override
  List<Object?> get props => throw UnimplementedError();

  factory MessageEntity.fromModel(MessageModel model) {
    return MessageEntity(
      type: model.type,
      content: model.content,
      time: model.time,
      from: model.from,
      to: model.to,
    );
  }
}
