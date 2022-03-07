import 'package:flutter/material.dart';

class Logo extends StatelessWidget {
  const Logo({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Flexible(
      flex: 1,
      child: Image(image: AssetImage('lib/assets/wide_text_logo.png')),
    );
  }
}