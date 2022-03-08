import 'package:flutter/material.dart';
import 'package:guesswho/states/game.dart';
import 'package:provider/provider.dart';

class DualDeviceTurnHelp extends StatelessWidget {
  const DualDeviceTurnHelp({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<Game>(builder: (context, game, child) {
      var text =
          'Realiza una pregunta al otro jugador sobre su personaje o intenta adivinarlo';
      if (game.mode() == DeviceMode.single) {
        if (game.isPlayerOneTurn()) {
          text = 'Jugador 1:\n ${text.toLowerCase()}';
        } else {
          text = 'Jugador 2:\n ${text.toLowerCase()}';
        }
      }
      return Visibility(
        visible: game.hasStarted(),
        child: Flexible(
          flex: 2,
          child: Container(
            alignment: Alignment.center,
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Text(
              text,
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 16),
            ),
          ),
        ),
      );
    });
  }
}
