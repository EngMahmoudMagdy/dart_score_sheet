import 'package:dart_scoresheet/features/scoresheet/data/models/player.dart';
import 'package:dart_scoresheet/features/scoresheet/domain/repos/player_repo.dart';
import 'package:dart_scoresheet/features/scoresheet/domain/usecases/get_players.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

class MockPlayerRepo extends Mock implements PlayerRepo {}

void main() {
  late MockPlayerRepo mockPlayerRepo;
  late GetPlayersUseCase useCase;
  setUp(() {
    mockPlayerRepo = MockPlayerRepo();
    useCase = GetPlayersUseCase(mockPlayerRepo);
  });

  final List<Player> tPlayers = [];
  test('should get players is called', () async {
    when(mockPlayerRepo.fetchPlayers())
        .thenAnswer((_) async => Right(tPlayers));
    final result = await useCase(Params());
    expect(result, Right(tPlayers));
    verify(mockPlayerRepo.fetchPlayers());
    verifyNoMoreInteractions(mockPlayerRepo);
  });
}
