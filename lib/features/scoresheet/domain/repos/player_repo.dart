import 'package:dart_scoresheet/features/scoresheet/data/models/player.dart';
import 'package:dartz/dartz.dart';

import '../../../../core/errors/failures.dart';

abstract class PlayerRepo {
  /// Throws [UserNameFoundException],[PlayerNotFoundException].
 /* Player registerPlayer(String username);

  Player removePlayer(String username);

  Player fetchPlayer(String username);*/

  Future<Either<Failure, List<Player>?>> fetchPlayers();
}
