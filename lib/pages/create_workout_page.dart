import 'package:flutter/material.dart';
import 'package:gym_tracker_ui/pages/choose_excercise_page.dart';

class CreateWorkoutPage extends StatefulWidget {
  static const String route = "create-workout";

  const CreateWorkoutPage({super.key});

  @override
  State<CreateWorkoutPage> createState() => _CreateWorkoutPageState();
}

class _CreateWorkoutPageState extends State<CreateWorkoutPage> {
  final _workoutNameController = TextEditingController();

  ///
  /// Funciones para widgets.
  ///
  void _onAddExcerciseHandler() {
    Navigator.of(context).pushNamed(ChooseExcercisePage.route);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.surface,
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        title: const Text("Create Workout"),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 18, horizontal: 8),
          child: Column(
            children: [
              TextField(
                controller: _workoutNameController,
                textAlignVertical: TextAlignVertical.center,
                maxLines: 1,
                maxLength: 50,
                decoration: const InputDecoration(
                  counterText: "",
                  label: Text("Workout Name"),
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 16),
              Container(
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.surface,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: const [
                    BoxShadow(
                      color: Colors.black12,
                      blurRadius: 4,
                      offset: Offset(0, 2),
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    ElevatedButton.icon(
                      onPressed: _onAddExcerciseHandler,
                      icon: const Icon(Icons.add),
                      label: const Text("Add Excercise"),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Theme.of(
                          context,
                        ).colorScheme.onSurface,
                        foregroundColor: Theme.of(context).colorScheme.surface,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton.icon(
                  onPressed: () {},
                  label: Text("Save"),
                  icon: Icon(Icons.save),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
