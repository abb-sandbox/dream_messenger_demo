import 'package:dream_messenger_demo/features/chat/data/repositories/chat_repository_impl.dart';
import 'package:dream_messenger_demo/features/chat/domain/repositories/chat_repository.dart';
import 'package:dream_messenger_demo/features/chat/domain/usecases/get_online_users_usecase.dart';
import 'package:dream_messenger_demo/features/chat/presentation/bloc/chatListCubit/chat_list_cubit.dart';
import 'package:firebase_database/firebase_database.dart';

import '../../core/dependencyInjection/service_locator.dart';

Future<void> initChatDependencies() async {
  sl.registerFactory<ChatRepository>(
    () => ChatRepositoryImpl(db: sl<FirebaseDatabase>()),
  );
  sl.registerFactory<GetOnlineUsersUseCase>(
    () => GetOnlineUsersUseCase(chatRepository: sl<ChatRepository>()),
  );

  sl.registerSingleton<ChatListCubit>(
    ChatListCubit(getOnlineUsersUseCase: sl<GetOnlineUsersUseCase>()),
  );
}
