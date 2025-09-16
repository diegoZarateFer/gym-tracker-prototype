import 'package:flutter/material.dart';
import 'package:gym_tracker_ui/core/extensions/context_ext.dart';
import 'package:gym_tracker_ui/pages/widgets/check_button.dart';
import 'package:gym_tracker_ui/pages/widgets/modal_bottom_handle.dart';

enum ChartTimeInterval {
  lastYear,
  lastSixMonths,
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
    }
  }
}

class ChartTimeIntervalSelectorDialog extends StatefulWidget {
  const ChartTimeIntervalSelectorDialog({
    super.key,
    required this.initialChartTimeInterval,
  });

  final ChartTimeInterval initialChartTimeInterval;

  @override
  State<ChartTimeIntervalSelectorDialog> createState() =>
      _ChartTimeIntervalSelectorDialogState();
}

class _ChartTimeIntervalSelectorDialogState
    extends State<ChartTimeIntervalSelectorDialog> {
  late ChartTimeInterval _selectedChartTimeInterval;

  ///
  /// Funciones para widgets.
  ///
  void _changeSelectedTimeIntervalHandler(ChartTimeInterval? value) {
    setState(() {
      _selectedChartTimeInterval = value ?? ChartTimeInterval.lastTenSessions;
    });
  }

  @override
  void initState() {
    super.initState();
    _selectedChartTimeInterval = widget.initialChartTimeInterval;
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Padding(
        padding: EdgeInsets.fromLTRB(0, 2, 0, context.keyBoardSpace),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const ModalBottomHandle(),
            const Text(
              "Check my progress for",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            const Divider(),
            Padding(
              padding: const EdgeInsets.only(
                bottom: 8,
                top: 16,
                left: 4,
                right: 4,
              ),
              child: RadioGroup(
                groupValue: _selectedChartTimeInterval,
                onChanged: _changeSelectedTimeIntervalHandler,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    for (final timePeriod
                        in ChartTimeInterval.values.reversed) ...[
                      CheckButton(
                        isChecked: timePeriod == _selectedChartTimeInterval,
                        title: timePeriod.label,
                        onPressed: () {
                          setState(() {
                            _selectedChartTimeInterval = timePeriod;
                          });
                          Navigator.of(context).pop(_selectedChartTimeInterval);
                        },
                      ),
                      SizedBox(height: 16),
                    ],
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
