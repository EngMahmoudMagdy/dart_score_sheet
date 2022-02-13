part of 'player_cubit.dart';

@immutable
abstract class PlayerState {}

class PlayerInitial extends PlayerState {}
class PlayerLoading extends PlayerState {}

class PlayerSuccess extends PlayerState {
  final List<Player> players;
  PlayerSuccess(this.players);
}

class PlayerError extends PlayerState {
  final String error;
  PlayerError(this.error);
}
