import 'dart:math';

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:gym_tracker_ui/core/extensions/context_ext.dart';
import 'package:gym_tracker_ui/fake_data/fake_time_intervals.dart';
import 'package:gym_tracker_ui/pages/widgets/dialogs/graph_settings_dialog.dart';
import 'package:gym_tracker_ui/pages/widgets/dialogs/intensity_indicator_selector_dialog.dart';
import 'package:gym_tracker_ui/pages/widgets/dialogs/unit_selector_dialog.dart';
import 'package:gym_tracker_ui/pages/widgets/excercise_charts/excercise_stats_chart.dart';
import 'package:gym_tracker_ui/pages/widgets/history_log_cell.dart';
import 'package:gym_tracker_ui/pages/widgets/set_information_header.dart';
import 'package:gym_tracker_ui/pages/widgets/title_cell.dart';
import 'package:intl/intl.dart';

///
/// Extension para ayudar a generar random fake data.
///
extension RandomData on ChartTimeInterval {
  int get randomDataLen {
    switch (this) {
      case ChartTimeInterval.lastYear:
        return 12;
      case ChartTimeInterval.lastSixMonths:
        return 6;
      case ChartTimeInterval.lastThreeMonths:
        return 12;
      case ChartTimeInterval.lastMonth:
        return 30;
      case ChartTimeInterval.lastTwentySessions:
        return 20;
      case ChartTimeInterval.lastTenSessions:
        return 10;
    }
  }
}

final formatter = DateFormat('MMM dd, yyyy');

class SetInformation {
  final DateTime date;

  final Unit unit;
  final IntensityIndicator indicator;

  final int reps;
  final int? indicatorValue;
  final double weight;

  SetInformation({
    required this.date,
    required this.unit,
    required this.indicator,
    required this.reps,
    this.indicatorValue,
    required this.weight,
  });

  String get label {
    switch (indicator) {
      case IntensityIndicator.none:
        return "$weight ${unit.label} x $reps";
      case IntensityIndicator.rir:
        return "$weight ${unit.label} x $reps @ $indicatorValue RIR";
      case IntensityIndicator.rpe:
        return "$weight ${unit.label} x $reps @ $indicatorValue RPE";
      case IntensityIndicator.subjective:
        return "$weight ${unit.label} x $reps (Easy)";
    }
  }

  @override
  String toString() {
    return "Date = $date, Unit = $unit, indicator = $indicator, reps = $reps, indicatorValue = $indicatorValue, reps = $reps";
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
  late List<String> _dates;

  ///
  /// Variable para controlar intervalo tiempo de grafico.
  ///
  var _selectedChartTimeInterval = ChartTimeInterval.lastYear;

  ///
  /// Variable para controlar datos de eje X del grafico.
  ///
  var _selectedYAxisValue = ChartYAxisValue.weight;

  ///
  /// Variable para mostrar info del set.
  ///
  SetInformation? _setInformation;

  ///
  /// Funciones para widgets.
  ///
  Future<void> _showTimeIntervalSelectorDialog() async {
    final newChartAxis = await context.showBottomDialog<GraphAxisData?>(
      GraphSettingsDialog(
        initialChartTimeInterval: _selectedChartTimeInterval,
        initialChartYAxisValue: _selectedYAxisValue,
      ),
    );

    if (newChartAxis != null) {
      setState(() {
        _selectedChartTimeInterval = newChartAxis.chartTimeInterval;
        _selectedYAxisValue = newChartAxis.chartYAxisValue;
      });
      _generateRandomData();
    }
  }

  void _onSetClicked(SetInformation setInformation) {
    setState(() {
      _setInformation = setInformation;
    });
  }

  ///
  /// Generar un eje X fake.
  ///
  void _initXAxisDates(ChartTimeInterval timeInterval) {
    List<String> dates;
    switch (timeInterval) {
      case ChartTimeInterval.lastYear:
        dates = generateFakeLastYearLabels();
      case ChartTimeInterval.lastSixMonths:
        dates = generateFakeLastSixMonthsLabels();
      case ChartTimeInterval.lastThreeMonths:
        dates = generateFakeLastThreeMonthsLabels();
      case ChartTimeInterval.lastMonth:
        dates = generateFakeLastMonthLabels();
      case ChartTimeInterval.lastTwentySessions:
        dates = generateFakeLast20SessionsLabels();
      case ChartTimeInterval.lastTenSessions:
        dates = generateFakeLast10SessionsLabels();
    }

    setState(() {
      _dates = dates;
    });
  }

  ///
  /// Funcion para generar random data para el grafico.
  ///
  void _generateRandomData() {
    int randomDataLen = _selectedChartTimeInterval.randomDataLen;
    _repsWereIncreased = List.generate(
      randomDataLen,
      (_) => Random().nextBool(),
    );
    _randomData = List.generate(
      randomDataLen,
      (index) => FlSpot(index.toDouble(), Random().nextDouble() * 200),
    );
    _initXAxisDates(_selectedChartTimeInterval);
  }

  @override
  void initState() {
    super.initState();
    _generateRandomData();
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
        title: const Text("Excercise Name"),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: Column(
            children: [
              ExcerciseStatsChart(
                chartTimeInterval: _selectedChartTimeInterval,
                chartYAxisValue: _selectedYAxisValue,
                dateLabels: _dates,
                chartData: _randomData,
                repsWereIncreased: _repsWereIncreased,
                onSetClicked: _onSetClicked,
              ),
              const SizedBox(height: 16),
              SetInformationContainer(setInformation: _setInformation),
              const SizedBox(height: 16),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton.icon(
                  onPressed: _showTimeIntervalSelectorDialog,
                  label: Text("Graph Settings"),
                  icon: Icon(Icons.tune_outlined),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class SetInformationContainer extends StatelessWidget {
  const SetInformationContainer({super.key, this.setInformation});

  final SetInformation? setInformation;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.circular(12),
        boxShadow: const [
          BoxShadow(color: Colors.black12, blurRadius: 4, offset: Offset(0, 2)),
        ],
      ),
      child: setInformation == null
          ? Padding(
              padding: const EdgeInsets.all(16),
              child: Center(
                child: Text(
                  "Click a point if you wanto to check information about the set.",
                  textAlign: TextAlign.center,
                ),
              ),
            )
          : Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                SetInfomationHeader(
                  title: formatter.format(setInformation!.date),
                ),
                Divider(
                  height: 1,
                  thickness: 1,
                  color: Theme.of(context).colorScheme.onSecondary,
                ),
                Table(
                  border: const TableBorder(
                    horizontalInside: BorderSide(color: Colors.black, width: 1),
                  ),
                  columnWidths: const {
                    0: FlexColumnWidth(1),
                    1: FlexColumnWidth(1),
                    2: FlexColumnWidth(1),
                    3: FlexColumnWidth(1),
                    4: FlexColumnWidth(2),
                  },
                  children: const <TableRow>[
                    TableRow(
                      children: [
                        TitleCell("Set"),
                        TitleCell("Weight"),
                        TitleCell("Reps"),
                        TitleCell("RPE"),
                      ],
                    ),
                    TableRow(
                      children: [
                        TitleCell("1"),
                        HistoryLogCell(value: "120"),
                        HistoryLogCell(value: "12"),
                        HistoryLogCell(value: "2"),
                      ],
                    ),
                  ],
                ),
              ],
            ),
    );
  }
}
