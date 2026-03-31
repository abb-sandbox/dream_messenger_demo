import 'package:dream_messenger_demo/core/bloc/authCubit/auth_state.dart';
import 'package:dream_messenger_demo/core/constants.dart';
import 'package:dream_messenger_demo/features/auth/presentation/bloc/signInBloc/sign_in_bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthCubit extends Cubit<AuthState> {
  final SharedPreferencesAsync _asyncPrefs;
  bool? _userSignedIn;
  String? _userEmail;
  String? _userPassword;

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

  Future<void> signIn(String email, String password) async {
    await FirebaseAuth.instance.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
  }

  String? get userEmail => _userEmail;

  String? get userPassword => _userPassword;

  Future<bool> isUserSignedIn() async {
    if (_userSignedIn != null) return _userSignedIn!;

    final result = await Future.wait([
      _asyncPrefs.getString(Constants.emailKey),
      _asyncPrefs.getString(Constants.passwordKey),
    ]);
    if (result[0] != null && result[0]!.isNotEmpty) {
      _userEmail = result[0];
      _userSignedIn = true;
      _userPassword = result[1];
      signIn(_userEmail!, _userPassword!);
      return _userSignedIn!;
    }

    _userSignedIn = false;
    return _userSignedIn!;
  }
}
