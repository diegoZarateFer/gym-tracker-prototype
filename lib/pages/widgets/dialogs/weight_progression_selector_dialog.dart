import 'package:flutter/material.dart';
import 'package:gym_tracker_ui/pages/widgets/modal_bottom_handle.dart';

enum ProgressionWeights { light, easy, medium, custom }

class WeightProgressionSelectorDialog extends StatefulWidget {
  const WeightProgressionSelectorDialog({
    super.key,
    required this.onSaveWeightProgression,
  });

  final void Function(double selectedWeight) onSaveWeightProgression;

  @override
  State<WeightProgressionSelectorDialog> createState() =>
      _WeightProgressionSelectorDialogState();
}

class _WeightProgressionSelectorDialogState
    extends State<WeightProgressionSelectorDialog> {
  /// Peso seleccionado
  ///
  ProgressionWeights _selectedProgression = ProgressionWeights.easy;

  /// Controller para peso personalizado.
  ///
  final _customWeightController = TextEditingController();

  /// Funciones para widgtes.
  ///
  void _changeSelectedWeightHandler(ProgressionWeights? selectedProgression) {
    setState(() {
      _selectedProgression = selectedProgression ?? ProgressionWeights.easy;
    });
  }

  /// Funcion para enviar datos del formulario.
  ///
  void _saveWeightProgressionHandler() {
    /// TODO: validar peso personalizado.
    switch (_selectedProgression) {
      case ProgressionWeights.light:
        widget.onSaveWeightProgression(2.5);
        break;
      case ProgressionWeights.easy:
        widget.onSaveWeightProgression(5);
        break;
      case ProgressionWeights.medium:
        widget.onSaveWeightProgression(10);
        break;
      case ProgressionWeights.custom:
        final customWeight = double.tryParse(_customWeightController.text);
        widget.onSaveWeightProgression(customWeight ?? 0);
        break;
    }

    Navigator.of(context).pop();
  }

  @override
  void dispose() {
    _customWeightController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final keyboardSpace = MediaQuery.of(context).viewInsets.bottom;
    final isCustomWightSelected =
        _selectedProgression == ProgressionWeights.custom;

    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.fromLTRB(2, 2, 2, keyboardSpace + 16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const ModalBottomHandle(),
            const Text(
              "Choose a Weight",
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            const Text(
              "The weight you want to increase every time you reach the maximum number of reps for the excercise.",
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16),
            if (isCustomWightSelected)
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SizedBox(
                    width: 155,
                    child: TextField(
                      controller: _customWeightController,
                      textAlign: TextAlign.center,
                      keyboardType: const TextInputType.numberWithOptions(),
                      decoration: const InputDecoration(
                        label: Text("Custom Weight"),
                        counterText: "",
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  const Text("units.")
                ],
              ),
            if (isCustomWightSelected) const SizedBox(height: 16),
            Container(
              decoration: BoxDecoration(
                color: Theme.of(context).inputDecorationTheme.fillColor,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Padding(
                padding: const EdgeInsets.all(8),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    RadioListTile<ProgressionWeights>(
                      value: ProgressionWeights.light,
                      groupValue: _selectedProgression,
                      title: const Text(
                        "2.5 units",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      subtitle: const Text(
                        "Recommended",
                      ),
                      onChanged: _changeSelectedWeightHandler,
                      activeColor: Theme.of(context).colorScheme.primary,
                      controlAffinity: ListTileControlAffinity.trailing,
                    ),
                    const Divider(),
                    RadioListTile<ProgressionWeights>(
                      value: ProgressionWeights.easy,
                      groupValue: _selectedProgression,
                      title: const Text(
                        "5 units",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      onChanged: _changeSelectedWeightHandler,
                      activeColor: Theme.of(context).colorScheme.primary,
                      controlAffinity: ListTileControlAffinity.trailing,
                    ),
                    const Divider(),
                    RadioListTile<ProgressionWeights>(
                      value: ProgressionWeights.medium,
                      groupValue: _selectedProgression,
                      title: const Text(
                        "10 units",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      onChanged: _changeSelectedWeightHandler,
                      activeColor: Theme.of(context).colorScheme.primary,
                      controlAffinity: ListTileControlAffinity.trailing,
                    ),
                    const Divider(),
                    RadioListTile<ProgressionWeights>(
                      value: ProgressionWeights.custom,
                      groupValue: _selectedProgression,
                      title: const Text(
                        "Custom",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      onChanged: _changeSelectedWeightHandler,
                      activeColor: Theme.of(context).colorScheme.primary,
                      controlAffinity: ListTileControlAffinity.trailing,
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),
            ElevatedButton.icon(
              onPressed: _saveWeightProgressionHandler,
              icon: const Icon(Icons.done),
              label: const Text("Set Weight"),
            ),
          ],
        ),
      ),
    );
  }
}
