import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:guesswho/states/game.dart';
import 'package:provider/provider.dart';

class CharacterDetail extends StatelessWidget {
  static const routeName = 'character-details';

  const CharacterDetail({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    timeDilation = 2.5;
    return Consumer<Game>(
      builder: (context, game, child) => Scaffold(
        backgroundColor: Colors.grey.shade100,
        body: game.selectedCharacter == null
            ? const Center(child: CircularProgressIndicator())
            : Column(
                children: [
                  const Flexible(
                    flex: 2,
                    child: Image(
                        image: AssetImage('lib/assets/wide_text_logo.png')),
                  ),
                  Expanded(
                    flex: 8,
                    child: Hero(
                      tag: game.selectedCharacter as String,
                      child: Image(
                          image: AssetImage(
                              "lib/assets/characters/${game.selectedCharacter}.png")),
                    ),
                  ),
                ],
              ),
      ),
    );
  }
}
