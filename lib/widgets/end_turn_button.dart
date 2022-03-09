import 'package:flutter/material.dart';
import 'package:guesswho/screens/next_player.dart';
import 'package:guesswho/states/game.dart';
import 'package:provider/provider.dart';

class EndTurnButton extends StatelessWidget {
  const EndTurnButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.of(context).pushReplacementNamed(NextPlayer.routeName).then(
            (value) => Provider.of<Game>(context, listen: false).endTurn());
      },
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: const [
          SizedBox(height: 10),
          Icon(
            Icons.navigate_next,
            color: Colors.black,
          ),
          Text(
            'Finalizar turno',
            style: TextStyle(
              color: Colors.black,
            ),
          ),
          SizedBox(height: 10),
        ],
      ),
    );
  }
}
