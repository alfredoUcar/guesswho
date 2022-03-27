import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:guesswho/states/game.dart';
import 'package:provider/provider.dart';

class DualDeviceTurnHelp extends StatelessWidget {
  const DualDeviceTurnHelp({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<Game>(builder: (context, game, child) {
      var text = AppLocalizations.of(context)!.dualDeviceTurnHelp;
      if (game.mode() == DeviceMode.single) {
        if (game.isPlayerOneTurn()) {
          text =
              '${AppLocalizations.of(context)!.player1}:\n ${text.toLowerCase()}';
        } else {
          text =
              '${AppLocalizations.of(context)!.player2}\n ${text.toLowerCase()}';
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
