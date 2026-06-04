import 'package:dream_messenger_demo/core/failure/failure.dart';
import 'package:dream_messenger_demo/features/chat/domain/entities/message_entity.dart';

abstract class ChatState {}

class ChatInitialState extends ChatState {}

class ChatMessageUpdate extends ChatState {
  final List<MessageEntity> messages;

  ChatMessageUpdate({required this.messages});
}

class ChatError extends ChatState {
  final Failure failure;

  ChatError({required this.failure});
}
