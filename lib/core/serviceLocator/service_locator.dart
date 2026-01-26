import 'package:dream_messenger_demo/core/bloc/themeBloc/theme_bloc.dart';
import 'package:dream_messenger_demo/core/services/local_data_service.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

final sl = GetIt.instance;

Future<void> initDependencies() async {
  final asyncPrefs = SharedPreferencesAsync(
    options: SharedPreferencesOptions(),
  );

  sl.registerSingleton<SharedPreferencesAsync>(asyncPrefs);

  sl.registerSingleton<LocalDataService>(
    LocalDataService(asyncPrefs: sl<SharedPreferencesAsync>()),
  );

  sl.registerFactoryAsync(
    () async => ThemeBloc(
      sl<LocalDataService>(),
      await sl<LocalDataService>().getTheme(),
    ),
  );
}
