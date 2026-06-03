import 'package:dream_messenger_demo/core/bloc/networkCubit/network_state.dart';
import 'package:dream_messenger_demo/core/failure/failure.dart';
import 'package:dream_messenger_demo/features/auth/domain/repositories/auth_repository.dart';
import 'package:dream_messenger_demo/features/chat/domain/repositories/chat_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class NetworkCubit extends Cubit<NetworkState> {
  final ChatRepository _chatRepository;
  final AuthRepository _authRepository;
  bool _isAppActive = true;

  bool get isAppActive => _isAppActive;

  void setAppActivity(bool value) {
      _isAppActive = value;
  }

  NetworkCubit({required chatRepository, required authRepository})
    : _chatRepository = chatRepository,
      _authRepository = authRepository,
      super(UserIsOnline());

  Future<void> listenForUserChanges() async {
    try {
      final result = await _chatRepository.listenToCurrentUserPresence();
      result.fold((failure) => emit(UserNetworkError(failure: failure)), (
        changeStream,
      ) {
        changeStream.listen((model) async {
          if (model.presence == "offline" && _isAppActive) {
            emit(UserIsConnecting());
            await _authRepository.updateUserStatus(setToOnline: true);
            emit(UserIsOnline());
          }
        });
      });
    } catch (e) {
      emit(
        UserNetworkError(
          failure: BlocLevelFailure(
            message: "Couldn't listen for user status changes: ${e.toString()}",
          ),
        ),
      );
    }
  }
}
