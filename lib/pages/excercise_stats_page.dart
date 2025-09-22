import 'dart:math';

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:gym_tracker_ui/pages/widgets/excercise_charts/excercise_set_plot.dart';

enum ChartYAxisValue { weight, reps, totalVolume }

extension ChartYAxisValueDescription on ChartYAxisValue {
  String get description {
    switch (this) {
      case ChartYAxisValue.weight:
        return "Visualize the weight you have used over time, the yellow dots indicate the times you increased the number of reps with a certain weight.";
      case ChartYAxisValue.reps:
        return "Visualize the reps you have done over time, the yellow dots indicate the times you increased the weight.";
      case ChartYAxisValue.totalVolume:
        return "The total volume is an indicator of your performance...";
    }
  }
}

class ExcerciseStatsPage extends StatefulWidget {
  static const String route = "/excercise-stats";

  const ExcerciseStatsPage({super.key});

  @override
  State<ExcerciseStatsPage> createState() => _ExcerciseStatsPageState();
}

class _ExcerciseStatsPageState extends State<ExcerciseStatsPage> {
  ///
  /// Dummy data.
  ///

  late List<FlSpot> _randomData;
  late List<bool> _repsWereIncreased;

  ///
  /// Explanation text
  ///
  String _yAxisParameterdescription = ChartYAxisValue.totalVolume.description;

  ///
  /// Tipo de eje Y seleccionado
  ///
  ChartYAxisValue _selectedYAxisValue = ChartYAxisValue.totalVolume;

  ///
  /// Funcion para generar random data para el grafico.
  ///
  void _generateRandomData() {
    int randomDataLen = 12;
    _repsWereIncreased = List.generate(
      randomDataLen,
      (_) => Random().nextBool(),
    );
    _randomData = List.generate(
      randomDataLen,
      (index) => FlSpot(index.toDouble(), Random().nextDouble() * 200),
    );
  }

  ///
  /// Funciones para widgets.
  ///
  void _changeChartYAxisValueHandler(int selectedIndex) {
    ChartYAxisValue newChartYAxisValue = ChartYAxisValue.values[selectedIndex];
    setState(() {
      _selectedYAxisValue = newChartYAxisValue;
      _yAxisParameterdescription = newChartYAxisValue.description;
    });
  }

  @override
  void initState() {
    super.initState();
    _generateRandomData();
  }

  @override
  Widget build(BuildContext context) {
    final toggleButtonState = [
      _selectedYAxisValue == ChartYAxisValue.weight,
      _selectedYAxisValue == ChartYAxisValue.reps,
      _selectedYAxisValue == ChartYAxisValue.totalVolume,
    ];

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
        title: const Text("General Stats"),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
          child: Column(
            children: [
              Container(
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.surface,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: const [
                    BoxShadow(
                      color: Colors.black12,
                      blurRadius: 4,
                      offset: Offset(0, 2),
                    ),
                  ],
                ),
                padding: const EdgeInsets.symmetric(
                  horizontal: 8,
                  vertical: 16,
                ),
                child: SizedBox(
                  width: double.infinity,
                  child: Column(
                    children: [
                      RichText(
                        text: TextSpan(
                          children: const <TextSpan>[
                            TextSpan(
                              text: 'Total number of sets: ',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            TextSpan(
                              text: '200',
                              style: TextStyle(fontWeight: FontWeight.normal),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 8),
                      RichText(
                        text: TextSpan(
                          children: const <TextSpan>[
                            TextSpan(
                              text: 'Total number of reps: ',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            TextSpan(
                              text: '1400',
                              style: TextStyle(fontWeight: FontWeight.normal),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 16),
              ExcerciseSetPlot(
                title: "My Progress",
                chartData: _randomData,
                repsWereIncreased: _repsWereIncreased,
              ),
              const SizedBox(height: 16),
              Container(
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.surface,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: const [
                    BoxShadow(
                      color: Colors.black12,
                      blurRadius: 4,
                      offset: Offset(0, 2),
                    ),
                  ],
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SizedBox(
                    width: double.infinity,
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.circle, color: Colors.amber),
                            const SizedBox(width: 4),
                            Text("Increased the number of reps."),
                          ],
                        ),
                        const SizedBox(height: 16),
                        ToggleButtons(
                          isSelected: toggleButtonState,
                          borderRadius: BorderRadius.circular(4),
                          onPressed: _changeChartYAxisValueHandler,
                          constraints: const BoxConstraints(
                            minHeight: 30,
                            minWidth: 50,
                          ),
                          children: [
                            Padding(
                              padding: EdgeInsets.symmetric(
                                horizontal: 8,
                                vertical: 2,
                              ),
                              child: Text("Weight"),
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(
                                horizontal: 8,
                                vertical: 2,
                              ),
                              child: Text("Total Volume"),
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(
                                horizontal: 8,
                                vertical: 2,
                              ),
                              child: Text("Reps"),
                            ),
                          ],
                        ),
                        const SizedBox(height: 16),
                        Text(
                          _yAxisParameterdescription,
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
