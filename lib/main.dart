import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'features/scoresheet/data/repos/player_repo_impl.dart';
import 'features/scoresheet/presentation/cubit/player_cubit.dart';
import 'features/scoresheet/presentation/pages/registerPlayersPage.dart';

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
          home: RegisterPlayersPage(),
        ));
  }
}
