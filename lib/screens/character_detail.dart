import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:guesswho/states/game.dart';
import 'package:provider/provider.dart';

class CharacterDetail extends StatelessWidget {
  static const routeName = 'character-details';
  final String? _heroTag;

  const CharacterDetail({Key? key, String? heroTag})
      : _heroTag = heroTag,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    timeDilation = 2.5;
    return Consumer<Game>(
      builder: (context, game, child) => Scaffold(
        backgroundColor: Colors.grey.shade100,
        body: game.focusedCharacter == null
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
                      tag: _heroTag ?? game.focusedCharacter as String,
                      child: Image(
                          image: AssetImage(
                              "lib/assets/characters/${game.focusedCharacter}.png")),
                    ),
                  ),
                ],
              ),
      ),
    );
  }
}
