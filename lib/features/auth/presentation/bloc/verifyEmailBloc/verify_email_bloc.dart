import 'package:dream_messenger_demo/core/failure/failure.dart';
import 'package:dream_messenger_demo/features/auth/domain/usecases/verify_email_usecase.dart';
import 'package:dream_messenger_demo/features/auth/presentation/bloc/verifyEmailBloc/verify_email_event.dart';
import 'package:dream_messenger_demo/features/auth/presentation/bloc/verifyEmailBloc/verify_email_state.dart';
export 'package:dream_messenger_demo/features/auth/presentation/bloc/verifyEmailBloc/verify_email_event.dart';
export 'package:dream_messenger_demo/features/auth/presentation/bloc/verifyEmailBloc/verify_email_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
export 'package:flutter_bloc/flutter_bloc.dart';

class VerifyEmailBloc extends Bloc<VerifyEmailEvent, VerifyEmailState> {
  final VerifyEmailUseCase verifyEmailUseCase;

  VerifyEmailBloc({required this.verifyEmailUseCase})
    : super(VerifyEmailInitialState()) {
    on<SendVerifyDataEvent>((event, emit) async {
      emit(SendingVerifyData());
      try {
        final params = VerifyEmailUseCaseParams(
          email: event.email,
          password: event.password,
        );
        final result = await verifyEmailUseCase.call(params);
        result.fold(
          (failure) {
            emit(SendVerifyDataFailure(failure: failure));
          },
          (_) {
            emit(SendVerifyDataSuccess());
          },
        );
      } catch (err) {
        emit(
          SendVerifyDataFailure(
            failure: BlocLevelFailure(message: err.toString()),
          ),
        );
      }
    });
  }
}
