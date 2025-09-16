import 'package:flutter/material.dart';
import 'package:gym_tracker_ui/pages/widgets/check_button.dart';
import 'package:gym_tracker_ui/pages/widgets/modal_bottom_handle.dart';

enum IntensityIndicator { none, rir, rpe, subjective }

class IntensityIndicatorSelectorDialog extends StatefulWidget {
  const IntensityIndicatorSelectorDialog({super.key});

  @override
  State<IntensityIndicatorSelectorDialog> createState() =>
      _IntensityIndicatorSelectorDialogState();
}

class _IntensityIndicatorSelectorDialogState
    extends State<IntensityIndicatorSelectorDialog> {
  /// Indicador de intensidad seleccionado.
  ///
  IntensityIndicator _selectedIntensityIndicator = IntensityIndicator.none;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const ModalBottomHandle(),
          const Text(
            "Intensity Indicator",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              decoration: BoxDecoration(
                color: Theme.of(context).inputDecorationTheme.fillColor,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Padding(
                padding: const EdgeInsets.all(8),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    CheckButton(
                      isChecked:
                          _selectedIntensityIndicator == IntensityIndicator.rir,
                      title: "RIR",
                      subtitle:
                          "How many reps you could still do before failure.",
                      onPressed: () {
                        setState(() {
                          _selectedIntensityIndicator = IntensityIndicator.rir;
                        });
                      },
                    ),
                    const Divider(),
                    CheckButton(
                      isChecked:
                          _selectedIntensityIndicator == IntensityIndicator.rpe,
                      title: "RPE",
                      subtitle:
                          "A 1–10 scale rating how hard you feel you’re working during exercise.",
                      onPressed: () {
                        setState(() {
                          _selectedIntensityIndicator = IntensityIndicator.rpe;
                        });
                      },
                    ),
                    const Divider(),
                    CheckButton(
                      isChecked:
                          _selectedIntensityIndicator ==
                          IntensityIndicator.subjective,
                      title: "Subjective",
                      subtitle:
                          "Recommended for beginners. It allows to choose how hard a set was for you.",
                      onPressed: () {
                        setState(() {
                          _selectedIntensityIndicator =
                              IntensityIndicator.subjective;
                        });
                      },
                    ),
                    const Divider(),
                    CheckButton(
                      isChecked:
                          _selectedIntensityIndicator ==
                          IntensityIndicator.none,
                      title: "None",
                      subtitle: "Only register weight and repetitions.",
                      onPressed: () {
                        setState(() {
                          _selectedIntensityIndicator = IntensityIndicator.none;
                        });
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
