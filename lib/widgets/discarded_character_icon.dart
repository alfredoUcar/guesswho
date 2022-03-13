import 'package:flutter/material.dart';

class DiscardedCharacterIcon extends StatefulWidget {
  const DiscardedCharacterIcon({
    Key? key,
  }) : super(key: key);

  @override
  State<DiscardedCharacterIcon> createState() => _DiscardedCharacterIconState();
}

class _DiscardedCharacterIconState extends State<DiscardedCharacterIcon>
    with TickerProviderStateMixin {
  late final AnimationController _animationController;
  late final Animation<double> _iconSize;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 200),
      vsync: this,
    );
    _iconSize = TweenSequence(
      <TweenSequenceItem<double>>[
        TweenSequenceItem<double>(
          tween: Tween<double>(begin: 60, end: 80)
              .chain(CurveTween(curve: Curves.ease)),
          weight: 40.0,
        ),
        TweenSequenceItem<double>(
          tween: Tween<double>(begin: 80, end: 40)
              .chain(CurveTween(curve: Curves.ease)),
          weight: 60.0,
        ),
      ],
    ).animate(_animationController);
    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animationController,
      builder: (context, _) {
        return Icon(
          Icons.not_interested,
          color: Colors.red,
          size: _iconSize.value,
        );
      },
    );
  }
}
