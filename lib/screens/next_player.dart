import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:guesswho/screens/single_device_game.dart';
import 'package:guesswho/states/game.dart';
import 'package:guesswho/widgets/ad_banner.dart';
import 'package:provider/provider.dart';

class NextPlayer extends StatelessWidget {
  static const routeName = 'next-player';

  const NextPlayer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    timeDilation = 2.5;
    return Consumer<Game>(
      builder: (context, game, child) => Scaffold(
        backgroundColor: Colors.grey.shade100,
        body: SafeArea(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                const Image(image: AssetImage('lib/assets/wide_text_logo.png')),
                const AdBanner(adNameKey: 'bannerAdId'),
                Text(
                  AppLocalizations.of(context)!.nextPlayer,
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    Navigator.of(context)
                        .pushReplacementNamed(SingleDeviceGame.routeName);
                  },
                  child: Text(AppLocalizations.of(context)!.continueGame),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
