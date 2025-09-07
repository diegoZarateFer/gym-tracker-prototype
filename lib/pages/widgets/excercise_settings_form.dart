import 'package:flutter/material.dart';
import 'package:gym_tracker_ui/core/extensions/context_ext.dart';
import 'package:gym_tracker_ui/pages/widgets/dialogs/intensity_indicator_selector_dialog.dart';
import 'package:gym_tracker_ui/pages/widgets/dialogs/rest_time_selector_dialog.dart';
import 'package:gym_tracker_ui/pages/widgets/dialogs/unit_selector_dialog.dart';

class ExcerciseSettingsForm extends StatefulWidget {
  const ExcerciseSettingsForm({
    super.key,
    required this.onSaveExcerciseSettings,
  });

  final void Function(
      {required String name,
      required int minNumberOfReps,
      required int maxNumberOfReps}) onSaveExcerciseSettings;

  @override
  State<ExcerciseSettingsForm> createState() => _ExcerciseSettingsFormState();
}

class _ExcerciseSettingsFormState extends State<ExcerciseSettingsForm> {
  /// Controllers.
  ///
  final _excerciseNameController = TextEditingController();

  /// Valores del rango de repeticiones.
  ///
  int _selectedRepRangeStart = 5;
  int _selectedRepRangeEnd = 10;

  ///TODO: Agregar validaciones a los campos.
  ///

  /// Funciones para los widgets.
  ///
  void _changeRepsRangeHandler(RangeValues newValues) {
    setState(() {
      _selectedRepRangeStart = newValues.start.toInt();
      _selectedRepRangeEnd = newValues.end.toInt();
    });
  }

  void _onSaveExcerciseSettings() {
    widget.onSaveExcerciseSettings(
      name: _excerciseNameController.text,
      minNumberOfReps: _selectedRepRangeStart,
      maxNumberOfReps: _selectedRepRangeEnd,
    );
  }

  @override
  void dispose() {
    _excerciseNameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.only(
          top: 16,
          left: 8,
          right: 8,
        ),
        child: Column(
          children: [
            TextField(
              controller: _excerciseNameController,
              textAlignVertical: TextAlignVertical.center,
              maxLines: 1,
              maxLength: 30,
              decoration: const InputDecoration(
                counterText: "",
                label: Text("Excercise Name"),
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            Container(
              decoration: BoxDecoration(
                color: Theme.of(context).inputDecorationTheme.fillColor,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Padding(
                padding: const EdgeInsets.all(4.0),
                child: Column(
                  children: [
                    GestureDetector(
                      onTap: () {
                        context.showBottomDialog(const UnitSelectorDialog());
                      },
                      child: const ListTile(
                        contentPadding: EdgeInsets.symmetric(horizontal: 4),
                        title: Row(
                          children: [
                            Icon(
                              Icons.fitness_center,
                              color: Colors.yellow,
                            ),
                            SizedBox(width: 8),
                            Text("Unit"),
                          ],
                        ),
                        trailing: Icon(
                          Icons.arrow_forward_ios,
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        context.showBottomDialog(
                            const IntensityIndicatorSelectorDialog());
                      },
                      child: const ListTile(
                        contentPadding: EdgeInsets.symmetric(horizontal: 4),
                        title: Row(
                          children: [
                            Icon(
                              Icons.bolt,
                              color: Colors.yellow,
                            ),
                            SizedBox(width: 8),
                            Text("Intensity Indicator"),
                          ],
                        ),
                        trailing: Icon(
                          Icons.arrow_forward_ios,
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        context
                            .showBottomDialog(const RestTimeSelectorDialog());
                      },
                      child: const ListTile(
                        contentPadding: EdgeInsets.symmetric(horizontal: 4),
                        title: Row(
                          children: [
                            Icon(
                              Icons.timer,
                              color: Colors.yellow,
                            ),
                            SizedBox(width: 8),
                            Text("Rest time between sets"),
                          ],
                        ),
                        trailing: Icon(
                          Icons.arrow_forward_ios,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),
            Container(
              decoration: BoxDecoration(
                color: Theme.of(context).inputDecorationTheme.fillColor,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: Column(children: [
                  const Text(
                    "Rep range:",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                  const SizedBox(height: 16),
                  RichText(
                    text: TextSpan(
                      children: [
                        const TextSpan(text: "Between"),
                        TextSpan(
                          text:
                              " $_selectedRepRangeStart - $_selectedRepRangeEnd ",
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const TextSpan(text: "reps."),
                      ],
                    ),
                  ),
                  const SizedBox(height: 8),
                  SliderTheme(
                    data: SliderTheme.of(context).copyWith(
                      thumbColor: Colors.white,
                    ),
                    child: RangeSlider(
                      min: 1,
                      max: 25,
                      values: RangeValues(_selectedRepRangeStart.toDouble(),
                          _selectedRepRangeEnd.toDouble()),
                      onChanged: _changeRepsRangeHandler,
                    ),
                  ),
                ]),
              ),
            ),
            const SizedBox(height: 16),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: _onSaveExcerciseSettings,
                icon: const Icon(Icons.save),
                label: const Text("Save"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
