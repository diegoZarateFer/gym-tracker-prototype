enum ExcerciseCategory {
  chest,
  back,
  arms,
  shoulders,
  quads,
  hamstrings,
  glutes,
  calves,
  abs,
}

class ExcerciseBlueprint {
  final String name;

  final ExcerciseCategory category;
  final Duration recommendedRestTime;

  final int recommendedMinNumberOfReps;
  final int recommendedMaxNumberOfReps;

  const ExcerciseBlueprint({
    required this.name,
    required this.category,
    required this.recommendedRestTime,
    required this.recommendedMinNumberOfReps,
    required this.recommendedMaxNumberOfReps,
  });
}
