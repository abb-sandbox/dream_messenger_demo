import 'package:dream_messenger_demo/features/chat/data/datasources/remote/chat_remote_datasource.dart';
import 'package:dream_messenger_demo/features/chat/data/repositories/chat_repository_impl.dart';
import 'package:dream_messenger_demo/features/chat/domain/repositories/chat_repository.dart';
import 'package:dream_messenger_demo/features/chat/domain/usecases/get_online_users_usecase.dart';
import 'package:dream_messenger_demo/features/chat/domain/usecases/listen_for_incoming_messages_usecase.dart';
import 'package:dream_messenger_demo/features/chat/domain/usecases/send_message_usecase.dart';
import 'package:dream_messenger_demo/features/chat/presentation/bloc/chatCubit/chat_cubit.dart';
import 'package:dream_messenger_demo/features/chat/presentation/bloc/chatListCubit/chat_list_cubit.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';

import '../../core/dependencyInjection/service_locator.dart';

Future<void> initChatDependencies() async {
  sl.registerFactory<ChatRemoteDatasource>(
    () => ChatRemoteDatasourceImpl(
      auth: FirebaseAuth.instance,
      db: sl<FirebaseDatabase>(),
    ),
  );

  sl.registerFactory<ChatRepository>(
    () => ChatRepositoryImpl(
      db: sl<FirebaseDatabase>(),
      auth: FirebaseAuth.instance,
      chatRemoteDatasource: sl<ChatRemoteDatasource>(),
    ),
  );
  sl.registerFactory<GetOnlineUsersUseCase>(
    () => GetOnlineUsersUseCase(chatRepository: sl<ChatRepository>()),
  );

  sl.registerSingleton<ChatListCubit>(
    ChatListCubit(
      getOnlineUsersUseCase: sl<GetOnlineUsersUseCase>(),
      auth: FirebaseAuth.instance,
    ),
  );
  sl.registerLazySingleton(
    () => SendMessageUseCase(chatRepository: sl<ChatRepository>()),
  );
  sl.registerLazySingleton(
    () =>
        ListenForIncomingMessagesUseCase(chatRepository: sl<ChatRepository>()),
  );
  sl.registerSingleton(
    ChatCubit(
      sendMessageUseCase: sl<SendMessageUseCase>(),
      listenForIncomingMessagesUseCase: sl<ListenForIncomingMessagesUseCase>(),
    ),
  );
}
