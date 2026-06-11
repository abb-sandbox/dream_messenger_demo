import 'package:dartz/dartz.dart';
import 'package:dream_messenger_demo/core/failure/failure.dart';
import 'package:dream_messenger_demo/features/auth/presentation/bloc/signInBloc/sign_in_bloc.dart';
import 'package:dream_messenger_demo/features/chat/domain/entities/message_entity.dart';
import 'package:dream_messenger_demo/features/chat/domain/usecases/listen_for_incoming_messages_usecase.dart';
import 'package:dream_messenger_demo/features/chat/domain/usecases/send_message_usecase.dart';
import 'package:dream_messenger_demo/features/chat/presentation/bloc/chatCubit/chat_state.dart';

class ChatCubit extends Cubit<ChatState> {
  final ListenForIncomingMessagesUseCase listenForIncomingMessagesUseCase;
  final SendMessageUseCase sendMessageUseCase;

  final List<MessageEntity> currentMessages = [];

  ChatCubit({
    required this.sendMessageUseCase,
    required this.listenForIncomingMessagesUseCase,
  }) : super(ChatInitialState());

  Future<void> sendMessage(MessageEntity message) async {
    try {
      final result = await sendMessageUseCase(message);
      result.fold((failure) => emit(ChatError(failure: failure)), (_) {
        currentMessages.insert(0, message);
        emit(ChatMessageUpdate(messages: currentMessages));});
    } catch (err) {
      emit(ChatError(failure: BlocLevelFailure(message: err.toString())));
    }
  }

  Future<void> listenForIncomingMessages() async {
    try {
      final result = await listenForIncomingMessagesUseCase(unit);
      result.fold((failure) => emit(ChatError(failure: failure)), (stream) {
        stream.listen((message) {
          currentMessages.insert(0, message);
          emit(ChatMessageUpdate(messages: currentMessages));
        });
      });
    } catch (err) {
      emit(ChatError(failure: BlocLevelFailure(message: err.toString())));
    }
  }

  String _generateChatId(String from, String to) {
    final ids = [from, to];
    ids.sort();
    return ids.join("_");
  }
}
