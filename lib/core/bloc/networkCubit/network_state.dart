import 'package:dream_messenger_demo/core/failure/failure.dart';

abstract class NetworkState {}

class UserIsOffline extends NetworkState {}

class UserIsOnline extends NetworkState {}

class UserIsConnecting extends NetworkState {}

class UserNetworkError extends NetworkState {
  final Failure failure;

  UserNetworkError({required this.failure});
}
