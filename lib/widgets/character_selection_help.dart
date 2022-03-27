import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:guesswho/states/game.dart';
import 'package:provider/provider.dart';

class CharacterSelectionHelp extends StatelessWidget {
  const CharacterSelectionHelp({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<Game>(builder: (context, game, child) {
      var text = AppLocalizations.of(context)!.singlePlayerSelectCharacter;
      if (game.mode() == DeviceMode.single) {
        if (game.isPlayerOneTurn()) {
          text = AppLocalizations.of(context)!.firstPlayerSelectCharacter;
        } else {
          text = AppLocalizations.of(context)!.secondPlayerSelectCharacter;
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
                style: const TextStyle(fontSize: 16),
              ),
              Text(
                AppLocalizations.of(context)!.longPressToZoomIn,
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      );
    });
  }
}
