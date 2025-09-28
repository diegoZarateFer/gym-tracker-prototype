import 'package:flutter/material.dart';
import 'package:gym_tracker_ui/core/extensions/context_ext.dart';
import 'package:gym_tracker_ui/domain/entitites/excercise_blueprint.dart';
import 'package:gym_tracker_ui/pages/widgets/dialogs/add_excercise_to_workout_dialog.dart';

/// En este widget se obtiene la lista de ejercicios de una
/// categoria mediante un usecase.

const dummyExcercisesBlueprints = [
  ExcerciseBlueprint(
    name: "Pull Ups",
    category: ExcerciseCategory.back,
    recommendedMinNumberOfReps: 4,
    recommendedMaxNumberOfReps: 10,
    recommendedRestTime: Duration(minutes: 3, seconds: 30),
  ),
  ExcerciseBlueprint(
    name: "Bar Row",
    category: ExcerciseCategory.back,
    recommendedMinNumberOfReps: 4,
    recommendedMaxNumberOfReps: 10,
    recommendedRestTime: Duration(minutes: 3, seconds: 30),
  ),
  ExcerciseBlueprint(
    name: "Inclined Dumbell Press",
    category: ExcerciseCategory.chest,
    recommendedMinNumberOfReps: 5,
    recommendedMaxNumberOfReps: 10,
    recommendedRestTime: Duration(minutes: 3, seconds: 30),
  ),
  ExcerciseBlueprint(
    name: "EZ Bicep Curl",
    category: ExcerciseCategory.arms,
    recommendedMinNumberOfReps: 8,
    recommendedMaxNumberOfReps: 12,
    recommendedRestTime: Duration(minutes: 2),
  ),
  ExcerciseBlueprint(
    name: "Squats",
    category: ExcerciseCategory.quads,
    recommendedMinNumberOfReps: 3,
    recommendedMaxNumberOfReps: 6,
    recommendedRestTime: Duration(minutes: 4),
  ),
];

class CategoryExcercisesList extends StatefulWidget {
  const CategoryExcercisesList({
    super.key,
    required this.category,
    required this.categoryTitle,
  });

  final ExcerciseCategory category;
  final String categoryTitle;

  @override
  State<CategoryExcercisesList> createState() => _CategoryExcercisesListState();
}

class _CategoryExcercisesListState extends State<CategoryExcercisesList> {
  ///
  /// Funciones para widgets.
  ///
  void _addExcerciseToWorkoutHandler() {
    context.showBottomDialog(AddExcerciseToWorkoutDialog());
  }

  @override
  Widget build(BuildContext context) {
    final filteredExcercises = dummyExcercisesBlueprints
        .where((excercise) => excercise.category == widget.category)
        .toList();

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
        title: Text(widget.categoryTitle),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                decoration: BoxDecoration(
                  color: Theme.of(context).inputDecorationTheme.fillColor,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: filteredExcercises.isEmpty
                    ? const Padding(
                        padding: EdgeInsets.all(32),
                        child: Center(
                          child: Text("No Excercises For This Category"),
                        ),
                      )
                    : ListView.builder(
                        padding: EdgeInsets.zero,
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: filteredExcercises.length,
                        itemBuilder: (ctx, index) {
                          return GestureDetector(
                            onTap: _addExcerciseToWorkoutHandler,
                            child: ListTile(
                              title: Text(filteredExcercises[index].name),
                              trailing: const Icon(Icons.add),
                            ),
                          );
                        },
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
