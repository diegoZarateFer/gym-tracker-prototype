import 'package:flutter/material.dart';

class HistoryLogCell extends StatelessWidget {
  const HistoryLogCell({
    super.key,
    required this.value,
    this.isPr = false,
    this.isFailure = false,
  });

  final String value;

  final bool isPr;
  final bool isFailure;

  @override
  Widget build(BuildContext context) {
    final showIcon = isPr || isFailure;

    return TableCell(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 2),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            color: Theme.of(context).colorScheme.background,
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                value,
                textAlign: TextAlign.center,
              ),
              if (showIcon)
                Icon(
                  isPr
                      ? Icons.arrow_upward_outlined
                      : Icons.arrow_downward_rounded,
                  color: isPr ? Colors.green : Colors.red,
                ),
            ],
          ),
        ),
      ),
    );
  }
}
