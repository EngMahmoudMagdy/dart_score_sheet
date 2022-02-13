import 'package:dart_scoresheet/cubit/player_cubit.dart';
import 'package:dart_scoresheet/data/player.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RegisterPlayersPage extends StatefulWidget {
  const RegisterPlayersPage({Key? key}) : super(key: key);

  @override
  _RegisterPlayersPageState createState() => _RegisterPlayersPageState();
}

class _RegisterPlayersPageState extends State<RegisterPlayersPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Register players usernames"),
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(vertical: 16),
        alignment: Alignment.center,
        child: BlocConsumer<PlayerCubit, PlayerState>(
          listener: (context, state) {
            if (state is PlayerError) {
              ScaffoldMessenger.of(context)
                  .showSnackBar(SnackBar(content: Text(state.error)));
            }
          },
          builder: (context, state) {
            if (state is PlayerInitial) {
              return buildInitialInput();
            } else if (state is PlayerLoading) {
              return buildLoading();
            } else if (state is PlayerSuccess) {
              return buildRowWithData(state.players);
            } else {
              return buildInitialInput();
            }
          },
        ),
      ),
    );
  }

  Widget buildLoading() {
    return const Center(
      child: CircularProgressIndicator(),
    );
  }

  Widget buildInitialInput() {
    return Center(
      child: CityInputField(),
    );
  }

  Widget buildRowWithData(List<Player> players) {
    return Column(
      children: [
        const Align(
            alignment: Alignment.centerLeft,
            child: Padding(
              padding: EdgeInsets.only(left: 32.0, right: 32.0),
              child: Text(
                "Users registered:",
                style: TextStyle(fontSize: 24, color: Colors.black),
                textAlign: TextAlign.start,
              ),
            )),
        const SizedBox(
          height: 32.0,
        ),
        Align(
          alignment: Alignment.centerLeft,
          child: Column(
            children: players
                .map(
                  (e) => Padding(
                    padding: const EdgeInsets.only(left: 32.0, right: 32.0),
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '*  ${e.username}',
                            style: const TextStyle(
                                fontSize: 24, color: Colors.black),
                            textAlign: TextAlign.start,
                          ),
                          const SizedBox(
                            height: 8.0,
                          ),
                        ],
                      ),
                    ),
                  ),
                )
                .toList(),
          ),
        ),
        const SizedBox(
          height: 18,
        ),
        CityInputField(),
      ],
    );
  }
}

class CityInputField extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 50),
      child: TextField(
        onSubmitted: (value) => submitCityName(context, value),
        textInputAction: TextInputAction.done,
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
  }
}
