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
                    child: Characters(names: names),
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
          padding: const EdgeInsets.symmetric(horizontal: 20),
          crossAxisCount: orientation == Orientation.portrait ? 3 : 4,
          mainAxisSpacing: 10,
          crossAxisSpacing: 10,
          children: List.generate(names.length, (index) {
            return InkWell(
              onTap: () {
                print("tap on ${names.elementAt(index)}");
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
                          foreground: Paint()..color = Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
                child: Container(
                  padding: const EdgeInsets.only(bottom: 24, top: 5),
                  decoration: BoxDecoration(
                    border: Border.all(width: 2),
                    borderRadius: BorderRadius.circular(5),
                    color: Colors.white,
                  ),
                  child: Image(
                      image: AssetImage(
                          "lib/assets/characters/${names.elementAt(index)}.png")),
                ),
              ),
            );
          })),
    );
  }
}
