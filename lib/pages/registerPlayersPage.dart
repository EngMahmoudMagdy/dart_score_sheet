import 'package:dart_scoresheet/cubit/player_cubit.dart';
import 'package:dart_scoresheet/data/player.dart';
import 'package:dart_scoresheet/pages/scoreBoard.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RegisterPlayersPage extends StatefulWidget {
  const RegisterPlayersPage({Key? key}) : super(key: key);

  @override
  _RegisterPlayersPageState createState() => _RegisterPlayersPageState();
}

class _RegisterPlayersPageState extends State<RegisterPlayersPage> {
  final List<Player> _players = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Register players usernames"),
        ),
        body: SingleChildScrollView(
          child: Column(children: [
            const Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding:
                      EdgeInsets.symmetric(vertical: 32.0, horizontal: 32.0),
                  child: Text(
                    "Users registered:",
                    style: TextStyle(fontSize: 24, color: Colors.black),
                    textAlign: TextAlign.start,
                  ),
                )),
            const SizedBox(
              height: 32.0,
            ),
            BlocConsumer<PlayerCubit, PlayerState>(
              listener: (context, state) {
                if (state is PlayerError) {
                  showSnackBar(state.error, isError: true);
                } else if (state is PlayerRemovedSuccess) {
                  _players.remove(state.player);
                  showSnackBar("Player removed successfully");
                } else if (state is PlayerAddedSuccess) {
                  _players.add(state.player);
                  showSnackBar("Player Added successfully");
                }
              },
              builder: (context, state) {
                if (state is PlayerLoading) {
                  return buildLoading();
                } else {
                  return buildRowWithData();
                }
              },
            ),
            const SizedBox(
              height: 18,
            ),
            CityInputField(),
            const SizedBox(
              height: 18,
            ),
            buildStartButton()
          ]),
        ));
  }

  Widget buildLoading() {
    return const Center(
      child: CircularProgressIndicator(),
    );
  }

  Widget buildRowWithData() {
    return Align(
      alignment: Alignment.centerLeft,
      child: Column(
        children: _players
            .map(
              (p) => Padding(
                padding: const EdgeInsets.only(left: 32.0, right: 32.0),
                child: Row(
                  children: [
                    Expanded(
                      flex: 6,
                      child: Text(
                        '*  ${p.username}',
                        style:
                            const TextStyle(fontSize: 24, color: Colors.black),
                        textAlign: TextAlign.start,
                      ),
                    ),
                    const SizedBox(
                      height: 8.0,
                    ),
                    Expanded(
                      flex: 1,
                      child: IconButton(
                          onPressed: () => context
                              .read<PlayerCubit>()
                              .removePlayer(p.username),
                          icon: const Icon(Icons.close)),
                    )
                  ],
                ),
              ),
            )
            .toList(),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    scaffoldState = ScaffoldMessenger.of(context);
  }

  late ScaffoldMessengerState scaffoldState;

  void showSnackBar(String s, {isError = false}) {
    scaffoldState.removeCurrentSnackBar();
    scaffoldState.showSnackBar(SnackBar(
        backgroundColor: isError ? const Color(0xffad0000) : Colors.black,
        content: Text(
          s,
          style: TextStyle(color: isError ? Colors.amberAccent : Colors.white),
        )));
  }

  Widget buildStartButton() {
    return ElevatedButton(
      style: ButtonStyle(
          textStyle:
              MaterialStateProperty.all(const TextStyle(color: Colors.white)),
          backgroundColor: MaterialStateProperty.all(Colors.blueAccent)),
      onPressed: () => navigateToScoreBoard(),
      child: const Text('Start game'),
    );
  }

  navigateToScoreBoard() {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => const ScoreBoard()));
  }
}

class CityInputField extends StatelessWidget {
  final _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 34),
      child: TextField(
        controller: _controller,
        onSubmitted: (value) => submitCityName(context, value),
        textInputAction: TextInputAction.go,
        decoration: InputDecoration(
          hintText: "Enter a username",
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
          suffixIcon: const Icon(Icons.add),
        ),
      ),
    );
  }

  void submitCityName(BuildContext context, String username) {
    context.read<PlayerCubit>().addPlayer(username);
    _controller.text = '';
  }
}
