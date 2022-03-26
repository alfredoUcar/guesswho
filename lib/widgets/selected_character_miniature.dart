import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/material.dart';
import 'package:guesswho/screens/selected_character_detail.dart';
import 'package:guesswho/states/game.dart';
import 'package:provider/provider.dart';

class SelectedCharacterMiniature extends StatelessWidget {
  const SelectedCharacterMiniature({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<Game>(builder: (context, game, child) {
      return InkWell(
        onTap: () {
          FirebaseAnalytics.instance.logEvent(
            name: "zoom_character",
            parameters: {
              "source": "miniature",
              "name": game.selectedCharacter,
            },
          );
          game.focusedCharacter = game.selectedCharacter;
          Navigator.of(context).pushNamed(SelectedCharacterDetail.routeName);
        },
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(300),
              child: Container(
                padding: const EdgeInsets.all(5),
                decoration: BoxDecoration(
                  color: Colors.grey.shade700,
                ),
                child: Hero(
                  tag: 'selected-character-zoom',
                  child: Image(
                    height: 20,
                    image: AssetImage(
                        "lib/assets/characters/${game.selectedCharacter}.png"),
                  ),
                ),
              ),
            ),
            Text(game.selectedCharacter as String),
          ],
        ),
      );
    });
  }
}
