import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:guesswho/widgets/game_characters.dart';

class Board extends StatefulWidget {
  static const routeName = 'board';
  const Board({Key? key}) : super(key: key);

  @override
  State<Board> createState() => _BoardState();
}

class _BoardState extends State<Board> {
  List<String> names = [];

  @override
  void initState() {
    super.initState();
    getCharactersNames().then((value) {
      setState(() {
        names = value;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.grey.shade100,
        body: (names.isEmpty
            ? const CircularProgressIndicator()
            : Column(
                children: [
                  const Flexible(
                    flex: 2,
                    child: Image(
                        image: AssetImage('lib/assets/wide_text_logo.png')),
                  ),
                  Flexible(
                    flex: 8,
                    child: GameCharacters(
                      names: names,
                      onTap: (String name) {},
                      onLongPress: (String name) {},
                      discarded: const [],
                    ),
                  ),
                ],
              )));
  }

  Future<List<String>> getCharactersNames() async {
    final Map<String, dynamic> manifest =
        json.decode(await rootBundle.loadString('AssetManifest.json'));

    var images = manifest.keys
        .where((element) => element.startsWith('lib/assets/characters/'));

    var names = images.map((element) {
      return element.split("/").last.split(".").first;
    }).toList();

    return names;
  }
}
