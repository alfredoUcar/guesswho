import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:guesswho/screens/next_player.dart';
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
                FirebaseAnalytics.instance.logEvent(
                  name: "start_questions_rounds",
                  parameters: {
                    "mode": game.mode() == DeviceMode.single
                        ? "single_device"
                        : "multiple_device",
                  },
                );
                FirebaseAnalytics.instance.logEvent(
                  name: "character_confirmed",
                  parameters: {
                    "mode": game.mode() == DeviceMode.single
                        ? 'single_device'
                        : 'multiple_device',
                    "name": game.selectedCharacter,
                  },
                );
                if (game.mode() == DeviceMode.single) {
                  Navigator.of(context)
                      .pushReplacementNamed(NextPlayer.routeName)
                      .then((value) => game.endTurn());
                }
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
              AppLocalizations.of(context)!.start,
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
