import 'package:flutter/material.dart';
import 'package:guesswho/states/game.dart';
import 'package:guesswho/widgets/board.dart';
import 'package:guesswho/widgets/character_selection_help.dart';
import 'package:guesswho/widgets/display_mode_button.dart';
import 'package:guesswho/widgets/dual_device_turn_help.dart';
import 'package:guesswho/widgets/end_button.dart';
import 'package:guesswho/widgets/logo.dart';
import 'package:guesswho/widgets/random_character_button.dart';
import 'package:guesswho/widgets/selected_character_miniature.dart';
import 'package:guesswho/widgets/selected_character_placeholder.dart';
import 'package:guesswho/widgets/sort_button.dart';
import 'package:guesswho/widgets/start_button.dart';
import 'package:provider/provider.dart';

class DualDeviceGame extends StatelessWidget {
  static const routeName = 'dual-device-game';
  const DualDeviceGame({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<Game>(
      builder: (context, game, child) => Scaffold(
        backgroundColor: Colors.grey.shade100,
        bottomNavigationBar: BottomAppBar(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              game.selectedCharacter == null
                  ? const SelectedCharacterPlaceholder()
                  : const SelectedCharacterMiniature(),
              if (!game.hasStarted()) const RandomCharacterButton(),
              game.hasStarted() ? const EndButton() : const StartButton(),
              if (game.hasStarted()) const SortButton(),
            ],
          ),
        ),
        body: game.characters.isEmpty
            ? const Center(child: CircularProgressIndicator())
            : SafeArea(
                child: Column(
                  children: const [
                    DisplayModeButton(),
                    Board(),
                    CharacterSelectionHelp(),
                    DualDeviceTurnHelp(),
                  ],
                ),
              ),
      ),
    );
  }
}
