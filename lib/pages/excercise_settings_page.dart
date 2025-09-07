import 'package:flutter/material.dart';
import 'package:gym_tracker_ui/pages/widgets/excercise_settings_form.dart';

class ExcerciseSettingsPage extends StatefulWidget {
  static const String route = "excercise-settings";

  const ExcerciseSettingsPage({super.key});

  @override
  State<ExcerciseSettingsPage> createState() => _ExcerciseSettingsPageState();
}

class _ExcerciseSettingsPageState extends State<ExcerciseSettingsPage> {
  void _saveExcerciseSettingsHandler(
      {required String name,
      required int minNumberOfReps,
      required int maxNumberOfReps}) {
    print(name);
    print(minNumberOfReps);
    print(maxNumberOfReps);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.background,
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        title: const Text("Excercise Name"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(4),
        child: ExcerciseSettingsForm(
          onSaveExcerciseSettings: _saveExcerciseSettingsHandler,
        ),
      ),
    );
  }
}
