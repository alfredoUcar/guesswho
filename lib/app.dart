import 'package:flutter/material.dart';
import 'package:guesswho/screens/character_detail.dart';
import 'package:guesswho/screens/dual_device_game.dart';
import 'package:guesswho/screens/home.dart';
import 'package:guesswho/screens/selected_character_detail.dart';
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
          DualDeviceGame.routeName: (context) => const DualDeviceGame(),
          CharacterDetail.routeName: (context) => const CharacterDetail(),
          SelectedCharacterDetail.routeName: (context) =>
              const SelectedCharacterDetail(),
        },
      ),
    );
  }
}
