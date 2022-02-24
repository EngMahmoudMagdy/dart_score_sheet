import 'package:equatable/equatable.dart';

class Player implements Equatable {
  final int totalScore;
  final String username;

  Player({required this.username, required this.totalScore});


  @override
  List<Object> get props => [totalScore, username];

  @override
  bool get stringify => true;

  Map<String, dynamic> toMap() {
    return {
      'totalScore': this.totalScore,
      'username': this.username,
    };
  }

  factory Player.fromMap(Map<String, dynamic> map) {
    return Player(
      totalScore: map['totalScore'] as int,
      username: map['username'] as String,
    );
  }
}
