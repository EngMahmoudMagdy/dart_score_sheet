import 'package:dart_scoresheet/core/errors/failures.dart';
import 'package:dart_scoresheet/core/usecases/usecase.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import '../../../../core/errors/exceptions.dart';
import '../../data/models/player.dart';
import '../repos/player_repo.dart';

class GetPlayersUseCase implements UseCase<List<Player>?, Params> {
  final PlayerRepo playerRepo;

  GetPlayersUseCase(this.playerRepo);

  @override
  Future<Either<Failure, List<Player>?>> call(Params params) async {
    return await playerRepo.fetchPlayers();
  }
}

class Params extends Equatable {
  Params();

  @override
  List<Object?> get props => [];
}
