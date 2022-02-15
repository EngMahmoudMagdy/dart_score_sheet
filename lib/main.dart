import 'package:dart_scoresheet/cubit/player_cubit.dart';
import 'package:dart_scoresheet/data/repos/playerRepo.dart';
import 'package:dart_scoresheet/pages/registerPlayersPage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => PlayerCubit(PlayerRepoImpl()),
            child: const RegisterPlayersPage(),
          )
        ],
        child: const MaterialApp(
          title: 'Material App',
          home:RegisterPlayersPage(),
        ));
  }
}
