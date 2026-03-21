import 'package:dartz/dartz.dart';
import 'package:dream_messenger_demo/core/failure/failure.dart';
import 'package:dream_messenger_demo/features/chat/domain/repositories/chat_repository.dart';

class ChatRepositoryImpl implements ChatRepository {
  @override
  Future<Either<Failure, void>> getOnlineUsers() {
    // TODO: implement getOnlineUsers
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, void>> sendMessage(String message) {
    // TODO: implement sendMessage
    throw UnimplementedError();
  }
}
