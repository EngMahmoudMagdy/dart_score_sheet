import 'package:dart_scoresheet/features/scoresheet/data/models/player.dart';
import 'package:dart_scoresheet/features/scoresheet/domain/usecases/get_players.dart';
import 'package:dart_scoresheet/features/scoresheet/presentation/cubit/cubit.dart';
import 'package:dart_scoresheet/features/scoresheet/presentation/cubit/player_cubit.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

class MockGetPlayers extends Mock implements GetPlayersUseCase {}

void main() {
  late MockGetPlayers mockGetPlayers;
  late PlayerCubit cubit;
  setUp(() {
    mockGetPlayers = MockGetPlayers();
    cubit = PlayerCubit(getPlayersUseCase: mockGetPlayers);
  });

  test('initial State should be InitialState', () {
    // assert
    expect(cubit.state, isA<InitialState>());
  });

  group('get Players from local database', () {
    final tPlayers = [Player(username: 'user', totalScore: 1)];

    test('should emit loading loaded when data is available', () async {
      when(mockGetPlayers(Params()))
          .thenAnswer((realInvocation) async => Right(tPlayers));

      final expected = [
        InitialState(),
        LoadingState(),
        AllPlayersRetrievedSuccessState(tPlayers)
      ];
      expectLater(cubit, emitsInOrder(expected));
      cubit.getPlayers();
    });
  });
}
