import 'dart:math';

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';

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

final List<int> _weightAxisLabels = List.generate(8, (index) => index * 25);

class LastYearChart extends StatelessWidget {
  ///
  /// Logger
  ///
  static final logger = Logger();

  const LastYearChart({super.key});

  @override
  Widget build(BuildContext context) {
    final List<FlSpot> randomData = List.generate(
      12,
      (index) => FlSpot(index.toDouble(), Random().nextDouble() * 7),
    );
    return Container(
      height: 380,
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
            Text(
              'My PR \' s for Last Year',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            SizedBox(
              height: 300,
              child: LineChart(
                LineChartData(
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
                  maxY: 7,
                  lineBarsData: [
                    LineChartBarData(
                      color: Theme.of(context).colorScheme.secondary,
                      barWidth: 3,
                      belowBarData: BarAreaData(show: false),
                      spots: randomData,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
