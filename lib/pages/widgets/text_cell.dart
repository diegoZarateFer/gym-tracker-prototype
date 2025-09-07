import 'package:flutter/material.dart';

class TextCell extends StatelessWidget {
  const TextCell(
    this.text, {
    super.key,
  });

  final String text;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: 10,
        horizontal: 2,
      ),
      child: Text(
        text,
        textAlign: TextAlign.center,
      ),
    );
  }
}
