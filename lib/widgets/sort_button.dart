import 'package:flutter/material.dart';
import 'package:guesswho/states/game.dart';
import 'package:provider/provider.dart';

class SortButton extends StatelessWidget {
  const SortButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<Game>(builder: (context, game, child) {
      return InkWell(
        onTap: game.selectedCharacter == null
            ? null
            : () {
                game.sortCharacters();
              },
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: const [
            SizedBox(height: 10),
            Icon(
              Icons.sort,
              color: Colors.black,
            ),
            Text(
              'Ordenar',
              style: TextStyle(
                color: Colors.black,
              ),
            ),
            SizedBox(height: 10),
          ],
        ),
      );
    });
  }
}
