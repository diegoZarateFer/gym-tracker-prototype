import 'package:gym_tracker_ui/pages/widgets/dialogs/intensity_indicator_selector_dialog.dart';
import 'package:gym_tracker_ui/pages/widgets/dialogs/unit_selector_dialog.dart';

class RoutineExcercise {
  final String name;
  final String desciption;

  Unit unit;
  IntensityIndicator intensityIndicator;

  final Duration restTime;
  final double progressionWeight;

  final int minNumberOfReps;
  final int maxNumberOfReps;

  RoutineExcercise({
    required this.name,
    required this.desciption,
    required this.unit,
    required this.intensityIndicator,
    required this.restTime,
    required this.progressionWeight,
    required this.minNumberOfReps,
    required this.maxNumberOfReps,
  }) {
    // TODO: implement Excercise
    throw UnimplementedError();
  }
}
