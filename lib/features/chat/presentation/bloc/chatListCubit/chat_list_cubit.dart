import 'package:dream_messenger_demo/features/auth/presentation/bloc/signInBloc/sign_in_bloc.dart';
import 'package:dream_messenger_demo/features/chat/domain/entities/online_user_entity.dart';
import 'package:dream_messenger_demo/features/chat/domain/usecases/get_online_users_usecase.dart';

import 'chat_list_state.dart';
export 'chat_list_state.dart';

class ChatListCubit extends Cubit<ChatListState> {
  ChatListCubit({required this.getOnlineUsersUseCase})
    : super(ChatListInitialState());

  final GetOnlineUsersUseCase getOnlineUsersUseCase;

  Map<String, OnlineUserEntity> onlineUsers = {};

  Future<void> getOnlineUsers() async {
    emit(ChatListLoading());

    final result = await getOnlineUsersUseCase.call(null);
    result.stream.listen((data) {
      if (data.presence == "offline") {
        print("DELETING: ${data.uid}");
        onlineUsers.remove(data.uid);
      } else {
        print("ADDING: ${data.uid}");
        onlineUsers[data.uid] = data;
      }
      print("ONLINE USERS LIST IS UPDATED: $onlineUsers");
      emit(ChatListUpdated(onlineUsers: onlineUsers.values.toList()));
      // emit(ChatListUpdated(onlineUsers: onlineUsers.values.where((v) => v.presence == "online").toList()));
    });
  }
}
