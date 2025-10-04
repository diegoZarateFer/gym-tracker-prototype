import 'package:flutter/material.dart';
import 'package:gym_tracker_ui/core/extensions/context_ext.dart';
import 'package:gym_tracker_ui/pages/widgets/dialogs/unit_selector_dialog.dart';
import 'package:gym_tracker_ui/pages/widgets/modal_bottom_handle.dart';
import 'package:gym_tracker_ui/pages/widgets/rep_range_selector.dart';
import 'package:gym_tracker_ui/pages/widgets/rest_time_selector.dart';

class SetupExcerciseDialog extends StatefulWidget {
  const SetupExcerciseDialog({super.key});

  @override
  State<SetupExcerciseDialog> createState() =>
      _AddExcerciseToWorkoutDialogState();
}

class _AddExcerciseToWorkoutDialogState
    extends State<SetupExcerciseDialog> {
  ///
  /// Variable para controlar la unidad seleccionada.
  ///
  var _selectedUnit = Unit.units;

  ///
  /// Cambair la unidad seleccioanda.
  ///
  void _changeSelectedUnitHandler(Unit updatedUnit) {
    setState(() {
      _selectedUnit = updatedUnit;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.fromLTRB(2, 2, 2, context.keyBoardSpace),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const ModalBottomHandle(),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    icon: const Icon(Icons.check),
                  ),
                  const Spacer(),
                  const Text(
                    "Configure Exercise",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  const Spacer(),
                  IconButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    icon: const Icon(Icons.close),
                  ),
                ],
              ),
              const Divider(),
              const Text(
                "Excercise Unit",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              Row(
                children: [
                  ChoiceChip(
                    label: Text("Generic Unit"),
                    selected: _selectedUnit == Unit.units,
                    onSelected: (_) {
                      _changeSelectedUnitHandler(Unit.units);
                    },
                  ),
                  const Spacer(),
                  ChoiceChip(
                    label: Text("Kgs"),
                    selected: _selectedUnit == Unit.lbs,
                    onSelected: (_) {
                      _changeSelectedUnitHandler(Unit.lbs);
                    },
                  ),
                  const Spacer(),
                  ChoiceChip(
                    label: Text("Lbs"),
                    selected: _selectedUnit == Unit.kgs,
                    onSelected: (_) {
                      _changeSelectedUnitHandler(Unit.kgs);
                    },
                  ),
                  const Spacer(),
                  ChoiceChip(
                    label: Text("None"),
                    selected: _selectedUnit == Unit.none,
                    onSelected: (_) {
                      _changeSelectedUnitHandler(Unit.none);
                    },
                  ),
                ],
              ),
              const SizedBox(height: 8),
              const Divider(),
              const Text(
                "Rest time",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              RestTimeSelector(),
              const SizedBox(height: 8),
              const Divider(),
              const Text(
                "Rep Range",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              RepRangeSelector(),
              const SizedBox(height: 16),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton.icon(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  icon: const Icon(Icons.add),
                  label: const Text("Add to Workout"),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
