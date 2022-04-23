import 'package:flutter/material.dart';

import 'dart:convert';

import 'package:flutter/services.dart' show rootBundle;
import 'package:flutter/widgets.dart';

class Config extends ChangeNotifier {
  late Map _data;
  bool _loaded = false;

  Config(String environment) {
    _load(environment);
  }

  void _load(String environment) {
    rootBundle.loadString('lib/config/values/$environment.json').then((json) {
      _data = jsonDecode(json);
      _loaded = true;
      notifyListeners();
    });
  }

  bool get loaded => _loaded;

  Map get data => _loaded ? _data : {};
}
