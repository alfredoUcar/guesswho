import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
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
        body: (names.isEmpty
            ? const CircularProgressIndicator()
            : Characters(names: names)));
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

class Characters extends StatelessWidget {
  const Characters({
    Key? key,
    required this.names,
  }) : super(key: key);

  final List<String> names;

  @override
  Widget build(BuildContext context) {
    return OrientationBuilder(
      builder: (context, orientation) => GridView.count(
          crossAxisCount: orientation == Orientation.portrait ? 3 : 4,
          children: List.generate(names.length, (index) {
            return GridTile(
              footer: Text(
                names.elementAt(index),
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 20),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Image(
                    image: AssetImage(
                        "lib/assets/characters/${names.elementAt(index)}.png")),
              ),
            );
          })),
    );
  }
}
