import 'package:dartz/dartz.dart';
import 'package:dream_messenger_demo/core/failure/failure.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import '../../models/message_model.dart';

abstract class ChatRemoteDatasource {
  Future<Either<Failure, Unit>> sendMessage(MessageModel model);

  Future<Either<Failure, Stream<MessageModel>>> listenForIncomingMessages();
}

class ChatRemoteDatasourceImpl implements ChatRemoteDatasource {
  final FirebaseAuth auth;
  final FirebaseDatabase db;

  ChatRemoteDatasourceImpl({required this.auth, required this.db});

  @override
  Future<Either<Failure, Unit>> sendMessage(MessageModel model) async {
    try {
      final ids = [model.from, model.to];
      ids.sort();
      final chatId = ids.join("_");
      await db.ref("chats/$chatId").push().set(model.toJson());

      await db.ref("users/${model.to}/inbox").push().set(model.toJson());

      return Right(unit);
    } catch (e) {
      return Left(RemoteDataFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, Stream<MessageModel>>>
  listenForIncomingMessages() async {
    try {
      final userId = auth.currentUser!.uid;
      final ref = db.ref("users/$userId/inbox");
      final stream = ref.onChildAdded.map((DatabaseEvent event) {
        final data = event.snapshot.value as Map<dynamic, dynamic>;
        final message = MessageModel.fromJson(data);
        event.snapshot.ref.remove();
        return message;
      });
      return Right(stream);
    } catch (e) {
      return Left(RemoteDataFailure(message: e.toString()));
    }
  }
}
