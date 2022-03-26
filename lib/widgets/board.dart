import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/material.dart';
import 'package:guesswho/screens/character_detail.dart';
import 'package:guesswho/states/game.dart';
import 'package:guesswho/widgets/game_characters.dart';
import 'package:provider/provider.dart';

class Board extends StatelessWidget {
  const Board({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<Game>(builder: (context, game, child) {
      return Flexible(
        flex: 10,
        child: GameCharacters(
          names: game.characters,
          onTap: (String name) {
            if (!game.hasStarted()) {
              if (name == game.selectedCharacter) {
                FirebaseAnalytics.instance.logEvent(
                  name: "unselect_character",
                  parameters: {
                    "name": name,
                  },
                );
                game.selectedCharacter = null;
              } else {
                FirebaseAnalytics.instance.logEvent(
                  name: "select_character",
                  parameters: {
                    "name": name,
                    "previous": game.selectedCharacter,
                  },
                );
                game.selectedCharacter = name;
              }
            } else {
              game.toggleCharacter(name);
            }
          },
          onLongPress: (String name) {
            FirebaseAnalytics.instance.logEvent(
              name: "zoom_character",
              parameters: {
                "source": "board",
                "name": name,
                "layout": game.displayMode.toString(),
              },
            );
            game.focusedCharacter = name;
            Navigator.of(context).pushNamed(CharacterDetail.routeName);
          },
          focusedCharacter: game.hasStarted() ? null : game.selectedCharacter,
          discarded: game.discardedCharacters,
        ),
      );
    });
  }
}
