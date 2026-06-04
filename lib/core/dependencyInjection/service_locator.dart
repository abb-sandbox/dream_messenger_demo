import 'package:dio/dio.dart';
import 'package:dream_messenger_demo/core/bloc/authCubit/auth_cubit.dart';
import 'package:dream_messenger_demo/core/bloc/networkCubit/network_cubit.dart';
import 'package:dream_messenger_demo/core/bloc/themeBloc/theme_bloc.dart';
import 'package:dream_messenger_demo/core/services/local_data_service.dart';
import 'package:dream_messenger_demo/features/auth/domain/repositories/auth_repository.dart';
import 'package:dream_messenger_demo/features/chat/chat_dependencies.dart';
import 'package:dream_messenger_demo/features/chat/domain/repositories/chat_repository.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../features/auth/auth_dependencies.dart';

final sl = GetIt.instance;

Future<void> initDependencies() async {
  final asyncPrefs = SharedPreferencesAsync(
    options: SharedPreferencesOptions(),
  );

  sl.registerSingleton<SharedPreferencesAsync>(asyncPrefs);

  final baseOptions = BaseOptions(
    baseUrl: "http://delightful-codie-abb-sandbox-3f6303bc.koyeb.app",
    connectTimeout: Duration(seconds: 5),
    receiveTimeout: Duration(seconds: 5),
  );

  final dio = Dio(baseOptions);

  sl.registerSingleton<Dio>(dio);

  sl.registerSingleton<LocalDataService>(
    LocalDataService(asyncPrefs: sl<SharedPreferencesAsync>()),
  );

  final themeData = await sl<LocalDataService>().getTheme();

  sl.registerFactory(() => ThemeBloc(sl<LocalDataService>(), themeData));

  await initAuthDependencies();

  await initChatDependencies();

  sl.registerSingleton<AuthCubit>(
    AuthCubit(
      asyncPrefs: sl<SharedPreferencesAsync>(),
      authRepository: sl<AuthRepository>(),
    ),
  );

  sl.registerSingleton<NetworkCubit>(
    NetworkCubit(
      chatRepository: sl<ChatRepository>(),
      authRepository: sl<AuthRepository>(),
    ),
  );
}
