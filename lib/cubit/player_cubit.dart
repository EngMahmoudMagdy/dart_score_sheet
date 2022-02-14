import 'package:bloc/bloc.dart';
import 'package:dart_scoresheet/data/player.dart';
import 'package:dart_scoresheet/data/repos/playerRepo.dart';
import 'package:meta/meta.dart';

part 'player_state.dart';

class PlayerCubit extends Cubit<PlayerState> {
  final PlayerRepo _playerRepo;

  PlayerCubit(this._playerRepo) : super(PlayerInitial());

  void addPlayer(String username) {
    try {
      emit(PlayerLoading());
      emit(PlayerAddedSuccess(_playerRepo.registerPlayer(username)));
    } on UserNameFoundException {
      emit(PlayerError("User is already exists."));
    } on ReachedLimitException {
      emit(PlayerError("You have reached the limit of new users"));
    }
  }

  void removePlayer(String username) {
    try {
      emit(PlayerLoading());
      emit(PlayerRemovedSuccess(_playerRepo.removePlayer(username)));
    } on UserNameFoundException {
      emit(PlayerError("User does not exist."));
    }
  }
}
