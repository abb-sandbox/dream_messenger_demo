import 'dart:async';

import 'package:dartz/dartz.dart';
import 'package:dream_messenger_demo/core/failure/failure.dart';
import 'package:dream_messenger_demo/features/chat/data/models/presence_model.dart';
import 'package:dream_messenger_demo/features/chat/domain/entities/message_entity.dart';

abstract class ChatRepository {
  Future<Either<Failure, Stream<PresenceModel>>> listenToCurrentUserPresence();

  Future<Either<Failure, Stream<MessageEntity>>> listenForIncomingMessages();

  Future<Either<Failure, StreamController<PresenceModel>>> getOnlineUsers();

  Future<Either<Failure, Unit>> sendMessage(MessageEntity entity);
}