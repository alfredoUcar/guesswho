import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:guesswho/screens/dual_device_game.dart';
import 'package:guesswho/screens/single_device_game.dart';
import 'package:guesswho/states/game.dart';
import 'package:provider/provider.dart';

class Home extends StatelessWidget {
  static const routeName = 'home';
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Consumer<Game>(
          builder: (context, game, child) => Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              const Image(image: AssetImage('lib/assets/wide_text_logo.png')),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(horizontal: 18),
                child: Row(
                  children: [
                    SizedBox(
                      height: 200,
                      child: ElevatedButton(
                          onPressed: () {
                            FirebaseAnalytics.instance.logEvent(
                              name: "start_game",
                              parameters: {"mode": "single_device"},
                            );
                            game.initialize(DeviceMode.single);
                            Navigator.of(context)
                                .pushNamed(SingleDeviceGame.routeName);
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                const Icon(
                                  Icons.smartphone,
                                  size: 100,
                                ),
                                Text(AppLocalizations.of(context)!.oneDevice),
                              ],
                            ),
                          )),
                    ),
                    const SizedBox(width: 10),
                    SizedBox(
                      height: 200,
                      child: ElevatedButton(
                          onPressed: () {
                            FirebaseAnalytics.instance.logEvent(
                              name: "start_game",
                              parameters: {"mode": "multiple_device"},
                            );
                            game.initialize(DeviceMode.multi);
                            Navigator.of(context)
                                .pushNamed(DualDeviceGame.routeName);
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                const Icon(
                                  Icons.offline_share,
                                  size: 100,
                                ),
                                Text(
                                  AppLocalizations.of(context)!.twoDevices,
                                  textAlign: TextAlign.center,
                                ),
                              ],
                            ),
                          )),
                    ),
                    const SizedBox(width: 10),
                    SizedBox(
                      height: 200,
                      child: InkWell(
                        onTap: () {
                          FirebaseAnalytics.instance.logEvent(
                            name: "start_game",
                            parameters: {"mode": "online"},
                          );
                        },
                        child: ElevatedButton(
                            onPressed: null,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  const Icon(
                                    Icons.connect_without_contact,
                                    size: 100,
                                  ),
                                  Text(
                                    AppLocalizations.of(context)!.online,
                                    textAlign: TextAlign.center,
                                  ),
                                  Text(
                                    "(" +
                                        AppLocalizations.of(context)!
                                            .notAvailable +
                                        ")",
                                    textAlign: TextAlign.center,
                                  ),
                                ],
                              ),
                            )),
                      ),
                    ),
                  ],
                ),
              ),
              if (game.hasStarted())
                ElevatedButton(
                    onPressed: () {
                      FirebaseAnalytics.instance.logEvent(
                        name: "resume_game",
                        parameters: {"mode": game.mode().toString()},
                      );
                      if (game.mode() == DeviceMode.single) {
                        Navigator.of(context)
                            .pushNamed(SingleDeviceGame.routeName);
                      } else {
                        Navigator.of(context)
                            .pushNamed(DualDeviceGame.routeName);
                      }
                    },
                    child: Text(AppLocalizations.of(context)!.resume)),
            ],
          ),
        ),
      ),
    );
  }
}
