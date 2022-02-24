import 'package:dart_scoresheet/features/scoresheet/data/models/player.dart';
import 'package:sqflite/sqflite.dart';

abstract class PlayerLocalDataSource {
  Future<List<Player>>? getPlayers();
}

class PlayerLocalDataSourceImpl implements PlayerLocalDataSource {
  final Database database;
  final table = 'players';

  PlayerLocalDataSourceImpl({required this.database});

  @override
  Future<List<Player>>? getPlayers() async {
    final List<Map<String, dynamic>> result = await database.query(table);
    return List.generate(result.length, (index) {
      return Player(
        username: result[index]['username'],
        totalScore: result[index]['totalScore'],
      );
    });
  }
}
/*var List<Player> list = [];
    final iterator = e.entries.iterator;
    do
        {
        if(iterator.current.value!=null)
        list.add(iterator.current.value);
        }
        while(iterator.moveNext())*/
