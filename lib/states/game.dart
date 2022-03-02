import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';

enum DeviceMode { single, multi }

class Game extends ChangeNotifier {
  DeviceMode? _mode;
  List<String> _characters = [];
  String? _selectedCharacter;

  Game() {
    getCharactersNames().then((value) {
      _characters = value;
      notifyListeners();
    });
  }

  List<String> get characters => _characters;

  DeviceMode? get mode => _mode;

  set mode(DeviceMode? mode) {
    if (mode != _mode) {
      _mode = mode;
      notifyListeners();
    }
  }

  String? get selectedCharacter => _selectedCharacter;

  set selectedCharacter(String? name) {
    if (_selectedCharacter != name) {
      _selectedCharacter = name;
      notifyListeners();
    }
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
