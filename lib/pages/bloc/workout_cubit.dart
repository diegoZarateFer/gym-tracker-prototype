import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gym_tracker_ui/domain/entitites/excercise_blueprint.dart';

class WorkoutCubit extends Cubit<List<ExcerciseBlueprint>> {
  WorkoutCubit() : super([]);

  int? _lastRemovedIndex;
  ExcerciseBlueprint? _lastRemovedExcercise;

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
    final updatedList = List<ExcerciseBlueprint>.from(state);

    _lastRemovedExcercise = excercise;
    _lastRemovedIndex = updatedList.indexOf(excercise);

    updatedList.remove(excercise);

    emit(updatedList);
  }

  void undoRemove() {
    final updatedList = List<ExcerciseBlueprint>.from(state);
    updatedList.insert(_lastRemovedIndex!, _lastRemovedExcercise!);

    emit(updatedList);

    _lastRemovedIndex = null;
    _lastRemovedExcercise = null;
  }
}
