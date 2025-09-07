import 'package:flutter/material.dart';
import 'package:gym_tracker_ui/domain/entitites/excercise_blueprint.dart';

/// En este widget se obtiene la lista de ejercicios de una
/// categoria mediante un usecase.

const dummyExcercisesBlueprints = [
  ExcerciseBlueprint(
    name: "Pull Ups",
    category: ExcerciseCategory.back,
    recommendedMinNumberOfReps: 4,
    recommendedMaxNumberOfReps: 10,
    recommendedRestTime: Duration(
      minutes: 3,
      seconds: 30,
    ),
  ),
  ExcerciseBlueprint(
    name: "Inclined Dumbell Press",
    category: ExcerciseCategory.chest,
    recommendedMinNumberOfReps: 5,
    recommendedMaxNumberOfReps: 10,
    recommendedRestTime: Duration(
      minutes: 3,
      seconds: 30,
    ),
  ),
  ExcerciseBlueprint(
    name: "EZ Bicep Curl",
    category: ExcerciseCategory.arms,
    recommendedMinNumberOfReps: 8,
    recommendedMaxNumberOfReps: 12,
    recommendedRestTime: Duration(
      minutes: 2,
    ),
  ),
  ExcerciseBlueprint(
    name: "Squats",
    category: ExcerciseCategory.quads,
    recommendedMinNumberOfReps: 3,
    recommendedMaxNumberOfReps: 6,
    recommendedRestTime: Duration(
      minutes: 4,
    ),
  ),
];

class CategoryExcercisesList extends StatelessWidget {
  const CategoryExcercisesList(
      {super.key, required this.category, required this.categoryTitle});

  final ExcerciseCategory category;
  final String categoryTitle;

  @override
  Widget build(BuildContext context) {
    final filteredExcercises = dummyExcercisesBlueprints
        .where((excercise) => excercise.category == category)
        .toList();

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
        title: Text(categoryTitle),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const SizedBox(height: 16),
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
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: filteredExcercises.length,
                        itemBuilder: (ctx, index) {
                          return GestureDetector(
                            onTap: () {},
                            child: ListTile(
                              title: Text(filteredExcercises[index].name),
                              trailing: const Icon(
                                Icons.settings,
                              ),
                            ),
                          );
                        },
                      ),
              ),
              const SizedBox(height: 16),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton.icon(
                  onPressed: () {},
                  icon: const Icon(Icons.add),
                  label: const Text("Add Excercise"),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
