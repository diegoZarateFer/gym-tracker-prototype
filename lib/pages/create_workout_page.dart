import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gym_tracker_ui/core/extensions/context_ext.dart';
import 'package:gym_tracker_ui/domain/entitites/excercise_blueprint.dart';
import 'package:gym_tracker_ui/pages/bloc/workout_cubit.dart';
import 'package:gym_tracker_ui/pages/choose_excercise_page.dart';
import 'package:gym_tracker_ui/pages/widgets/dialogs/setup_excercise_dialog.dart';

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

  void _onEditExcercise() async {
    await context.showBottomDialog(SetupExcerciseDialog());
  }

  void _onDeleteExcerciseHandler(ExcerciseBlueprint excercise) {
    context.read<WorkoutCubit>().deleteExcerciseFromWorkout(excercise);
    context.showScaffoldMessage(
      "${excercise.name} was removed from workout!",
      action: SnackBarAction(
        label: "Undo",
        textColor: Theme.of(context).colorScheme.primary,
        onPressed: () {
          context.read<WorkoutCubit>().addExcerciseToWorkout(excercise);
        },
      ),
    );
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
            mainAxisSize: MainAxisSize.min,
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

                child: BlocBuilder<WorkoutCubit, List<ExcerciseBlueprint>>(
                  builder: (context, workoutExcercises) {
                    if (workoutExcercises.isEmpty) {
                      return Padding(
                        padding: const EdgeInsets.all(32),
                        child: Center(
                          child: Text(
                            "Start adding excercises to your workout!",
                          ),
                        ),
                      );
                    }

                    return ReorderableListView.builder(
                      shrinkWrap: true,
                      padding: EdgeInsets.zero,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: workoutExcercises.length,
                      onReorder: (oldIndex, newIndex) {
                        context.read<WorkoutCubit>().reorder(
                          oldIndex,
                          newIndex,
                        );
                      },
                      itemBuilder: (ctx, index) {
                        final excercise = workoutExcercises[index];
                        int restTimeMinutes =
                            excercise.recommendedRestTime.inSeconds ~/ 60;
                        int restTimeSeconds =
                            excercise.recommendedRestTime.inSeconds % 60;
                        return Dismissible(
                          key: ValueKey(excercise),
                          direction: DismissDirection.endToStart,
                          background: Container(
                            color: Theme.of(context).colorScheme.error,
                            alignment: Alignment.centerRight,
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            child: const Icon(
                              Icons.delete,
                              color: Colors.white,
                            ),
                          ),
                          onDismissed: (direction) {
                            if (direction == DismissDirection.endToStart) {
                              _onDeleteExcerciseHandler(excercise);
                            }
                          },
                          child: ListTile(
                            leading: Icon(
                              Icons.drag_handle_outlined,
                              color: Theme.of(context).colorScheme.primary,
                            ),
                            title: Text(
                              excercise.name,
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            subtitle: Row(
                              children: [
                                Text("3 sets"),
                                const SizedBox(width: 8),
                                Icon(Icons.timer),
                                const SizedBox(width: 4),
                                Text("$restTimeMinutes:$restTimeSeconds"),
                                const SizedBox(width: 8),
                                Text("10 - 20 reps"),
                              ],
                            ),
                            trailing: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                GestureDetector(
                                  onTap: _onEditExcercise,
                                  child: Icon(
                                    Icons.edit,
                                    color: Theme.of(
                                      context,
                                    ).colorScheme.primary,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    );
                  },
                ),
              ),
              const SizedBox(height: 16),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton.icon(
                  onPressed: _onAddExcerciseHandler,
                  icon: const Icon(Icons.add),
                  label: const Text("Add Excercise"),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Theme.of(context).colorScheme.onSurface,
                    foregroundColor: Theme.of(context).colorScheme.surface,
                  ),
                ),
              ),
              const SizedBox(height: 8),
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
