export "sign_up_event.dart";
export "sign_up_state.dart";
import "package:dream_messenger_demo/core/failure/failure.dart";
import "package:dream_messenger_demo/features/auth/domain/entities/auth_user_entity.dart";
import "package:dream_messenger_demo/features/auth/domain/usecases/sign_up_usecase.dart";
import 'package:flutter_bloc/flutter_bloc.dart';
import "../../../../../core/bloc/authCubit/auth_cubit.dart";
import "sign_up_event.dart";
import "sign_up_state.dart";

class SignUpBloc extends Bloc<SignUpEvent, SignUpState> {
  final SignUpUseCase signUpUseCase;

  SignUpBloc({required this.signUpUseCase}) : super(SignUpInitialState()) {
    on<SignUpBtnClicked>((event, emit) async {
      try {
        emit(SignUpLoadingState());

        final result = await signUpUseCase.call(
          AuthUserEntity(email: event.email, password: event.password),
        );

        await result.fold((failure) async=> emit(SignUpFailureState(failure: failure)), (
          userID,
        ) async {
          await event.context
              .read<AuthCubit>()
              .init(
                userID: userID,
                userEmail: event.email,
                userPassword: event.password,
              );
          emit(SignUpSuccessState());
        });
      } catch (err) {
        emit(
          SignUpFailureState(
            failure: BlocLevelFailure(message: err.toString()),
          ),
        );
      }
    });
  }
}
