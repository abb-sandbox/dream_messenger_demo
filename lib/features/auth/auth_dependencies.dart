import 'package:dio/dio.dart';
import 'package:dream_messenger_demo/core/dependencyInjection/service_locator.dart';
import 'package:dream_messenger_demo/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:dream_messenger_demo/features/auth/domain/repositories/auth_repository.dart';
import 'package:dream_messenger_demo/features/auth/domain/usecases/sign_in_usecase.dart';
import 'package:dream_messenger_demo/features/auth/domain/usecases/sign_up_usecase.dart';
import 'package:dream_messenger_demo/features/auth/domain/usecases/verify_email_usecase.dart';
import 'package:dream_messenger_demo/features/auth/presentation/bloc/signInBloc/sign_in_bloc.dart';
import 'package:dream_messenger_demo/features/auth/presentation/bloc/signUpBloc/sign_up_bloc.dart';
import 'package:dream_messenger_demo/features/auth/presentation/bloc/verifyEmailBloc/verify_email_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'data/datasources/local/auth_local_datasource.dart';
import 'data/datasources/remote/auth_remote_datasource.dart';

Future<void> initAuthDependencies() async {
  sl.registerSingleton<AuthRemoteDataSource>(
    AuthRemoteDataSourceImpl(dio: sl<Dio>()),
  );

  sl.registerSingleton<AuthLocalDataSource>(
    AuthLocalDatasourceImpl(asyncPrefs: sl<SharedPreferencesAsync>()),
  );

  sl.registerSingleton<AuthRepository>(
    AuthRepositoryImpl(remoteDatasource: sl(), localDataSource: sl()),
  );

  sl.registerSingleton(VerifyEmailUseCase(authRepository: sl()));

  sl.registerSingleton(SignUpUseCase(authRepository: sl()));

  sl.registerSingleton(SignInUseCase(authRepository: sl()));

  sl.registerFactory<VerifyEmailBloc>(
    () => VerifyEmailBloc(verifyEmailUseCase: sl()),
  );

  sl.registerFactory<SignInBloc>(() => SignInBloc(signInUseCase: sl()));

  sl.registerFactory<SignUpBloc>(() => SignUpBloc(signUpUseCase: sl()));
}
