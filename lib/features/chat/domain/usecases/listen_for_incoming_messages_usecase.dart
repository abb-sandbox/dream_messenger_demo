import 'package:dartz/dartz.dart';
import 'package:dream_messenger_demo/core/usecases/usecase.dart';
import 'package:dream_messenger_demo/features/chat/domain/repositories/chat_repository.dart';

import '../../../../core/failure/failure.dart';
import '../entities/message_entity.dart';

class ListenForIncomingMessagesUseCase
    extends UseCase<Either<Failure, Stream<MessageEntity>>, Unit> {
  final ChatRepository chatRepository;

  ListenForIncomingMessagesUseCase({required this.chatRepository});

  @override
  Future<Either<Failure, Stream<MessageEntity>>> call(Unit params) async {
    return await chatRepository.listenForIncomingMessages();
  }
}
