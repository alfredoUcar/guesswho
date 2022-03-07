import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';

enum DeviceMode { single, multi }
enum Turn { player1, player2 }

class Game extends ChangeNotifier {
  DeviceMode? _mode;
  Turn _turn = Turn.player1;
  final Map<Turn, List<String>> _characters = {
    Turn.player1: [],
    Turn.player2: [],
  };
  final Map<Turn, List<String>> _discardedCharacters = {
    Turn.player1: [],
    Turn.player2: [],
  };
  final Map<Turn, String?> _selectedCharacter = {
    Turn.player1: null,
    Turn.player2: null,
  };
  String? _focusedCharacter;
  bool _started = false;

  Game() {
    getCharactersNames().then((value) {
      _characters[Turn.player1] = value;
      _characters[Turn.player2] = value;
      notifyListeners();
    });
  }

  List<String> get discardedCharacters =>
      _discardedCharacters[_turn] as List<String>;

  bool isPlayerOneTurn() => _turn == Turn.player1;

  void sortCharacters() {
    _characters[_turn]!.sort((String a, String b) {
      // both visible or discarded
      if (_discardedCharacters[_turn]!.contains(a) &&
              _discardedCharacters[_turn]!.contains(b) ||
          !_discardedCharacters[_turn]!.contains(a) &&
              !_discardedCharacters[_turn]!.contains(b)) {
        return a.compareTo(b);
      } else {
        if (_discardedCharacters[_turn]!.contains(a)) {
          return 1;
        } else {
          return -1;
        }
      }
    });
    notifyListeners();
  }

  void toggleCharacter(String name) {
    if (_discardedCharacters[_turn]!.contains(name)) {
      _discardedCharacters[_turn]!.remove(name);
    } else {
      _discardedCharacters[_turn]!.add(name);
    }
    notifyListeners();
  }

  void initialize(DeviceMode mode) {
    _mode = mode;
    _turn = Turn.player1;
    _started = false;
    _selectedCharacter[Turn.player1] = null;
    _selectedCharacter[Turn.player2] = null;
    _focusedCharacter = null;
    _discardedCharacters[Turn.player1]!.clear();
    _discardedCharacters[Turn.player2]!.clear();
    notifyListeners();
  }

  void start() {
    _started = true;
    _focusedCharacter = null;
    notifyListeners();
  }

  bool hasStarted() => _started;

  void end() {
    initialize(_mode as DeviceMode);
  }

  List<String> get characters => _characters[_turn] as List<String>;

  DeviceMode? mode() => _mode;

  String? get selectedCharacter => _selectedCharacter[_turn];

  set selectedCharacter(String? name) {
    if (_selectedCharacter[_turn] != name) {
      _selectedCharacter[_turn] = name;
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
