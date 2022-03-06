import 'package:flutter/material.dart';

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
    return OrientationBuilder(
      builder: (context, orientation) => GridView.count(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          crossAxisCount: orientation == Orientation.portrait ? 3 : 4,
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
                    color: names.elementAt(index) == focusedCharacter
                        ? Colors.grey.shade700
                        : Colors.white,
                  ),
                  child: Hero(
                    tag: names.elementAt(index),
                    child: Image(
                        image: AssetImage(
                            "lib/assets/characters/${names.elementAt(index)}.png")),
                  ),
                ),
              ),
            );
          })),
    );
  }

  Color getNameColor(int index) {
    var name = names.elementAt(index);
    if (name == focusedCharacter) {
      return Colors.yellow;
    }

    if (discarded.contains(name)) {
      return Colors.red;
    }

    return Colors.white;
  }
}
