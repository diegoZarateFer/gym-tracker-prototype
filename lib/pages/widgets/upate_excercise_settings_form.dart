import 'package:flutter/material.dart';
import 'package:gym_tracker_ui/core/extensions/context_ext.dart';
import 'package:gym_tracker_ui/pages/widgets/dialogs/rest_time_selector_dialog.dart';
import 'package:gym_tracker_ui/pages/widgets/dialogs/unit_selector_dialog.dart';
import 'package:gym_tracker_ui/pages/widgets/rep_range_selector.dart';

class UpdateExcerciseSettingsForm extends StatefulWidget {
  const UpdateExcerciseSettingsForm({
    super.key,
    required this.onSaveExcerciseSettings,
  });

  final void Function({
    required String name,
    required int minNumberOfReps,
    required int maxNumberOfReps,
  })
  onSaveExcerciseSettings;

  @override
  State<UpdateExcerciseSettingsForm> createState() =>
      _UpdateExcerciseSettingsFormState();
}

class _UpdateExcerciseSettingsFormState
    extends State<UpdateExcerciseSettingsForm> {
  ///
  /// Controllers.
  ///
  final _excerciseNameController = TextEditingController();

  ///
  /// TODO: Agregar validaciones a los campos.
  ///

  void _onSaveExcerciseSettings() {
    widget.onSaveExcerciseSettings(
      name: _excerciseNameController.text,
      minNumberOfReps: 0,
      maxNumberOfReps: 0,
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
        padding: const EdgeInsets.only(top: 16, left: 8, right: 8),
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
                padding: const EdgeInsets.all(4),
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
                            Icon(Icons.fitness_center, color: Colors.yellow),
                            SizedBox(width: 8),
                            Text("Unit"),
                          ],
                        ),
                        trailing: Icon(Icons.arrow_forward_ios),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        context.showBottomDialog(
                          const RestTimeSelectorDialog(),
                        );
                      },
                      child: const ListTile(
                        contentPadding: EdgeInsets.symmetric(horizontal: 4),
                        title: Row(
                          children: [
                            Icon(Icons.timer, color: Colors.yellow),
                            SizedBox(width: 8),
                            Text("Rest time between sets"),
                          ],
                        ),
                        trailing: Icon(Icons.arrow_forward_ios),
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
                child: Column(
                  children: [
                    const Text(
                      "Rep range:",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                    const SizedBox(height: 16),
                    Expanded(child: RepRangeSelector()),
                  ],
                ),
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
