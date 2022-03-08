import 'package:flutter/material.dart';
import 'package:guesswho/states/game.dart';
import 'package:provider/provider.dart';

class DoneButton extends StatelessWidget {
  const DoneButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<Game>(builder: (context, game, child) {
      return InkWell(
        onTap: game.selectedCharacter == null
            ? null
            : () {
                if (game.hasStarted()) {
                  // TODO: navigate to transition page
                } else if (!game.isPlayerOneTurn()) {
                  // TODO: navigate to transition page
                  game.start();
                }
                game.endTurn();
              },
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(height: 10),
            Icon(
              Icons.done_outline,
              color:
                  game.selectedCharacter == null ? Colors.grey : Colors.black,
            ),
            Text(
              'Hecho',
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
