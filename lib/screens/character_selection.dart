import 'package:flutter/material.dart';
import 'package:guesswho/states/game.dart';
import 'package:guesswho/widgets/game_characters.dart';
import 'package:provider/provider.dart';

class CharacterSelection extends StatelessWidget {
  static const routeName = 'character-selection';
  const CharacterSelection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<Game>(
      builder: (context, game, child) => Scaffold(
        backgroundColor: Colors.grey.shade100,
        floatingActionButton: Visibility(
          visible: game.selectedCharacter != null,
          child: FloatingActionButton(
            child: const Icon(Icons.play_arrow),
            onPressed: () {},
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
                  game.characters.isEmpty
                      ? const CircularProgressIndicator()
                      : Flexible(
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
                            focusedCharacter: game.selectedCharacter,
                          ),
                        ),
                ],
              ),
      ),
    );
  }
}
