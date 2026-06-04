import 'dart:async';

import 'package:dartz/dartz.dart';
import 'package:dream_messenger_demo/core/failure/failure.dart';
import 'package:dream_messenger_demo/features/chat/data/datasources/remote/chat_remote_datasource.dart';
import 'package:dream_messenger_demo/features/chat/data/models/message_model.dart';
import 'package:dream_messenger_demo/features/chat/data/models/presence_model.dart';
import 'package:dream_messenger_demo/features/chat/domain/entities/message_entity.dart';
import 'package:dream_messenger_demo/features/chat/domain/repositories/chat_repository.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';

class ChatRepositoryImpl implements ChatRepository {
  final FirebaseDatabase db;
  final FirebaseAuth auth;
  final ChatRemoteDatasource chatRemoteDatasource;

  ChatRepositoryImpl({
    required this.db,
    required this.auth,
    required this.chatRemoteDatasource,
  });

  @override
  Future<Either<Failure, StreamController<PresenceModel>>>
  getOnlineUsers() async {
    DatabaseReference statusRef = db.ref("status");

    Query onlineQuery = statusRef.orderByChild("presence");
    StreamController<PresenceModel> users = StreamController<PresenceModel>();
    onlineQuery.onValue.listen((DatabaseEvent event) {
      final data = event.snapshot.value as Map<dynamic, dynamic>?;
      if (data != null) {
        data.forEach((key, value) {
          users.sink.add(PresenceModel.fromJson(key, value));
        });
      }

      print(event.snapshot.value);
    });
    return Right(users);
  }

  @override
  Future<Either<Failure, Unit>> sendMessage(MessageEntity entity) async {
    final model = MessageModel.fromEntity(entity);
    return chatRemoteDatasource.sendMessage(model);
  }

  @override
  Future<Either<Failure, Stream<PresenceModel>>>
  listenToCurrentUserPresence() async {
    try {
      final userId = auth.currentUser?.uid;
      DatabaseReference statusRef = db.ref("status/$userId");

      final stream = statusRef.onValue.map((event) {
        final value = event.snapshot.value as Map<dynamic, dynamic>?;
        return PresenceModel.fromJson(userId!, value!);
      });
      return Right(stream);
    } catch (e) {
      return Left(
        RepositoryLevelFailure(message: "Unknown error: ${e.toString()}"),
      );
    }
  }

  @override
  Future<Either<Failure, Stream<MessageEntity>>>
  listenForIncomingMessages() async {
    final remoteResult = await chatRemoteDatasource.listenForIncomingMessages();
    return remoteResult.fold((failure) => Left(failure), (modelStream) {
      final entityStream = modelStream.map((model) {
        return MessageEntity.fromModel(model);
      });
      return Right(entityStream);
    });
  }
}
