import 'package:flutter/material.dart';

class CheckButton extends StatelessWidget {
  const CheckButton({
    super.key,
    required this.isChecked,
    required this.title,
    this.subtitle,
    required this.onPressed,
  });

  final bool isChecked;
  final String title;
  final String? subtitle;
  final void Function() onPressed;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        decoration: BoxDecoration(
          color: isChecked
              ? Theme.of(context).colorScheme.primary
              : Theme.of(context).colorScheme.secondary,
          borderRadius: BorderRadius.circular(20),
          border: isChecked ? Border.all(color: Colors.white, width: 2) : null,
        ),
        child: TextButton(
          onPressed: onPressed,
          style: TextButton.styleFrom(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
            foregroundColor: Colors.white,
          ),
          child: Row(
            children: [
              Column(
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      fontWeight: isChecked
                          ? FontWeight.bold
                          : FontWeight.normal,
                      color: isChecked ? Colors.white : Colors.white70,
                    ),
                  ),
                  if (subtitle != null) const SizedBox(height: 4),
                  if (subtitle != null)
                    Text(
                      subtitle!,
                      style: TextStyle(
                        fontWeight: isChecked
                            ? FontWeight.bold
                            : FontWeight.normal,
                        color: isChecked ? Colors.white : Colors.white70,
                      ),
                    ),
                ],
              ),
              const Spacer(),
              if (isChecked) Icon(Icons.check, size: 20),
            ],
          ),
        ),
      ),
    );
  }
}
