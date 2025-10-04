import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gym_tracker_ui/core/extensions/context_ext.dart';
import 'package:gym_tracker_ui/domain/entitites/excercise_blueprint.dart';
import 'package:gym_tracker_ui/fake_data/excercises_blueprints.dart';
import 'package:gym_tracker_ui/pages/bloc/workout_cubit.dart';
import 'package:gym_tracker_ui/pages/widgets/dialogs/setup_excercise_dialog.dart';

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
  void _addExcerciseToWorkoutHandler(ExcerciseBlueprint excercise) async {
    await context.showBottomDialog(SetupExcerciseDialog());

    if (mounted) {
      ///
      /// Agregar ejercicio al cubit.
      ///

      context.read<WorkoutCubit>().addExcerciseToWorkout(excercise);

      context.showScaffoldMessage(
        "${excercise.name} was added to workout!",
        action: SnackBarAction(
          label: "Undo",
          textColor: Theme.of(context).colorScheme.primary,
          onPressed: () {
            context.read<WorkoutCubit>().deleteExcerciseFromWorkout(excercise);
            context.showScaffoldMessage("${excercise.name} removed from workout!");
          },
        ),
      );
    }
  }

  void _removeExcerciseToWorkoutHandler(ExcerciseBlueprint excercise) {
    context.read<WorkoutCubit>().deleteExcerciseFromWorkout(excercise);
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
        actions: [
          IconButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            icon: Icon(Icons.check),
          ),
        ],
        title: Text(widget.categoryTitle),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
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
                            final excercise = filteredExcercises[index];
                            return BlocBuilder<
                              WorkoutCubit,
                              List<ExcerciseBlueprint>
                            >(
                              builder: (context, state) {
                                final excerciseIsInWorkout = state.contains(
                                  excercise,
                                );
                                return GestureDetector(
                                  onTap: () {
                                    if (state.contains(excercise)) {
                                      _removeExcerciseToWorkoutHandler(
                                        excercise,
                                      );
                                    } else {
                                      _addExcerciseToWorkoutHandler(excercise);
                                    }
                                  },
                                  child: ListTile(
                                    title: Text(excercise.name),
                                    trailing: AnimatedSwitcher(
                                      duration: Duration(milliseconds: 400),
                                      transitionBuilder: (child, anim) =>
                                          FadeTransition(
                                            opacity: anim,
                                            child: ScaleTransition(
                                              scale: anim,
                                              child: child,
                                            ),
                                          ),
                                      child: Icon(
                                        key: ValueKey<bool>(
                                          excerciseIsInWorkout,
                                        ),
                                        excerciseIsInWorkout
                                            ? Icons.close
                                            : Icons.add,
                                        color: excerciseIsInWorkout
                                            ? Theme.of(
                                                context,
                                              ).colorScheme.error
                                            : Theme.of(
                                                context,
                                              ).colorScheme.primary,
                                      ),
                                    ),
                                  ),
                                );
                              },
                            );
                          },
                        ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
