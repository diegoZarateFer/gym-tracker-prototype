import 'package:flutter/material.dart';
import 'package:gym_tracker_ui/core/extensions/context_ext.dart';
import 'package:gym_tracker_ui/pages/widgets/modal_bottom_handle.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

class RestTimerDialog extends StatelessWidget {
  const RestTimerDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.fromLTRB(2, 2, 2, context.keyBoardSpace),
          child: Column(
            children: [
              const ModalBottomHandle(),
              CircularPercentIndicator(
                radius: 100,
                lineWidth: 10,
                percent: 0.8,
                header: const Text("Rest timer"),
                center: const Icon(Icons.timer_sharp),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
