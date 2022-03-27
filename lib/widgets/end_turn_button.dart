import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:guesswho/screens/next_player.dart';
import 'package:guesswho/states/game.dart';
import 'package:provider/provider.dart';

class EndTurnButton extends StatelessWidget {
  const EndTurnButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<Game>(builder: (context, game, child) {
      return InkWell(
        onTap: () {
          FirebaseAnalytics.instance.logEvent(
            name: "end_turn",
            parameters: {
              "mode": game.mode() == DeviceMode.single
                  ? 'single_device'
                  : 'multiple_device',
              "layout": game.displayMode.toString(),
            },
          );
          Navigator.of(context)
              .pushReplacementNamed(NextPlayer.routeName)
              .then((value) => game.endTurn());
        },
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(height: 10),
            const Icon(
              Icons.navigate_next,
              color: Colors.black,
            ),
            Text(
              AppLocalizations.of(context)!.endTurn,
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
