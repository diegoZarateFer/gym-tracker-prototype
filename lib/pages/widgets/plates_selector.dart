import 'package:flutter/material.dart';
import 'package:gym_tracker_ui/pages/widgets/weight_visualizer.dart';

final plates = <Plate>[
  Plate45(),
  Plate35(),
  Plate25(),
  Plate10(),
  Plate5(),
  Plate2Dot5(),
];

class PlatesSelector extends StatelessWidget {
  const PlatesSelector({super.key, required this.onAddPlate});

  final void Function(Plate selectedPlate) onAddPlate;

  void _addPlateHandler(Plate selectedPlate) {
    onAddPlate(selectedPlate);
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          for (var plate in plates)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 2),
              child: ElevatedButton(
                onPressed: () {
                  _addPlateHandler(plate);
                },
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.all(2),
                  shape: const CircleBorder(),
                  minimumSize: const Size(40, 40),
                ),
                child: Text(plate.label),
              ),
            ),
        ],
      ),
    );
  }
}
