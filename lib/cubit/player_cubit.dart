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
      emit(PlayerSuccess(_playerRepo.registerPlayer(username)));
    } on UserNameFoundException {
      emit(PlayerError("User is already exists."));
    }
  }
}
