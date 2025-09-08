import 'package:flutter/material.dart';
import 'package:gym_tracker_ui/core/extensions/context_ext.dart';
import 'package:gym_tracker_ui/pages/widgets/dialogs/rest_timer_dialog.dart';

class TimerBottomBar extends StatelessWidget {
  const TimerBottomBar({super.key});

  ///
  /// TODO: Implementar la funcionalidad de los botones de skip, pausa y maximizar.
  /// TODO: Agregar funcionalidad al timer.
  ///

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: Theme.of(context).bottomSheetTheme.backgroundColor,
        ),
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              IconButton(
                onPressed: () {
                  context.showBottomDialog(
                    const RestTimerDialog(
                      initialTime: Duration(minutes: 0, seconds: 5),
                    ),
                  );
                },
                icon: Icon(Icons.keyboard_arrow_up_outlined),
              ),
              const Spacer(),
              Icon(Icons.timer, color: Theme.of(context).colorScheme.primary),
              const SizedBox(width: 8),
              Text(
                "03:45",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                  color: Theme.of(context).colorScheme.primary,
                ),
              ),
              const Spacer(),
              IconButton(onPressed: () {}, icon: Icon(Icons.pause)),
              IconButton(onPressed: () {}, icon: Icon(Icons.skip_next)),
            ],
          ),
        ),
      ),
    );
  }
}
