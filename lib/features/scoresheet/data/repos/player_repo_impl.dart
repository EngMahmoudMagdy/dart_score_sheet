import 'package:dart_scoresheet/core/errors/exceptions.dart';
import 'package:dart_scoresheet/core/errors/failures.dart';
import 'package:dart_scoresheet/features/scoresheet/data/datasources/player_local_data_source.dart';
import 'package:dart_scoresheet/features/scoresheet/data/models/player.dart';
import 'package:dart_scoresheet/features/scoresheet/domain/repos/player_repo.dart';
import 'package:dartz/dartz.dart';

class PlayerRepoImpl implements PlayerRepo {
  final PlayerLocalDataSource dataSource;

  PlayerRepoImpl({required this.dataSource});

  static const _maxPlayers = 4;

/*
  @override
  Player registerPlayer(String username) {
    if (storedPlayerList.length == _maxPlayers) throw ReachedLimitException();
    for (final p in storedPlayerList) {
      if (p.username == username) {
        throw UserNameFoundException();
      }
    }
    final p = Player(username: username, totalScore: 0);
    storedPlayerList.add(p);
    return p;
  }

  @override
  Player fetchPlayer(String username) {
    for (final p in storedPlayerList) {
      if (p.username == username) {
        return p;
      }
    }
    throw PlayerNotFoundException();
  }

  @override
  Player removePlayer(String username) {
    Player? removedPlayer;
    for (final p in storedPlayerList) {
      if (p.username == username) {
        removedPlayer = p;
        break;
      }
    }
    if (removedPlayer == null) throw PlayerNotFoundException();
    storedPlayerList.remove(removedPlayer);
    return removedPlayer;
  }*/

  @override
  Future<Either<Failure, List<Player>?>> fetchPlayers() async {
    try {
      final result = await dataSource.getPlayers();
      return Right(result);
    } on CacheException {
      return Left(CacheFailure());
    }
  }
}

class ReachedLimitException implements Exception {}

class UserNameFoundException implements Exception {}

class PlayerNotFoundException implements Exception {}
