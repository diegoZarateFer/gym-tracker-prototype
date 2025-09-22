import 'dart:math';

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:gym_tracker_ui/pages/widgets/excercise_charts/excercise_set_plot.dart';

class PlotData extends StatefulWidget {
  const PlotData({super.key});

  @override
  State<PlotData> createState() => _PlotDataState();
}

class _PlotDataState extends State<PlotData> {
  late List<FlSpot> _fakeSetData;
  late List<bool> _fakeRepsWereIncreased;

  @override
  void initState() {
    super.initState();

    _fakeSetData = List.generate(
      30,
      (index) => FlSpot(index.toDouble(), Random().nextDouble() * 200),
    );

    _fakeRepsWereIncreased = List.generate(30, (_) => Random().nextBool());
  }

  @override
  Widget build(BuildContext context) {
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
        title: const Text("21, Sep 2025 - 30, Nov 2025"),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 8),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.circle, color: Colors.amber),
                  const SizedBox(width: 4),
                  Text("Increased the number of reps."),
                ],
              ),
              const SizedBox(height: 16),
              ExcerciseSetPlot(
                title: "Set 1",
                repsWereIncreased: _fakeRepsWereIncreased,
                chartData: _fakeSetData,
              ),
              const SizedBox(height: 16),
              ExcerciseSetPlot(
                title: "Set 2",
                repsWereIncreased: _fakeRepsWereIncreased,
                chartData: _fakeSetData,
              ),
              const SizedBox(height: 16),
              ExcerciseSetPlot(
                title: "Set 3",
                repsWereIncreased: _fakeRepsWereIncreased,
                chartData: _fakeSetData,
              ),
              const SizedBox(height: 16),
              ExcerciseSetPlot(
                title: "Set 4",
                repsWereIncreased: _fakeRepsWereIncreased,
                chartData: _fakeSetData,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
