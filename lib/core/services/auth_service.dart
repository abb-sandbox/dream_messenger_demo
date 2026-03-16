import 'package:dream_messenger_demo/core/constants.dart';
import 'package:dream_messenger_demo/core/dependencyInjection/service_locator.dart';
import 'package:dream_messenger_demo/core/services/local_data_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthService {
  bool? _userSignedIn;
  String? _userEmail;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Stream<User?> get userStatus => _auth.authStateChanges();

  Future<void> get signOut => _auth.signOut();

  String? get userEmail => _userEmail;

  Future<bool> isUserSignedIn() async {
    if (_userSignedIn != null) return _userSignedIn!;

    final result = await sl<SharedPreferencesAsync>().getString(
      Constants.emailKey,
    );
    if (result != null && result.isNotEmpty) {
      _userEmail = result;
      _userSignedIn = true;
      return _userSignedIn!;
    }

    _userSignedIn = false;
    return _userSignedIn!;
  }
}
