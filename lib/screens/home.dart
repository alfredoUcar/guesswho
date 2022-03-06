import 'package:flutter/material.dart';
import 'package:guesswho/screens/dual_device_game.dart';
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
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  SizedBox(
                    height: 200,
                    child: ElevatedButton(
                        onPressed: () {
                          game.mode = DeviceMode.single;
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: const [
                              Icon(
                                Icons.smartphone,
                                size: 100,
                              ),
                              Text("Un dispositivo"),
                            ],
                          ),
                        )),
                  ),
                  SizedBox(
                    height: 200,
                    child: ElevatedButton(
                        onPressed: () {
                          game.mode = DeviceMode.multi;
                          Navigator.of(context)
                              .pushNamed(DualDeviceGame.routeName);
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: const [
                              Icon(
                                Icons.offline_share,
                                size: 100,
                              ),
                              Text(
                                'Dos dispositivos',
                                textAlign: TextAlign.center,
                              ),
                            ],
                          ),
                        )),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
