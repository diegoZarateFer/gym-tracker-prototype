import 'dart:math';

import 'package:flutter/material.dart';
import 'package:gym_tracker_ui/pages/widgets/bar_selector.dart';
import 'package:gym_tracker_ui/pages/widgets/plates_selector.dart';
import 'package:gym_tracker_ui/pages/widgets/weight_visualizer.dart';

const double maximumAllowedWeight = 360;

class PlateCalculator extends StatefulWidget {
  const PlateCalculator({super.key});

  @override
  State<PlateCalculator> createState() => _PlateCalculatorState();
}

class _PlateCalculatorState extends State<PlateCalculator> {
  double _totalPlatesWeight = 0;

  Map<Plate, int> _selectedPlates = {};

  BarType? _selectedBarType;

  bool _oneSidedBar = false;
  bool _maximumWeightExceeded = false;

  ///
  /// Funciones para widgets.
  ///

  void _changeBarHandler(BarType? newSelectedBarType) {
    setState(() {
      _selectedBarType = newSelectedBarType;
    });
  }

  void _addPlateHandler(Plate selectedPlate) {
    setState(() {
      if (_totalPlatesWeight + selectedPlate.weightInLbs <=
          maximumAllowedWeight) {
        _totalPlatesWeight += selectedPlate.weightInLbs;
        _selectedPlates = _simplifyPlates(_totalPlatesWeight);
      } else {
        _maximumWeightExceeded = true;
      }
    });
  }

  void _resetCalculator() {
    setState(() {
      _selectedPlates = {};
      _totalPlatesWeight = 0;
      _maximumWeightExceeded = false;
    });
  }

  ///
  /// Simplificar la lista de pesos.
  /// Esto se puede poner en un data source para realizar el precalculo.
  ///

  Plate _getPlateFromWeight(int weight) {
    double mappedWeight = weight / 10;
    switch (mappedWeight) {
      case 45:
        return Plate45();
      case 35:
        return Plate35();
      case 25:
        return Plate25();
      case 10:
        return Plate10();
      case 5:
        return Plate5();
      case 2.5:
        return Plate2Dot5();
    }

    throw Exception("No Such Plate.");
  }

  Map<Plate, int> _simplifyPlates(double targetWeight) {
    ///
    /// Obtener lista de los pesos.
    ///

    final weights = [];
    for (final plate in plates) {
      weights.add((plate.weightInLbs * 10).toInt());
    }

    int mappedTargetWeight = (targetWeight * 10).toInt();
    final usedPlates = List.generate(mappedTargetWeight + 1, (_) => -1);

    final dp =
        List.generate(mappedTargetWeight + 1, (_) => mappedTargetWeight + 1);
    dp[0] = 0;

    for (int i = 0; i < mappedTargetWeight + 1; i++) {
      for (int weight in weights) {
        if (weight <= i && 1 + dp[i - weight] < dp[i]) {
          dp[i] = min(dp[i], 1 + dp[i - weight]);
          usedPlates[i] = weight;
        }
      }
    }

    if (dp[mappedTargetWeight] > mappedTargetWeight) {
      throw Exception("Invalid Weight.");
    }

    Map<Plate, int> solution = {};
    int curentWeight = mappedTargetWeight;
    while (curentWeight > 0) {
      int lastPlate = usedPlates[curentWeight];
      final plateType = _getPlateFromWeight(lastPlate);
      solution[plateType] =
          solution.containsKey(plateType) ? solution[plateType]! + 1 : 1;
      curentWeight -= lastPlate;
    }

    return solution;
  }

  @override
  Widget build(BuildContext context) {
    double totalWeight =
        (_oneSidedBar ? _totalPlatesWeight : 2 * _totalPlatesWeight) +
            (barWeights[_selectedBarType] ?? 0);

    final titleText = _maximumWeightExceeded
        ? Text(
            "Wow! You are too strong for the calculator.",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Theme.of(context).colorScheme.error,
            ),
          )
        : RichText(
            text: TextSpan(
              text: "Total Weight: ",
              style: const TextStyle(
                fontWeight: FontWeight.bold,
              ),
              children: [
                TextSpan(
                    text: "${totalWeight.toStringAsFixed(2)} units.",
                    style: const TextStyle(
                      fontWeight: FontWeight.normal,
                    )),
              ],
            ),
          );

    return AlertDialog(
      title: const Text(
        "Plate Calculator",
        textAlign: TextAlign.center,
      ),
      content: SizedBox(
        width: double.infinity,
        child: SingleChildScrollView(
          child: Column(
            children: [
              const Divider(),
              const SizedBox(height: 8),
              titleText,
              WeightVisualizer(
                selectedPlates: _selectedPlates,
                selectedBarWeight: barWeights[_selectedBarType] ?? 0,
              ),
              PlatesSelector(onAddPlate: _addPlateHandler),
              const Divider(),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text("One Side"),
                  const SizedBox(width: 8),
                  Switch(
                    value: !_oneSidedBar,
                    onChanged: (bool value) {
                      setState(() {
                        _oneSidedBar = !value;
                      });
                    },
                  ),
                  const SizedBox(width: 8),
                  const Text("Two Sides"),
                ],
              ),
              BarSelector(
                selectedBarType: _selectedBarType,
                onBarChange: _changeBarHandler,
              ),
            ],
          ),
        ),
      ),
      actions: [
        TextButton(
          onPressed: _resetCalculator,
          child: const Text("Reset"),
        ),
        TextButton(
          onPressed: () {
            Navigator.pop(context, null);
          },
          child: const Text("Cancel"),
        ),
        TextButton(
          onPressed: () {
            Navigator.pop(context, totalWeight);
          },
          child: const Text("Done"),
        ),
      ],
    );
  }
}
