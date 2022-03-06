import 'package:flutter/material.dart';
import 'package:guesswho/states/game.dart';
import 'package:provider/provider.dart';

class StartButton extends StatelessWidget {
  const StartButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<Game>(builder: (context, game, child) {
      return InkWell(
        onTap: game.selectedCharacter == null
            ? null
            : () {
                game.start();
              },
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(height: 10),
            Icon(
              Icons.play_arrow,
              color:
                  game.selectedCharacter == null ? Colors.grey : Colors.black,
            ),
            Text(
              'Empezar',
              style: TextStyle(
                color:
                    game.selectedCharacter == null ? Colors.grey : Colors.black,
              ),
            ),
            const SizedBox(height: 10),
          ],
        ),
      );
    });
  }
}
