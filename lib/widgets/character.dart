import 'package:flutter/material.dart';
import 'package:guesswho/widgets/discarded_character_icon.dart';

class Character extends StatefulWidget {
  const Character({
    Key? key,
    required this.name,
    required this.discarded,
    required this.onTap,
    required this.onLongPress,
    required this.nameColor,
    required this.imageColor,
    required this.backgroundColor,
  }) : super(key: key);

  final String name;
  final bool discarded;
  final void Function() onTap;
  final void Function() onLongPress;
  final Color nameColor;
  final Color? imageColor;
  final Color backgroundColor;

  @override
  State<Character> createState() => _CharacterState();
}

class _CharacterState extends State<Character> with TickerProviderStateMixin {
  late final AnimationController _animationController;
  late final Animation<double> _imageExtraPadding;

  @override
  void initState() {
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 150),
      vsync: this,
    );
    _imageExtraPadding = TweenSequence(
      <TweenSequenceItem<double>>[
        TweenSequenceItem<double>(
          tween: Tween<double>(begin: 0, end: 5)
              .chain(CurveTween(curve: Curves.ease)),
          weight: 50.0,
        ),
        TweenSequenceItem<double>(
          tween: Tween<double>(begin: 5, end: 0)
              .chain(CurveTween(curve: Curves.ease)),
          weight: 50.0,
        ),
      ],
    ).animate(_animationController);
    super.initState();
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
        builder: (context, child) {
          return InkWell(
            onTap: () {
              widget.onTap();
              if (widget.discarded) {
                _animationController.forward(from: 0.0);
              }
            },
            onLongPress: widget.onLongPress,
            child: GridTile(
              footer: Padding(
                padding: const EdgeInsets.only(bottom: 5),
                child: Stack(
                  alignment: AlignmentDirectional.center,
                  children: [
                    Text(
                      widget.name,
                      style: TextStyle(
                        fontSize: 16,
                        foreground: Paint()
                          ..style = PaintingStyle.stroke
                          ..strokeWidth = 3
                          ..color = Colors.black,
                      ),
                    ),
                    Text(
                      widget.name,
                      style: TextStyle(
                        fontSize: 16,
                        foreground: Paint()..color = widget.nameColor,
                      ),
                    ),
                  ],
                ),
              ),
              child: Container(
                padding: EdgeInsets.only(
                  bottom: 25 - 2 * _imageExtraPadding.value,
                  top: 5 - _imageExtraPadding.value,
                ),
                decoration: BoxDecoration(
                  border: Border.all(
                    width: 2,
                    color: Colors.black,
                  ),
                  borderRadius: BorderRadius.circular(5),
                  color: widget.backgroundColor,
                ),
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    Hero(
                      tag: widget.name,
                      child: Image(
                          fit: BoxFit.fitWidth,
                          color: widget.imageColor,
                          image: AssetImage(
                              "lib/assets/characters/${widget.name}.png")),
                    ),
                    if (widget.discarded) const DiscardedCharacterIcon(),
                  ],
                ),
              ),
            ),
          );
        });
  }
}
