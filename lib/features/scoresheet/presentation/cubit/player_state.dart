import 'package:equatable/equatable.dart';

import '../../data/models/player.dart';

abstract class PlayerState implements Equatable {}

class InitialState extends PlayerState {
  @override
  List<Object?> get props => [];

  @override
  bool? get stringify => true;
}

class LoadingState extends PlayerState {
  @override
  List<Object?> get props => [];

  @override
  bool? get stringify => true;
}

class PlayerRetrievedSuccessState extends PlayerState {
  final Player player;

  PlayerRetrievedSuccessState(this.player);

  @override
  List<Object?> get props => [];

  @override
  bool? get stringify => true;
}

class AllPlayersRetrievedSuccessState extends PlayerState {
  final List<Player> players;

  AllPlayersRetrievedSuccessState(this.players);

  @override
  List<Object?> get props => [players];

  @override
  bool? get stringify => true;
}

class PlayerAddedSuccessState extends PlayerState {
  final Player player;

  PlayerAddedSuccessState(this.player);

  @override
  List<Object?> get props => [player];

  @override
  bool? get stringify => true;
}

class PlayerRemovedSuccessState extends PlayerState {
  final Player player;

  PlayerRemovedSuccessState(this.player);

  @override
  List<Object?> get props => [player];

  @override
  bool? get stringify => true;
}

class PlayerError extends PlayerState {
  final String error;

  PlayerError(this.error);

  @override
  List<Object?> get props => [error];

  @override
  bool? get stringify => true;
}
