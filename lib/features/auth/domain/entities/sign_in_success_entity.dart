import 'package:equatable/equatable.dart';

class SignInSuccessEntity with EquatableMixin {
  final String uid;

  SignInSuccessEntity({required this.uid});

  @override
  List<Object?> get props => [uid];
}
