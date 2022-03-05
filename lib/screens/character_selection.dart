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
        bottomNavigationBar: BottomAppBar(
          child: InkWell(
            onTap: game.selectedCharacter == null
                ? null
                : () {
                    if (game.hasStarted()) {
                      game.end();
                    } else {
                      game.start();
                    }
                  },
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const SizedBox(height: 10),
                Icon(
                  game.hasStarted() ? Icons.stop : Icons.play_arrow,
                  color: game.selectedCharacter == null
                      ? Colors.grey
                      : Colors.black,
                ),
                Text(
                  game.hasStarted() ? 'Finalizar' : 'Empezar',
                  style: TextStyle(
                    color: game.selectedCharacter == null
                        ? Colors.grey
                        : Colors.black,
                  ),
                ),
                const SizedBox(height: 10),
              ],
            ),
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
                  Visibility(
                    visible: !game.hasStarted(),
                    child: Flexible(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const [
                          Text(
                            'Selecciona tu personaje',
                            textAlign: TextAlign.center,
                            style: TextStyle(fontSize: 16),
                          ),
                          Text(
                            '(Mantén pulsado para ampliar)',
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
      ),
    );
  }
}
