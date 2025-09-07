import 'package:flutter/material.dart';

class FieldCell extends StatelessWidget {
  const FieldCell({
    super.key,
    required this.value,
    required this.onRegisterSet,
  });

  final String value;
  final void Function() onRegisterSet;

  @override
  Widget build(BuildContext context) {
    return TableCell(
      child: GestureDetector(
        onTap: onRegisterSet,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 2),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              color: Theme.of(context).colorScheme.background,
            ),
            child: Text(
              value,
              textAlign: TextAlign.center,
            ),
          ),
        ),
      ),
    );
  }
}
