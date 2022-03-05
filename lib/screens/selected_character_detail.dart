import 'package:flutter/material.dart';
import 'package:guesswho/screens/character_detail.dart';

class SelectedCharacterDetail extends CharacterDetail {
  static const routeName = 'selected-character-detail';

  const SelectedCharacterDetail({Key? key})
      : super(key: key, heroTag: 'selected-character-zoom');
}
