import 'package:dart_scoresheet/data/player.dart';

abstract class PlayerRepo {
  /// Throws [UserNameFoundException],[PlayerNotFoundException].
  List<Player> registerPlayer(String username);

  Player fetchPlayer(String username);
}

class PlayerRepoImpl implements PlayerRepo {
  List<Player> storedPlayerList = [];

  @override
  List<Player> registerPlayer(String username) {
    for (final p in storedPlayerList) {
      if (p.username == username) {
        throw UserNameFoundException();
      }
    }
    storedPlayerList.add(Player(username: username));
    return storedPlayerList;
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
}

class UserNameFoundException implements Exception {}

class PlayerNotFoundException implements Exception {}
