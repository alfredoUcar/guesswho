import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:guesswho/states/game.dart';
import 'package:provider/provider.dart';

class EndButton extends StatelessWidget {
  const EndButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<Game>(builder: (context, game, child) {
      return InkWell(
        onTap: game.selectedCharacter == null
            ? null
            : () {
                FirebaseAnalytics.instance.logEvent(
                  name: "end_game",
                  parameters: {
                    "type": game.mode() == DeviceMode.single
                        ? "single_device"
                        : "multiple_device",
                    "remaining_characters": (game.characters.length -
                        game.discardedCharacters.length),
                  },
                );
                game.end();
              },
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(height: 10),
            const Icon(
              Icons.sports_score,
              color: Colors.black,
            ),
            Text(
              AppLocalizations.of(context)!.endGame,
              style: const TextStyle(
                color: Colors.black,
              ),
            ),
            const SizedBox(height: 10),
          ],
        ),
      );
    });
  }
}
