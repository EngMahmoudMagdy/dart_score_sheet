part of 'score_cubit.dart';

@immutable
abstract class ScoreState {}

class ScoreInitial extends ScoreState {}

class ScoreLoading extends ScoreState {}

class ScoreSuccess extends ScoreState {
  final int score;

  ScoreSuccess(this.score);
}

class ScoreError extends ScoreState {
  final String error;
  ScoreError(this.error);
}
