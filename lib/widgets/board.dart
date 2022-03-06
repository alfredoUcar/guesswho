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
                game.selectedCharacter = null;
              } else {
                game.selectedCharacter = name;
              }
            } else {
              game.toggleCharacter(name);
            }
          },
          onLongPress: (String name) {
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
