import 'package:flutter/material.dart';
import 'package:gym_tracker_ui/core/extensions/context_ext.dart';
import 'package:gym_tracker_ui/pages/widgets/modal_bottom_handle.dart';

enum ChartYAxisValue { weight, reps, totalVolume }

enum ChartTimeInterval {
  lastYear,
  lastSixMonths,
  lastThreeMonths,
  lastMonth,
  lastTwentySessions,
  lastTenSessions,
}

extension ChartTimeIntervalExtension on ChartTimeInterval {
  String get label {
    switch (this) {
      case ChartTimeInterval.lastTenSessions:
        return "Last 10 Sessions";
      case ChartTimeInterval.lastTwentySessions:
        return "Last 20 Sessions";
      case ChartTimeInterval.lastMonth:
        return "Last Month";
      case ChartTimeInterval.lastSixMonths:
        return "Last Six Months";
      case ChartTimeInterval.lastYear:
        return "Last Year";
      case ChartTimeInterval.lastThreeMonths:
        return "Last Three Months";
    }
  }
}

class GraphAxisData {
  final ChartTimeInterval chartTimeInterval;
  final ChartYAxisValue chartYAxisValue;

  GraphAxisData({
    required this.chartTimeInterval,
    required this.chartYAxisValue,
  });
}

class GraphSelectedAxis {
  final ChartTimeInterval chartTimeInterval;
  final ChartYAxisValue chartYAxisValue;

  GraphSelectedAxis({
    required this.chartTimeInterval,
    required this.chartYAxisValue,
  });
}

class GraphSettingsDialog extends StatefulWidget {
  const GraphSettingsDialog({
    super.key,
    required this.initialChartTimeInterval,
    required this.initialChartYAxisValue,
  });

  final ChartTimeInterval initialChartTimeInterval;
  final ChartYAxisValue initialChartYAxisValue;

  @override
  State<GraphSettingsDialog> createState() => GraphSettingsDialogState();
}

class GraphSettingsDialogState extends State<GraphSettingsDialog> {
  ///
  /// Intervalo de tiempo seleccionado
  ///
  late ChartTimeInterval _selectedChartTimeInterval;

  ///
  /// Tipo de eje Y seleccionado
  ///
  ChartYAxisValue _selectedYAxisValue = ChartYAxisValue.weight;

  ///
  /// Funciones para widgets.
  ///
  void _changeChartYAxisValueHandler(int selectedIndex) {
    ChartYAxisValue newChartYAxisValue = ChartYAxisValue.values[selectedIndex];
    setState(() {
      _selectedYAxisValue = newChartYAxisValue;
    });
  }

  void _updateGraphAxis() {
    Navigator.of(context).pop(
      GraphAxisData(
        chartTimeInterval: _selectedChartTimeInterval,
        chartYAxisValue: _selectedYAxisValue,
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    _selectedChartTimeInterval = widget.initialChartTimeInterval;
  }

  @override
  Widget build(BuildContext context) {
    final toggleButtonState = [
      _selectedYAxisValue == ChartYAxisValue.weight,
      _selectedYAxisValue == ChartYAxisValue.reps,
      _selectedYAxisValue == ChartYAxisValue.totalVolume,
    ];

    return SizedBox(
      width: double.infinity,
      child: Padding(
        padding: EdgeInsets.fromLTRB(0, 2, 0, context.keyBoardSpace),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const ModalBottomHandle(),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButton(
                    onPressed: () {
                      _updateGraphAxis();
                    },
                    icon: const Icon(Icons.check),
                  ),
                  const Spacer(),
                  const Text(
                    "Graph Settings",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  const Spacer(),
                  IconButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    icon: const Icon(Icons.close),
                  ),
                ],
              ),
              const Divider(),
              Padding(
                padding: const EdgeInsets.only(
                  bottom: 8,
                  top: 16,
                  left: 4,
                  right: 4,
                ),

                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      "Visualize:",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 4),
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
                      "Over:",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 4),
                    SizedBox(
                      height: 300,
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            for (final timePeriod
                                in ChartTimeInterval.values.reversed) ...[
                              SizedBox(
                                width: double.infinity,
                                child: ChoiceChip(
                                  selected:
                                      timePeriod == _selectedChartTimeInterval,
                                  label: SizedBox(
                                    width: double.infinity,
                                    child: Text(timePeriod.label),
                                  ),
                                  onSelected: (_) {
                                    setState(() {
                                      _selectedChartTimeInterval = timePeriod;
                                    });
                                  },
                                ),
                              ),
                              SizedBox(height: 4),
                            ],
                          ],
                        ),
                      ),
                    ),
                    const Divider(),
                    const SizedBox(height: 16),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton.icon(
                        onPressed: () {
                          _updateGraphAxis();
                        },
                        icon: const Icon(Icons.check),
                        label: const Text("Done"),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
