import 'package:flutter/material.dart';
import 'package:guesswho/states/game.dart';
import 'package:provider/provider.dart';

class DisplayModeButton extends StatelessWidget {
  const DisplayModeButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<Game>(builder: (context, game, child) {
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
                style: ElevatedButton.styleFrom(
                  shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(10),
                    bottomLeft: Radius.circular(10),
                  )),
                ),
                onPressed: game.displayMode == DisplayMode.grid
                    ? null
                    : () {
                        game.displayMode = DisplayMode.grid;
                      },
                child: const Icon(Icons.grid_view)),
            ElevatedButton(
                style: ElevatedButton.styleFrom(
                  shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.only(
                    topRight: Radius.circular(10),
                    bottomRight: Radius.circular(10),
                  )),
                ),
                onPressed: game.displayMode == DisplayMode.list
                    ? null
                    : () {
                        game.displayMode = DisplayMode.list;
                      },
                child: const Icon(Icons.view_list)),
          ],
        ),
      );
    });
  }
}
