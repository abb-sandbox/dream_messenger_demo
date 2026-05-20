import 'dart:async';

import 'package:dartz/dartz.dart';
import 'package:dream_messenger_demo/core/failure/failure.dart';
import 'package:dream_messenger_demo/features/chat/data/models/presence_model.dart';

abstract class ChatRepository {
  Future<Either<Failure, StreamController<PresenceModel>>> getOnlineUsers();

  Future<Either<Failure, void>> sendMessage(String message);
}