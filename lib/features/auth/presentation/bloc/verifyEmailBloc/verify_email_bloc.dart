import 'package:dream_messenger_demo/core/failure/failure.dart';
import 'package:dream_messenger_demo/features/auth/domain/usecases/verify_email_usecase.dart';
import 'package:dream_messenger_demo/features/auth/presentation/bloc/verifyEmailBloc/verify_email_event.dart';
import 'package:dream_messenger_demo/features/auth/presentation/bloc/verifyEmailBloc/verify_email_state.dart';
export 'package:dream_messenger_demo/features/auth/presentation/bloc/verifyEmailBloc/verify_email_event.dart';
export 'package:dream_messenger_demo/features/auth/presentation/bloc/verifyEmailBloc/verify_email_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class VerifyEmailBloc extends Bloc<VerifyEmailEvent, VerifyEmailState> {
  final VerifyEmailUseCase verifyEmailUseCase;

  VerifyEmailBloc({required this.verifyEmailUseCase})
    : super(VerifyEmailInitialState()) {
    on<SendLinkToEmailEvent>((event, emit) async {
      emit(SendingLinkToEmail());
      try {
        final params = VerifyEmailUseCaseParams(email: event.email);
        final result = await verifyEmailUseCase.call(params);
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
