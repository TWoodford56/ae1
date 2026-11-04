import 'package:flutter/material.dart';

class TravellerCount extends StatelessWidget {
  const new({
    super.key,
    required this._personCount,
    required this.theme,
    required this.onDecrement,
    required this.onIncrement,
  });

  final int _personCount;
  final ThemeData theme;
  final VoidCallback onDecrement;
  final VoidCallback onIncrement;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        IconButton(
          color: theme.colorScheme.primary,
          onPressed: onDecrement,
          icon: const Icon(Icons.remove),
        ),
        Text("$_personCount", style: theme.textTheme.titleMedium),
        IconButton(
          color: theme.colorScheme.primary,
          onPressed: onIncrement,
          icon: const Icon(Icons.add),
        ),
      ],
    );
  }
}
