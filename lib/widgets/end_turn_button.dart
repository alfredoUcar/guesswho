import 'package:flutter/material.dart';
import 'package:guesswho/states/game.dart';
import 'package:provider/provider.dart';

class EndTurnButton extends StatelessWidget {
  const EndTurnButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<Game>(builder: (context, game, child) {
      return InkWell(
        onTap: game.selectedCharacter == null
            ? null
            : () {
                // TODO: navigate to transition page
                game.endTurn();
              },
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: const [
            SizedBox(height: 10),
            Icon(
              Icons.navigate_next,
              color: Colors.black,
            ),
            Text(
              'Finalizar turno',
              style: TextStyle(
                color: Colors.black,
              ),
            ),
            SizedBox(height: 10),
          ],
        ),
      );
    });
  }
}
