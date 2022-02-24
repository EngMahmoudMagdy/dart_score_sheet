import 'package:bloc/bloc.dart';
import 'package:dart_scoresheet/features/scoresheet/data/repos/player_repo_impl.dart';
import 'package:dart_scoresheet/features/scoresheet/domain/repos/player_repo.dart';
import 'package:dart_scoresheet/features/scoresheet/domain/usecases/get_players.dart';
import 'package:dart_scoresheet/features/scoresheet/presentation/cubit/cubit.dart';
import 'package:dart_scoresheet/features/scoresheet/presentation/cubit/player_state.dart';
import 'package:dartz/dartz.dart';

class PlayerCubit extends Cubit<PlayerState> {
  final GetPlayersUseCase getPlayersUseCase;

  PlayerCubit({required this.getPlayersUseCase}) : super(InitialState());

  void addPlayer(String username) {
    try {
      emit(LoadingState());
      // emit(PlayerAddedSuccess(_playerRepo.registerPlayer(username)));
    } on UserNameFoundException {
      emit(PlayerError("User is already exists."));
    } on ReachedLimitException {
      emit(PlayerError("You have reached the limit of new users"));
    }
  }

  void removePlayer(String username) {
    try {
      emit(LoadingState());
      // emit(PlayerRemovedSuccess(_playerRepo.removePlayer(username)));
    } on UserNameFoundException {
      emit(PlayerError("User does not exist."));
    }
  }

  Future<void> getPlayers() async {
    try {
      emit(LoadingState());
      emit(AllPlayersRetrievedSuccessState(Right(await  getPlayersUseCase(Params()))));
    } on UserNameFoundException {
      emit(PlayerError("User does not exist."));
    }
  }
}
