import 'package:flutter/material.dart';
import 'package:guesswho/states/game.dart';
import 'package:guesswho/widgets/game_characters.dart';
import 'package:guesswho/widgets/selected_character_miniature.dart';
import 'package:guesswho/widgets/selected_character_placeholder.dart';
import 'package:provider/provider.dart';

import 'character_detail.dart';

class DualDeviceGame extends StatelessWidget {
  static const routeName = 'character-selection';
  const DualDeviceGame({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<Game>(
      builder: (context, game, child) => Scaffold(
        backgroundColor: Colors.grey.shade100,
        bottomNavigationBar: BottomAppBar(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              game.selectedCharacter == null
                  ? const SelectedCharacterPlaceholder()
                  : const SelectedCharacterMiniature(),
              InkWell(
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
            ],
          ),
        ),
        body: game.characters.isEmpty
            ? const Center(child: CircularProgressIndicator())
            : Column(
                children: [
                  const Flexible(
                    flex: 1,
                    child: Image(
                        image: AssetImage('lib/assets/wide_text_logo.png')),
                  ),
                  Flexible(
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
                        Navigator.of(context)
                            .pushNamed(CharacterDetail.routeName);
                      },
                      focusedCharacter:
                          game.hasStarted() ? null : game.selectedCharacter,
                      discarded: game.discardedCharacters,
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
                  Visibility(
                    visible: game.hasStarted(),
                    child: Flexible(
                      child: Container(
                        alignment: Alignment.center,
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: const Text(
                          'Intercambia preguntas de "sí o no" y descarta personajes hasta adivinar el del otro jugador',
                          textAlign: TextAlign.center,
                          style: TextStyle(fontSize: 16),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
      ),
    );
  }
}
