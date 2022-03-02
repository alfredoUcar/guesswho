import 'package:flutter/material.dart';
import 'package:guesswho/screens/character_selection.dart';
import 'package:guesswho/screens/home.dart';
import 'package:guesswho/states/game.dart';
import 'package:provider/provider.dart';

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => Game()),
      ],
      child: MaterialApp(
        title: 'Adivina quién',
        theme: ThemeData(
            colorScheme: Theme.of(context).colorScheme.copyWith(
                  primary: Colors.purple.shade600,
                )),
        home: const Home(),
        routes: {
          Home.routeName: (context) => const Home(),
          CharacterSelection.routeName: (context) => const CharacterSelection(),
        },
      ),
    );
  }
}
