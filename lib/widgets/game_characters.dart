import 'package:flutter/material.dart';
import 'package:guesswho/states/game.dart';
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
    return OrientationBuilder(builder: (context, orientation) {
      return Consumer<Game>(
        builder: (context, game, child) {
          var gridColumns = orientation == Orientation.portrait ? 3 : 4;
          return GridView.count(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              crossAxisCount:
                  game.displayMode == DisplayMode.grid ? gridColumns : 1,
              mainAxisSpacing: 10,
              crossAxisSpacing: 10,
              children: List.generate(names.length, (index) {
                return InkWell(
                  onTap: () {
                    onTap(names.elementAt(index));
                  },
                  onLongPress: () {
                    onLongPress(names.elementAt(index));
                  },
                  child: GridTile(
                    footer: Padding(
                      padding: const EdgeInsets.only(bottom: 5),
                      child: Stack(
                        alignment: AlignmentDirectional.center,
                        children: [
                          Text(
                            names.elementAt(index),
                            style: TextStyle(
                              fontSize: 16,
                              foreground: Paint()
                                ..style = PaintingStyle.stroke
                                ..strokeWidth = 3
                                ..color = Colors.black,
                            ),
                          ),
                          Text(
                            names.elementAt(index),
                            style: TextStyle(
                              fontSize: 16,
                              foreground: Paint()..color = getNameColor(index),
                            ),
                          ),
                        ],
                      ),
                    ),
                    child: Container(
                      padding: const EdgeInsets.only(bottom: 24, top: 5),
                      decoration: BoxDecoration(
                        border: Border.all(
                          width: 2,
                          color: Colors.black,
                        ),
                        borderRadius: BorderRadius.circular(5),
                        color: getBackgroundColor(index),
                      ),
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          Hero(
                            tag: names.elementAt(index),
                            child: Image(
                                color: getImageColor(index),
                                image: AssetImage(
                                    "lib/assets/characters/${names.elementAt(index)}.png")),
                          ),
                          if (discarded.contains(names.elementAt(index)))
                            const Icon(
                              Icons.not_interested,
                              color: Colors.red,
                              size: 60,
                            ),
                        ],
                      ),
                    ),
                  ),
                );
              }));
        },
      );
    });
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
