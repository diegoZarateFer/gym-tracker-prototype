import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:gym_tracker_ui/pages/widgets/dialogs/graph_settings_dialog.dart';

class ExcerciseStatsChart extends StatefulWidget {
  const ExcerciseStatsChart({
    super.key,
    required this.chartTimeInterval,
    required this.chartYAxisValue,
    required this.dateLabels,
    required this.repsWereIncreased,
    required this.chartData,
  });

  final ChartTimeInterval chartTimeInterval;
  final ChartYAxisValue chartYAxisValue;

  final List<String> dateLabels;
  final List<bool> repsWereIncreased;
  final List<FlSpot> chartData;

  @override
  State<ExcerciseStatsChart> createState() => _ExcerciseStatsChartState();
}

class _ExcerciseStatsChartState extends State<ExcerciseStatsChart> {
  ///
  /// Punto seleccionado.
  ///
  int? _selectedPointIndex;

  @override
  Widget build(BuildContext context) {
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
            SizedBox(
              height: 300,
              child: LineChart(
                LineChartData(
                  lineTouchData: LineTouchData(
                    enabled: true,
                    handleBuiltInTouches: true,
                    touchTooltipData: LineTouchTooltipData(
                      getTooltipItems: (touchedSpots) {
                        return touchedSpots.map((spot) {
                          return LineTooltipItem(
                            "Sep, 2025",
                            const TextStyle(fontSize: 12),
                          );
                        }).toList();
                      },
                    ),
                    getTouchedSpotIndicator:
                        (LineChartBarData barData, List<int> spotIndexes) {
                          return spotIndexes.map((index) {
                            return TouchedSpotIndicatorData(
                              FlLine(
                                color: const Color.fromARGB(255, 36, 114, 173),
                                strokeWidth: 2,
                              ),
                              FlDotData(show: false),
                            );
                          }).toList();
                        },
                  ),
                  gridData: const FlGridData(
                    show: true,
                    drawHorizontalLine: true,
                  ),
                  titlesData: FlTitlesData(
                    show: true,
                    bottomTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        interval: 1,
                        reservedSize: 30,
                        getTitlesWidget: (value, meta) {
                          int index = value.toInt();

                          if (widget.chartData.length > 12) {
                            return const SizedBox.shrink();
                          }

                          final date = widget.dateLabels[index];
                          return SideTitleWidget(
                            meta: meta,
                            child: Transform.rotate(
                              angle: -0.4,
                              child: Text(date, style: TextStyle(fontSize: 8)),
                            ),
                          );
                        },
                      ),
                    ),
                    leftTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        reservedSize: 40,
                        getTitlesWidget: (value, meta) {
                          return SideTitleWidget(
                            meta: meta,
                            child: Text(
                              value.toInt().toString(),
                              textAlign: TextAlign.center,
                              style: TextStyle(fontSize: 12),
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
                  maxX: widget.dateLabels.length - 1,
                  minY: 0,
                  maxY: 200,
                  lineBarsData: [
                    LineChartBarData(
                      dotData: FlDotData(
                        show: true,
                        getDotPainter: (spot, percent, barData, index) {
                          int safeIndex = index.clamp(
                            0,
                            widget.chartData.length - 1,
                          );
                          if (safeIndex == _selectedPointIndex) {
                            return FlDotCirclePainter(color: Colors.blue);
                          }
                          if (widget.repsWereIncreased[safeIndex]) {
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
                      spots: widget.chartData,
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
