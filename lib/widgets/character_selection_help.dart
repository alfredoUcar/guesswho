import 'package:flutter/material.dart';
import 'package:guesswho/states/game.dart';
import 'package:provider/provider.dart';

class CharacterSelectionHelp extends StatelessWidget {
  const CharacterSelectionHelp({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<Game>(builder: (context, game, child) {
      var text = 'Selecciona tu personaje';
      if (game.mode() == DeviceMode.single) {
        if (game.isPlayerOneTurn()) {
          text = 'Selecciona tu personaje Jugador 1';
        } else {
          text = 'Selecciona tu personaje Jugador 2';
        }
      }
      return Visibility(
        visible: !game.hasStarted(),
        child: Flexible(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                text,
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 16),
              ),
              const Text(
                '(Mantén pulsado para ampliar)',
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      );
    });
  }
}
