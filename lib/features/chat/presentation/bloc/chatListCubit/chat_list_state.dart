import 'package:dream_messenger_demo/core/failure/failure.dart';
import 'package:dream_messenger_demo/features/chat/domain/entities/online_user_entity.dart';

abstract class ChatListState {}

class ChatListInitialState extends ChatListState {
  List<OnlineUserEntity> onlineUsers = [];

  ChatListInitialState();
}

class ChatListUpdated extends ChatListState {
  List<OnlineUserEntity> onlineUsers;

  ChatListUpdated({required this.onlineUsers});
}

class ChatListLoading extends ChatListState {}

class ChatListError extends ChatListState {
  final Failure failure;

  ChatListError({required this.failure});
}
