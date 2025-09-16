import 'dart:math';

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:gym_tracker_ui/pages/excercise_stats_page.dart';
import 'package:gym_tracker_ui/pages/widgets/dialogs/intensity_indicator_selector_dialog.dart';
import 'package:gym_tracker_ui/pages/widgets/dialogs/unit_selector_dialog.dart';

enum ChartXAxisValue { weight, reps }

const List<String> _months = [
  "Ene",
  "Feb",
  "Mar",
  "Abr",
  "May",
  "Jun",
  "Jul",
  "Ago",
  "Sep",
  "Oct",
  "Nov",
  "Dic",
  " ",
];

final List<int> _weightAxisLabels = List.generate(12, (index) => index * 25);

class ExcerciseStatsChart extends StatefulWidget {
  const ExcerciseStatsChart({super.key, required this.onSetClicked});

  final void Function(SetInformation) onSetClicked;

  @override
  State<ExcerciseStatsChart> createState() => _ExcerciseStatsChartState();
}

class _ExcerciseStatsChartState extends State<ExcerciseStatsChart> {
  ///
  /// Dummy data.
  ///

  final List<FlSpot> randomData = List.generate(
    12,
    (index) => FlSpot(index.toDouble(), Random().nextDouble() * 7),
  );

  final List<bool> repsWereIncremented = List.generate(
    12,
    (_) => Random().nextBool(),
  );

  ///
  /// Tipo de eje X seleccionado
  ///
  ChartXAxisValue _selectedXAxisValue = ChartXAxisValue.weight;

  ///
  /// Punto seleccionado.
  ///
  int? _selectedPointIndex;

  ///
  /// Funciones para widgets.
  ///
  void _changeChartXAxisValueHandler(int selectedIndex) {
    ChartXAxisValue newChartXAxisValue = ChartXAxisValue.values[selectedIndex];
    setState(() {
      _selectedXAxisValue = newChartXAxisValue;
    });
  }

  void _onPointClicked(double x, double y, int index) {
    final dummySetInformation = SetInformation(
      date: DateTime.now(),
      unit: Unit.units,
      indicator: IntensityIndicator.rir,
      reps: 10,
      indicatorValue: 2,
      weight: 120,
    );

    setState(() {
      _selectedPointIndex = index;
    });
    widget.onSetClicked(dummySetInformation);
  }

  @override
  Widget build(BuildContext context) {
    final toggleButtonState = [
      _selectedXAxisValue == ChartXAxisValue.weight,
      _selectedXAxisValue == ChartXAxisValue.reps,
    ];

    return Container(
      height: 450,
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.circular(12),
        boxShadow: const [
          BoxShadow(color: Colors.black12, blurRadius: 4, offset: Offset(0, 2)),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
        child: Column(
          children: [
            Row(
              children: [
                Text(
                  'My PR \' s for Last Year',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                const Spacer(),
                ToggleButtons(
                  isSelected: toggleButtonState,
                  borderRadius: BorderRadius.circular(4),
                  onPressed: _changeChartXAxisValueHandler,
                  constraints: const BoxConstraints(
                    minHeight: 30,
                    minWidth: 50,
                  ),
                  children: [
                    Padding(padding: EdgeInsets.all(2), child: Text("Weight")),
                    Padding(padding: EdgeInsets.all(2), child: Text("Reps")),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 16),
            SizedBox(
              height: 300,
              child: LineChart(
                LineChartData(
                  lineTouchData: LineTouchData(
                    enabled: true,
                    handleBuiltInTouches: true,
                    touchTooltipData: LineTouchTooltipData(
                      getTooltipItems: (_) => [],
                    ),
                    touchCallback:
                        (FlTouchEvent event, LineTouchResponse? touchResponse) {
                          if (!event.isInterestedForInteractions ||
                              touchResponse == null) {
                            return;
                          }

                          final spot = touchResponse.lineBarSpots?.first;
                          if (spot != null) {
                            final index = spot.spotIndex;
                            _onPointClicked(spot.x, spot.y, index);
                          }
                        },
                    getTouchedSpotIndicator:
                        (LineChartBarData barData, List<int> spotIndexes) {
                          return spotIndexes.map((index) {
                            return TouchedSpotIndicatorData(
                              FlLine(color: const Color.fromARGB(255, 36, 114, 173), strokeWidth: 2),
                              FlDotData(show: false),
                            );
                          }).toList();
                        },
                  ),
                  gridData: const FlGridData(show: true),
                  titlesData: FlTitlesData(
                    show: true,
                    leftTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        reservedSize: 30,
                        getTitlesWidget: (value, meta) => Text(
                          _weightAxisLabels[value.toInt()].toString(),
                          textAlign: TextAlign.center,
                          style: TextStyle(fontSize: 12),
                        ),
                      ),
                    ),
                    bottomTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        interval: 1,
                        reservedSize: 25,
                        getTitlesWidget: (value, meta) {
                          int index = value.toInt();
                          final month = _months[index];
                          return SideTitleWidget(
                            meta: meta,
                            child: Transform.rotate(
                              angle: -1,
                              child: Text(
                                month.toString(),
                                style: TextStyle(fontSize: 10),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                    rightTitles: AxisTitles(
                      sideTitles: SideTitles(showTitles: false),
                    ),
                    topTitles: AxisTitles(
                      sideTitles: SideTitles(showTitles: false),
                    ),
                  ),
                  borderData: FlBorderData(show: true),
                  minX: 0,
                  maxX: _months.length - 1,
                  minY: 0,
                  maxY: _weightAxisLabels.length - 1,
                  lineBarsData: [
                    LineChartBarData(
                      dotData: FlDotData(
                        show: true,
                        getDotPainter: (spot, percent, barData, index) {
                          if (index == _selectedPointIndex) {
                            return FlDotCirclePainter(color: Colors.blue);
                          }
                          if (repsWereIncremented[index]) {
                            return FlDotCirclePainter(color: Colors.amber);
                          }
                          return FlDotCirclePainter(
                            color: Theme.of(context).colorScheme.primary,
                          );
                        },
                      ),
                      color: Theme.of(context).colorScheme.secondary,
                      barWidth: 3,
                      belowBarData: BarAreaData(show: false),
                      spots: randomData,
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.circle, color: Colors.amber),
                const SizedBox(width: 4),
                Text("Increased the number of reps."),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
