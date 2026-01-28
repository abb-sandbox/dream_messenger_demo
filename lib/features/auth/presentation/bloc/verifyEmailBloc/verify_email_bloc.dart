import 'package:dream_messenger_demo/core/failure/failure.dart';
import 'package:dream_messenger_demo/features/auth/domain/repositories/auth_repository.dart';
import 'package:dream_messenger_demo/features/auth/presentation/bloc/verifyEmailBloc/verify_email_event.dart';
import 'package:dream_messenger_demo/features/auth/presentation/bloc/verifyEmailBloc/verify_email_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class VerifyEmailBloc extends Bloc<VerifyEmailEvent, VerifyEmailState> {
  final AuthRepository _authRepository;

  VerifyEmailBloc({required AuthRepository authRepository})
    : _authRepository = authRepository,
      super(VerifyEmailInitialState()) {
    on<SendLinkToEmailEvent>((event, emit) async {
      try {
        final result = await _authRepository.sendLinkToEmail(event.email);
        result.fold(
          (failure) {
            emit(SendLinkToEmailFailure(failure: failure));
          },
          (_) {
            emit(SendLinkToEmailSuccess());
          },
        );
      } catch (err) {
        emit(
          SendLinkToEmailFailure(
            failure: BlocLevelFailure(message: err.toString()),
          ),
        );
      }
    });
  }
}
