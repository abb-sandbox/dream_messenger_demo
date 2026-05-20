import 'package:dream_messenger_demo/features/chat/data/models/presence_model.dart';

class OnlineUserEntity {
  final String uid;
  final String lastChanged;
  final String presence;

  OnlineUserEntity({
    required this.uid,
    required this.lastChanged,
    required this.presence,
  });

  factory OnlineUserEntity.fromModel(PresenceModel model) {
    return OnlineUserEntity(
      uid: model.uid,
      lastChanged: model.lastChanged,
      presence: model.presence,
    );
  }
}
