import 'package:dream_messenger_demo/core/dependencyInjection/service_locator.dart';
import 'package:dream_messenger_demo/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:dream_messenger_demo/features/auth/domain/repositories/auth_repository.dart';
import 'package:dream_messenger_demo/features/auth/presentation/bloc/verifyEmailBloc/verify_email_bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../features/auth/data/datasources/local/auth_local_datasource.dart';
import '../../features/auth/data/datasources/remote/auth_remote_datasource.dart';

Future<void> initAuthDependencies() async {
  final firebaseAuth = FirebaseAuth.instance;

  sl.registerSingleton<FirebaseAuth>(firebaseAuth);

  sl.registerSingleton<AuthRemoteDataSource>(
    AuthRemoteDataSourceImpl(firebaseAuth: sl<FirebaseAuth>()),
  );

  sl.registerSingleton<AuthLocalDataSource>(
    AuthLocalDatasourceImpl(asyncPrefs: sl<SharedPreferencesAsync>()),
  );

  sl.registerSingleton<AuthRepository>(
    AuthRepositoryImpl(remoteDatasource: sl(), localDataSource: sl()),
  );

  sl.registerFactory<VerifyEmailBloc>(
    () => VerifyEmailBloc(authRepository: sl()),
  );
}
