import 'package:flutter/material.dart';
import 'package:guesswho/app.dart';

void main() async {
  await App.init();
  runApp(App.create());
}
