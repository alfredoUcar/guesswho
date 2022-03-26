import 'dart:math';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/material.dart';
import 'package:guesswho/states/game.dart';
import 'package:provider/provider.dart';

class RandomCharacterButton extends StatelessWidget {
  const RandomCharacterButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<Game>(builder: (context, game, child) {
      return InkWell(
        onTap: () {
          FirebaseAnalytics.instance.logEvent(
            name: "select_random_character",
            parameters: {
              "previous": game.selectedCharacter,
            },
          );
          var randomIndex = Random().nextInt(game.characters.length - 1);
          game.selectedCharacter = game.characters.elementAt(randomIndex);
        },
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: const [
            Image(
              height: 30,
              image: AssetImage("lib/assets/square_logo.png"),
            ),
            Text('Aleatorio'),
          ],
        ),
      );
    });
  }
}
