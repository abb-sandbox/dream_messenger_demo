import 'dart:async';

import 'package:dartz/dartz.dart';
import 'package:dream_messenger_demo/core/failure/failure.dart';
import 'package:dream_messenger_demo/features/chat/data/models/presence_model.dart';
import 'package:dream_messenger_demo/features/chat/domain/repositories/chat_repository.dart';
import 'package:firebase_database/firebase_database.dart';

class ChatRepositoryImpl implements ChatRepository {
  final FirebaseDatabase db;

  ChatRepositoryImpl({required this.db});

  @override
  Future<Either<Failure, StreamController<PresenceModel>>> getOnlineUsers() async {
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
  Future<Either<Failure, void>> sendMessage(String message) {
    // TODO: implement sendMessage
    throw UnimplementedError();
  }
}
