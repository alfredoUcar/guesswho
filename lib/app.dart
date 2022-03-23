import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:guesswho/screens/character_detail.dart';
import 'package:guesswho/screens/dual_device_game.dart';
import 'package:guesswho/screens/home.dart';
import 'package:guesswho/screens/next_player.dart';
import 'package:guesswho/screens/selected_character_detail.dart';
import 'package:guesswho/screens/single_device_game.dart';
import 'package:guesswho/states/game.dart';
import 'package:provider/provider.dart';

class App {
  static Future<void> init() async {
    WidgetsFlutterBinding.ensureInitialized();
    await Firebase.initializeApp();
    await FirebaseAnalytics.instance.logAppOpen();
  }

  static Widget create() {
    return const Guesswho();
  }
}

class Guesswho extends StatelessWidget {
  const Guesswho({Key? key}) : super(key: key);

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
        navigatorObservers: [
          FirebaseAnalyticsObserver(analytics: FirebaseAnalytics.instance)
        ],
        home: const Home(),
        routes: {
          Home.routeName: (context) => const Home(),
          DualDeviceGame.routeName: (context) => const DualDeviceGame(),
          SingleDeviceGame.routeName: (context) => const SingleDeviceGame(),
          CharacterDetail.routeName: (context) => const CharacterDetail(),
          NextPlayer.routeName: (context) => const NextPlayer(),
          SelectedCharacterDetail.routeName: (context) =>
              const SelectedCharacterDetail(),
        },
      ),
    );
  }
}
