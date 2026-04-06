import 'package:dream_messenger_demo/features/auth/domain/entities/sign_in_success_entity.dart';
import 'package:equatable/equatable.dart';

class SignInSuccessModel extends SignInSuccessEntity with EquatableMixin {
  SignInSuccessModel({required super.uid});

  factory SignInSuccessModel.fromEntity(SignInSuccessEntity e) {
    return SignInSuccessModel(uid: e.uid);
  }

  factory SignInSuccessModel.fromJson(Map<String, dynamic> json) {
    return SignInSuccessModel(uid: json['uid']);
  }

  @override
  List<Object?> get props => [uid];
}
