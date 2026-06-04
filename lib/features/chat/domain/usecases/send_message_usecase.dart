import 'package:dartz/dartz.dart';
import 'package:dream_messenger_demo/core/usecases/usecase.dart';
import 'package:dream_messenger_demo/features/chat/domain/entities/message_entity.dart';
import 'package:dream_messenger_demo/features/chat/domain/repositories/chat_repository.dart';

import '../../../../core/failure/failure.dart';

class SendMessageUseCase extends UseCase<Either<Failure, Unit>, MessageEntity> {
  final ChatRepository chatRepository;

  SendMessageUseCase({required this.chatRepository});

  @override
  Future<Either<Failure, Unit>> call(MessageEntity params) async {
    return await chatRepository.sendMessage(params);
  }
}
