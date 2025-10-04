import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gym_tracker_ui/domain/entitites/excercise_blueprint.dart';

class WorkoutCubit extends Cubit<List<ExcerciseBlueprint>> {
  WorkoutCubit() : super([]);

  void addExcerciseToWorkout(ExcerciseBlueprint excercise) {
    emit([...state, excercise]);
  }

  void reorder(int oldIndex, int newIndex) {
    final updatedList = List<ExcerciseBlueprint>.from(state);
    if (newIndex > oldIndex) {
      newIndex -= 1;
    }

    final item = updatedList.removeAt(oldIndex);
    updatedList.insert(newIndex, item);

    emit(updatedList);
  }

  void deleteExcerciseFromWorkout(ExcerciseBlueprint excercise) {
    final workout = state;
    workout.remove(excercise);

    emit([...workout]);
  }
}
