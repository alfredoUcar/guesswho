import 'package:flutter/material.dart';
import 'package:guesswho/states/game.dart';
import 'package:guesswho/widgets/character.dart';
import 'package:provider/provider.dart';

class GameCharacters extends StatelessWidget {
  const GameCharacters({
    Key? key,
    required this.names,
    required this.discarded,
    required this.onTap,
    required this.onLongPress,
    this.focusedCharacter,
  }) : super(key: key);

  final List<String> names;
  final List<String> discarded;
  final void Function(String name) onTap;
  final void Function(String name) onLongPress;
  final String? focusedCharacter;

  @override
  Widget build(BuildContext context) {
    return Consumer<Game>(
      builder: (context, game, child) {
        var orientation = MediaQuery.of(context).orientation;
        var gridColumns = orientation == Orientation.portrait ? 3 : 4;
        return GridView.count(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            crossAxisCount:
                game.displayMode == DisplayMode.grid ? gridColumns : 1,
            mainAxisSpacing: 10,
            crossAxisSpacing: 10,
            children: List.generate(names.length, (index) {
              return Character(
                discarded: discarded.contains(names.elementAt(index)),
                name: names.elementAt(index),
                onTap: () {
                  onTap(names.elementAt(index));
                },
                onLongPress: () {
                  onLongPress(names.elementAt(index));
                },
                nameColor: getNameColor(index),
                imageColor: getImageColor(index),
                backgroundColor: getBackgroundColor(index),
              );
            }));
      },
    );
  }

  Color getBackgroundColor(int index) {
    var name = names.elementAt(index);
    if (name == focusedCharacter) {
      return Colors.grey.shade700;
    }

    if (discarded.contains(name)) {
      return Colors.white;
    }

    return Colors.white;
  }

  Color getNameColor(int index) {
    var name = names.elementAt(index);
    if (name == focusedCharacter) {
      return Colors.yellow;
    }

    return Colors.white;
  }

  Color? getImageColor(int index) {
    var name = names.elementAt(index);

    if (discarded.contains(name)) {
      return Colors.grey.shade700;
    }

    return null;
  }
}
