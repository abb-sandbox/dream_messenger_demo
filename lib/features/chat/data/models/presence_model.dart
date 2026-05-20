import 'package:dream_messenger_demo/features/chat/domain/entities/online_user_entity.dart';

class PresenceModel extends OnlineUserEntity {
  PresenceModel({
    required super.uid,
    required super.lastChanged,
    required super.presence,
  });

  factory PresenceModel.fromJson(String uid, Map<dynamic, dynamic> json) {
    return PresenceModel(
      uid: uid,
      lastChanged: json["last_changed"]!.toString(),
      presence: json["presence"]!,
    );
  }
}
