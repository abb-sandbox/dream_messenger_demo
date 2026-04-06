import 'package:dream_messenger_demo/core/bloc/authCubit/auth_state.dart';
import 'package:dream_messenger_demo/core/constants.dart';
import 'package:dream_messenger_demo/features/auth/presentation/bloc/signInBloc/sign_in_bloc.dart';
import 'package:dream_messenger_demo/features/auth/presentation/bloc/signUpBloc/sign_up_bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthCubit extends Cubit<AuthState> {
  final SharedPreferencesAsync _asyncPrefs;
  bool? _isLoginInfoSaved;
  String? _userEmail;
  String? _userPassword;
  String? _userID;

  final FirebaseAuth _auth = FirebaseAuth.instance;

  AuthCubit({required asyncPrefs})
    : _asyncPrefs = asyncPrefs,
      super(AuthInitialState()) {}

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
    await _auth.signOut();
    await _asyncPrefs.remove(Constants.passwordKey);
    await _asyncPrefs.remove(Constants.userID);
    await _asyncPrefs.remove(Constants.emailKey);
    emit(AuthSignedOutState());
  }

  Future<void> signInRemotely() async {
    await _auth.signInWithEmailAndPassword(
      email: _userEmail!,
      password: _userPassword!,
    );
    emit(AuthSignedInState());
  }

  String? get userEmail => _userEmail;

  String? get userPassword => _userPassword;

  String? get userID => _userID;

  bool get isLoginInfoSaved => _isLoginInfoSaved!;
}
