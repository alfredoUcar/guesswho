import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class SelectedCharacterPlaceholder extends StatelessWidget {
  const SelectedCharacterPlaceholder({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(
          Icons.account_circle,
          size: 30,
          color: Colors.grey.shade700,
        ),
        Text(AppLocalizations.of(context)!.yourCharacter),
      ],
    );
  }
}
