import 'package:dart_scoresheet/features/scoresheet/data/datasources/player_local_data_source.dart';
import 'package:dart_scoresheet/features/scoresheet/data/models/player.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:sqflite/sqflite.dart';
final tPlayers = [Player(username: 'test', totalScore: 0)];

class MockDatabase extends Mock implements Database {
  @override
  Future<List<Map<String, dynamic>>> query(String table,
      {bool? distinct,
      List<String>? columns,
      String? where,
      List<Object?>? whereArgs,
      String? groupBy,
      String? having,
      String? orderBy,
      int? limit,
      int? offset}) {
    return Future.value([tPlayers.first.toMap()]);
  }
}

void main() {
  late MockDatabase mockDatabase;
  late PlayerLocalDataSourceImpl datasource;
  setUp(() {
    mockDatabase = MockDatabase();
    datasource = PlayerLocalDataSourceImpl(database: mockDatabase);
  });

  group('test Players local data source', () {

    test('when fetching players list is come up with valid data', () async {
      final result = await datasource.getPlayers();
        expect(result?.first ?? Player(username: 'test', totalScore: 0),
            equals(tPlayers.first));
    });
  });
}
