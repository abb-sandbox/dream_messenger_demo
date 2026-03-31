import 'package:dartz/dartz.dart';
import 'package:dream_messenger_demo/core/failure/failure.dart';

abstract class ChatRepository {
  Future<Either<Failure, void>> getOnlineUsers();

  Future<Either<Failure, void>> sendMessage(String message);
}