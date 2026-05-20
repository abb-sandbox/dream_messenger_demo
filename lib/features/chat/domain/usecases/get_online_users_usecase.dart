import 'dart:async';
import 'package:dream_messenger_demo/core/usecases/usecase.dart';
import 'package:dream_messenger_demo/features/chat/domain/entities/online_user_entity.dart';

import '../repositories/chat_repository.dart';

class GetOnlineUsersUseCase extends UseCase<StreamController<OnlineUserEntity>, Null> {
  final ChatRepository chatRepository;

  GetOnlineUsersUseCase({required this.chatRepository});

  @override
  Future<StreamController<OnlineUserEntity>> call(Null params) async {
    final result = await chatRepository.getOnlineUsers();
    return result.fold((failure) => throw failure, (controller) {
      return controller;
    });
  }
}
