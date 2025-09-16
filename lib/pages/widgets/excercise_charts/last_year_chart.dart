import 'dart:math';

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

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

class LastYearChart extends StatefulWidget {
  const LastYearChart({super.key});

  @override
  State<LastYearChart> createState() => _LastYearChartState();
}

class _LastYearChartState extends State<LastYearChart> {

  ///
  /// Eje X seleccionado
  ///
  ChartXAxisValue _selectedXAxisValue = ChartXAxisValue.weight;

  ///
  /// Funciones para widgets.
  ///
  void _changeChartXAxisValueHandler(int selectedIndex) {
    ChartXAxisValue newChartXAxisValue = ChartXAxisValue.values[selectedIndex];
    setState(() {
      _selectedXAxisValue = newChartXAxisValue;
    });
  }

  @override
  Widget build(BuildContext context) {
    final List<FlSpot> randomData = List.generate(
      12,
      (index) => FlSpot(index.toDouble(), Random().nextDouble() * 7),
    );

    final List<bool> repsWereIncremented = List.generate(
      12,
      (_) => Random().nextBool(),
    );

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
                    touchTooltipData: LineTouchTooltipData(
                      tooltipPadding: EdgeInsets.all(4),
                      getTooltipItems: (List<LineBarSpot> touchedSpots) {
                        return touchedSpots
                            .map(
                              (spot) => LineTooltipItem(
                                "120lbsx5 @2 RIR",
                                TextStyle(color: Colors.white),
                              ),
                            )
                            .toList();
                      },
                    ),
                    handleBuiltInTouches: true,
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
                          if (repsWereIncremented[index]) {
                            return FlDotCirclePainter(color: Colors.amber);
                          }
                          return FlDotCirclePainter(
                            color: Theme.of(context).colorScheme.secondary,
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
