import 'package:flutter/material.dart';

class AddSetCell extends StatelessWidget {
  const AddSetCell({
    super.key,
    required this.onAddSet,
  });

  final void Function() onAddSet;

  @override
  Widget build(BuildContext context) {
    return TableCell(
      child: Padding(
        padding: const EdgeInsets.symmetric(
          vertical: 10,
          horizontal: 2,
        ),
        child: GestureDetector(
          onTap: onAddSet,
          child: GestureDetector(
            child: const Icon(
              Icons.note_add,
            ),
          ),
        ),
      ),
    );
  }
}
