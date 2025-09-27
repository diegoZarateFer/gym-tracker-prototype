import 'dart:math';

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:gym_tracker_ui/pages/excercise_stats_page.dart';
import 'package:gym_tracker_ui/pages/widgets/excercise_charts/excercise_set_plot.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class PlotDataScreen extends StatefulWidget {
  const PlotDataScreen({super.key});

  @override
  State<PlotDataScreen> createState() => _PlotDataScreenState();
}

class _PlotDataScreenState extends State<PlotDataScreen> {
  late List<FlSpot> _fakeSetData;
  late List<bool> _fakeRepsWereIncreased;

  ///
  /// Controller de page view.
  ///
  final _pageController = PageController();

  ///
  /// Explanation text
  ///
  String _yAxisParameterdescription = ChartYAxisValue.totalVolume.description;

  ///
  /// Tipo de eje Y seleccionado
  ///
  ChartYAxisValue _selectedYAxisValue = ChartYAxisValue.totalVolume;

  ///
  /// Funciones para widgets.
  ///
  void _changeChartYAxisValueHandler(int selectedIndex) {
    ChartYAxisValue newChartYAxisValue = ChartYAxisValue.values[selectedIndex];
    setState(() {
      _selectedYAxisValue = newChartYAxisValue;
      _yAxisParameterdescription = _selectedYAxisValue.description;
    });
  }

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
    final toggleButtonState = [
      _selectedYAxisValue == ChartYAxisValue.weight,
      _selectedYAxisValue == ChartYAxisValue.totalVolume,
      _selectedYAxisValue == ChartYAxisValue.reps,
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
        title: const Text("Excercise name"),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 8),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(
                "21, Sep 2025 - 30, Nov 2025",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              Container(
                height: 440,
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
                child: Column(
                  children: [
                    Expanded(
                      child: PageView(
                        controller: _pageController,
                        children: [
                          ExcerciseSetPlot(
                            title: "Set 1",
                            repsWereIncreased: _fakeRepsWereIncreased,
                            chartData: _fakeSetData,
                          ),
                          ExcerciseSetPlot(
                            title: "Set 2",
                            repsWereIncreased: _fakeRepsWereIncreased,
                            chartData: _fakeSetData,
                          ),
                          ExcerciseSetPlot(
                            title: "Set 3",
                            repsWereIncreased: _fakeRepsWereIncreased,
                            chartData: _fakeSetData,
                          ),
                          ExcerciseSetPlot(
                            title: "Set 4",
                            repsWereIncreased: _fakeRepsWereIncreased,
                            chartData: _fakeSetData,
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 8),
                    Padding(
                      padding: const EdgeInsets.all(4),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          IconButton(
                            onPressed: () {
                              _pageController.previousPage(
                                duration: const Duration(milliseconds: 300),
                                curve: Curves.easeIn,
                              );
                            },
                            icon: Icon(Icons.arrow_back),
                          ),
                          SmoothPageIndicator(
                            controller: _pageController,
                            count: 4,
                            effect: WormEffect(
                              type: WormType.thinUnderground,
                              dotColor: Theme.of(context).colorScheme.onPrimary,
                              activeDotColor: Theme.of(
                                context,
                              ).colorScheme.primary,
                            ),
                          ),
                          IconButton(
                            onPressed: () {
                              _pageController.nextPage(
                                duration: const Duration(milliseconds: 300),
                                curve: Curves.easeIn,
                              );
                            },
                            icon: Icon(Icons.arrow_forward),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 8),
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
                  padding: const EdgeInsets.symmetric(
                    vertical: 16,
                    horizontal: 8,
                  ),
                  child: Column(
                    children: [
                      Text(
                        "Show:",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 8),
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
                      const SizedBox(height: 8),
                      Text(
                        _yAxisParameterdescription,
                        textAlign: TextAlign.center,
                      ),
                    ],
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
