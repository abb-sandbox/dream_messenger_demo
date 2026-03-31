import 'package:dream_messenger_demo/core/bloc/authCubit/auth_state.dart';
import 'package:dream_messenger_demo/core/constants.dart';
import 'package:dream_messenger_demo/features/auth/presentation/bloc/signInBloc/sign_in_bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthCubit extends Cubit<AuthState> {
  final SharedPreferencesAsync _asyncPrefs;
  bool? _userSignedIn;
  String? _userEmail;

  final FirebaseAuth _auth = FirebaseAuth.instance;

  AuthCubit({required asyncPrefs})
    : _asyncPrefs = asyncPrefs,
      super(AuthInitialState());

  Stream<User?> get userStatus => _auth.authStateChanges();

  Future<void> signOut() async {
    await _auth.signOut();
    await _asyncPrefs.remove(Constants.firebaseAccessTokenKey);
    await _asyncPrefs.remove(Constants.firebaseTokenKey);
    await _asyncPrefs.remove(Constants.accessTokenKey);
    await _asyncPrefs.remove(Constants.refreshTokenKey);
    await _asyncPrefs.remove(Constants.emailKey);
    emit(AuthSignedOutState());
  }

  String? get userEmail => _userEmail;

  Future<bool> isUserSignedIn() async {
    if (_userSignedIn != null) return _userSignedIn!;

    final result = await _asyncPrefs.getString(Constants.emailKey);
    if (result != null && result.isNotEmpty) {
      _userEmail = result;
      _userSignedIn = true;
      return _userSignedIn!;
    }

    _userSignedIn = false;
    return _userSignedIn!;
  }
}
