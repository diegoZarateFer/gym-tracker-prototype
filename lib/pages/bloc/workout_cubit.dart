import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gym_tracker_ui/domain/entitites/excercise_blueprint.dart';

class WorkoutCubit extends Cubit<List<ExcerciseBlueprint>> {
  WorkoutCubit() : super([]);

  void addExcerciseToWorkout(ExcerciseBlueprint excercise) {
    emit([...state, excercise]);
  }

  void deleteExcerciseFromWorkout(ExcerciseBlueprint excercise) {
    final workout = state;
    workout.remove(excercise);

    emit([...workout]);
  }
}
