import 'dart:math';
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
