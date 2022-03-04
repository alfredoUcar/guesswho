import 'package:flutter/material.dart';
import 'package:guesswho/states/game.dart';
import 'package:guesswho/widgets/game_characters.dart';
import 'package:provider/provider.dart';

import 'character_detail.dart';

class CharacterSelection extends StatelessWidget {
  static const routeName = 'character-selection';
  const CharacterSelection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<Game>(
      builder: (context, game, child) => Scaffold(
        backgroundColor: Colors.grey.shade100,
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton: Visibility(
          visible: game.selectedCharacter != null,
          child: FloatingActionButton(
            child: Icon(game.hasStarted() ? Icons.stop : Icons.play_arrow),
            onPressed: () {
              if (game.hasStarted()) {
                game.end();
              } else {
                game.start();
              }
            },
          ),
        ),
        body: game.characters.isEmpty
            ? const Center(child: CircularProgressIndicator())
            : Column(
                children: [
                  const Flexible(
                    flex: 2,
                    child: Image(
                        image: AssetImage('lib/assets/wide_text_logo.png')),
                  ),
                  const Flexible(
                      child: Text(
                    'Selecciona tu personaje',
                    style: TextStyle(
                      fontSize: 24,
                    ),
                  )),
                  const Flexible(
                      child: Text(
                    '(Mantén pulsado para ampliar)',
                    style: TextStyle(
                      fontSize: 16,
                    ),
                  )),
                  Flexible(
                    flex: 8,
                    child: GameCharacters(
                      names: game.characters,
                      onTap: (String name) {
                        if (name == game.selectedCharacter) {
                          game.selectedCharacter = null;
                        } else {
                          game.selectedCharacter = name;
                        }
                      },
                      onLongPress: (String name) {
                        game.focusedCharacter = name;
                        Navigator.of(context)
                            .pushNamed(CharacterDetail.routeName);
                      },
                      focusedCharacter: game.selectedCharacter,
                    ),
                  ),
                ],
              ),
      ),
    );
  }
}
