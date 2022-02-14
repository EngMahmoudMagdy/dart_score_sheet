part of 'player_cubit.dart';

@immutable
abstract class PlayerState {}

class PlayerInitial extends PlayerState {}
class PlayerLoading extends PlayerState {}

class PlayerAddedSuccess extends PlayerState {
  final Player player;
  PlayerAddedSuccess(this.player);
}
class PlayerRemovedSuccess extends PlayerState {
  final Player player;
  PlayerRemovedSuccess(this.player);
}

class PlayerError extends PlayerState {
  final String error;
  PlayerError(this.error);
}
