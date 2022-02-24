import 'package:dart_scoresheet/core/errors/exceptions.dart';
import 'package:dart_scoresheet/core/errors/failures.dart';
import 'package:dart_scoresheet/features/scoresheet/data/datasources/player_local_data_source.dart';
import 'package:dart_scoresheet/features/scoresheet/data/models/player.dart';
import 'package:dart_scoresheet/features/scoresheet/data/repos/player_repo_impl.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

class MockPlayerLocalDataSource extends Mock implements PlayerLocalDataSource {}

void main() {
  late MockPlayerLocalDataSource mockPlayerLocalDataSource;
  late PlayerRepoImpl repo;
  setUp(() {
    mockPlayerLocalDataSource = MockPlayerLocalDataSource();
    repo = PlayerRepoImpl(dataSource: mockPlayerLocalDataSource);
  });

  group('Player Repo testing', () {
    final tPlayers = [Player(username: 'Test', totalScore: 1)];
    test('check if getPlayers is called', () async {
      when(mockPlayerLocalDataSource.getPlayers())
          .thenAnswer((_) async => tPlayers);

      verifyZeroInteractions(mockPlayerLocalDataSource);
      final result = await repo.fetchPlayers();
      verify(mockPlayerLocalDataSource.getPlayers());
      expect(result, equals(Right(tPlayers)));
    });

    test('check if player local database throw Failure with no players exist',
        () async {
      when(mockPlayerLocalDataSource.getPlayers()).thenThrow(CacheException());
      verifyZeroInteractions(mockPlayerLocalDataSource);
      final result = await repo.fetchPlayers();
      verify(mockPlayerLocalDataSource.getPlayers());
      expect(result, equals(Left(CacheFailure())));
    });
  });
}
