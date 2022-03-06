import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';

enum DeviceMode { single, multi }

class Game extends ChangeNotifier {
  DeviceMode? _mode;
  List<String> _characters = [];
  final List<String> _discardedCharacters = [];
  String? _selectedCharacter;
  String? _focusedCharacter;
  bool _started = false;

  Game() {
    getCharactersNames().then((value) {
      _characters = value;
      notifyListeners();
    });
  }

  List<String> get discardedCharacters => _discardedCharacters;

  void sortCharacters() {
    _characters.sort((String a, String b) {
      // both visible or discarded
      if (_discardedCharacters.contains(a) &&
              _discardedCharacters.contains(b) ||
          !_discardedCharacters.contains(a) &&
              !_discardedCharacters.contains(b)) {
        return a.compareTo(b);
      } else {
        if (_discardedCharacters.contains(a)) {
          return 1;
        } else {
          return -1;
        }
      }
    });
    notifyListeners();
  }

  void toggleCharacter(String name) {
    if (_discardedCharacters.contains(name)) {
      _discardedCharacters.remove(name);
    } else {
      _discardedCharacters.add(name);
    }
    notifyListeners();
  }

  void start() {
    _started = true;
    _focusedCharacter = null;
    notifyListeners();
  }

  bool hasStarted() => _started;

  void end() {
    _started = false;
    _selectedCharacter = null;
    _focusedCharacter = null;
    _discardedCharacters.clear();
    notifyListeners();
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

  String? get focusedCharacter => _focusedCharacter;

  set focusedCharacter(String? name) {
    if (_focusedCharacter != name) {
      _focusedCharacter = name;
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
