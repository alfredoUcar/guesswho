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
      return Visibility(
        visible: game.hasStarted(),
        child: Flexible(
          flex: 2,
          child: Container(
            alignment: Alignment.center,
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: const Text(
              'Intercambia preguntas de "sí o no" y descarta personajes hasta adivinar el del otro jugador',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 16),
            ),
          ),
        ),
      );
    });
  }
}
