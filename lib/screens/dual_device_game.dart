import 'package:flutter/material.dart';
import 'package:guesswho/states/game.dart';
import 'package:guesswho/widgets/board.dart';
import 'package:guesswho/widgets/character_selection_help.dart';
import 'package:guesswho/widgets/dual_device_turn_help.dart';
import 'package:guesswho/widgets/logo.dart';
import 'package:guesswho/widgets/selected_character_miniature.dart';
import 'package:guesswho/widgets/selected_character_placeholder.dart';
import 'package:provider/provider.dart';

class DualDeviceGame extends StatelessWidget {
  static const routeName = 'character-selection';
  const DualDeviceGame({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<Game>(
      builder: (context, game, child) => Scaffold(
        backgroundColor: Colors.grey.shade100,
        bottomNavigationBar: BottomAppBar(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              game.selectedCharacter == null
                  ? const SelectedCharacterPlaceholder()
                  : const SelectedCharacterMiniature(),
              InkWell(
                onTap: game.selectedCharacter == null
                    ? null
                    : () {
                        if (game.hasStarted()) {
                          game.end();
                        } else {
                          game.start();
                        }
                      },
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const SizedBox(height: 10),
                    Icon(
                      game.hasStarted() ? Icons.stop : Icons.play_arrow,
                      color: game.selectedCharacter == null
                          ? Colors.grey
                          : Colors.black,
                    ),
                    Text(
                      game.hasStarted() ? 'Finalizar' : 'Empezar',
                      style: TextStyle(
                        color: game.selectedCharacter == null
                            ? Colors.grey
                            : Colors.black,
                      ),
                    ),
                    const SizedBox(height: 10),
                  ],
                ),
              ),
            ],
          ),
        ),
        body: game.characters.isEmpty
            ? const Center(child: CircularProgressIndicator())
            : Column(
                children: const [
                  Logo(),
                  Board(),
                  CharacterSelectionHelp(),
                  DualDeviceTurnHelp(),
                ],
              ),
      ),
    );
  }
}
