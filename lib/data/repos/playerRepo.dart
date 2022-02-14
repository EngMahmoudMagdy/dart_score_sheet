import 'package:dart_scoresheet/data/player.dart';

abstract class PlayerRepo {
  /// Throws [UserNameFoundException],[PlayerNotFoundException].
  Player registerPlayer(String username);

  Player removePlayer(String username);

  Player fetchPlayer(String username);
}

class PlayerRepoImpl implements PlayerRepo {
  List<Player> storedPlayerList = [];

  static const _maxPlayers = 4;

  @override
  Player registerPlayer(String username) {
    if (storedPlayerList.length == _maxPlayers) throw ReachedLimitException();
    for (final p in storedPlayerList) {
      if (p.username == username) {
        throw UserNameFoundException();
      }
    }
    final p = Player(username: username);
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
  }
}

class ReachedLimitException implements Exception {}

class UserNameFoundException implements Exception {}

class PlayerNotFoundException implements Exception {}
