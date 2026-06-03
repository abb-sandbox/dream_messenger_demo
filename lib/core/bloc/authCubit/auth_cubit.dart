import 'package:dream_messenger_demo/core/bloc/authCubit/auth_state.dart';
import 'package:dream_messenger_demo/core/constants.dart';
import 'package:dream_messenger_demo/features/auth/domain/entities/auth_user_entity.dart';
import 'package:dream_messenger_demo/features/auth/domain/repositories/auth_repository.dart';
import 'package:dream_messenger_demo/features/auth/presentation/bloc/signInBloc/sign_in_bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthCubit extends Cubit<AuthState> {
  final SharedPreferencesAsync _asyncPrefs;
  final AuthRepository _authRepository;
  bool? _isLoginInfoSaved;
  String? _userEmail;
  String? _userPassword;
  String? _userID;

  final FirebaseAuth _auth = FirebaseAuth.instance;

  AuthCubit({required asyncPrefs, required authRepository})
    : _asyncPrefs = asyncPrefs,
      _authRepository = authRepository,
      super(AuthInitialState());

  Stream<User?> get userStatus => _auth.authStateChanges();

  Future<void> init({String? userID, userEmail, userPassword}) async {
    if (userID == null || userEmail == null || userPassword == null) {
      final results = await Future.wait([
        _asyncPrefs.getString(Constants.userID),
        _asyncPrefs.getString(Constants.emailKey),
        _asyncPrefs.getString(Constants.passwordKey),
      ]);
      if (results[0] == null || results[1] == null || results[2] == null) {
        _isLoginInfoSaved = false;
      } else {
        _userID = results[0];
        _userEmail = results[1];
        _userPassword = results[2];
        _isLoginInfoSaved = true;
      }
    } else {
      _userID = userID;
      _userEmail = userEmail;
      _userPassword = userPassword;
      _isLoginInfoSaved = true;
    }
  }

  Future<void> signOut() async {
    await _authRepository.updateUserStatus(setToOnline: false);
    await _auth.signOut();
    await _asyncPrefs.remove(Constants.passwordKey);
    await _asyncPrefs.remove(Constants.userID);
    await _asyncPrefs.remove(Constants.emailKey);
    emit(AuthSignedOutState());
  }

  Future<void> signInRemotely() async {
    try {
      await _authRepository.signIn(
        AuthUserEntity(email: _userEmail!, password: _userPassword!),
      );
      emit(AuthSignedInState());
    } catch (e) {
      emit(AuthCubitError(message: e.toString()));
    }
  }

  String? get userEmail => _userEmail;

  String? get userPassword => _userPassword;

  String? get userID => _userID;

  bool get isLoginInfoSaved => _isLoginInfoSaved!;
}
