import 'package:dream_messenger_demo/core/failure/failure.dart';
import 'package:dream_messenger_demo/features/auth/presentation/bloc/signInBloc/sign_in_bloc.dart';
import 'package:dream_messenger_demo/features/chat/domain/entities/online_user_entity.dart';
import 'package:dream_messenger_demo/features/chat/domain/usecases/get_online_users_usecase.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'chat_list_state.dart';
export 'chat_list_state.dart';

class ChatListCubit extends Cubit<ChatListState> {
  final FirebaseAuth auth;

  ChatListCubit({required this.getOnlineUsersUseCase, required this.auth})
    : super(ChatListInitialState());

  final GetOnlineUsersUseCase getOnlineUsersUseCase;

  Map<String, OnlineUserEntity> onlineUsers = {};

  Future<void> getOnlineUsers() async {
    emit(ChatListLoading());

    final result = await getOnlineUsersUseCase.call(null);
    result.stream.listen((data) {
      try {
        if (data.uid != auth.currentUser!.uid) {
          // Don't add the current user itself to the list
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
        }
      } catch (e) {
        emit(ChatListError(failure: BlocLevelFailure(message: e.toString())));
      }
    });
  }
}
