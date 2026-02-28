import 'package:dream_messenger_demo/core/failure/failure.dart';
import 'package:dream_messenger_demo/features/auth/domain/entities/auth_user_entity.dart';
import 'package:dream_messenger_demo/features/auth/domain/usecases/sign_in_usecase.dart';
import 'package:dream_messenger_demo/features/auth/presentation/bloc/signInBloc/sign_in_event.dart';
import 'package:dream_messenger_demo/features/auth/presentation/bloc/signInBloc/sign_in_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
export 'package:flutter_bloc/flutter_bloc.dart';

export 'package:dream_messenger_demo/features/auth/presentation/bloc/signInBloc/sign_in_event.dart';
export 'package:dream_messenger_demo/features/auth/presentation/bloc/signInBloc/sign_in_state.dart';

class SignInBloc extends Bloc<SignInEvent, SignInState> {
  final SignInUseCase signInUseCase;

  SignInBloc({required this.signInUseCase}) : super(SignInInitialState()) {
    on<SignInBtnClicked>((event, emit) async {
      try {
        emit(SignInLoadingState());
        final result = await signInUseCase.call(
          AuthUserEntity(
            email: event.email,
            password: event.password,
            token: null,
          ),
        );
        result.fold(
          (failure) => emit(SignInFailedState(failure: failure)),
          (_) => emit(SignInSuccessState()),
        );
      } catch (err) {
        emit(
          SignInFailedState(failure: BlocLevelFailure(message: err.toString())),
        );
      }
    });
  }
}
