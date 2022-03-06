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
      return Visibility(
        visible: !game.hasStarted(),
        child: Flexible(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              Text(
                'Selecciona tu personaje',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 16),
              ),
              Text(
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
