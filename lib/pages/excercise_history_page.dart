import 'package:flutter/material.dart';
import 'package:gym_tracker_ui/pages/excercise_calendar_page.dart';
import 'package:gym_tracker_ui/core/extensions/context_ext.dart';
import 'package:gym_tracker_ui/pages/excercise_stats_page.dart';
import 'package:gym_tracker_ui/pages/plot_data.dart';
import 'package:gym_tracker_ui/pages/widgets/dialogs/filter_excercise_history_dialog.dart';
import 'package:gym_tracker_ui/pages/widgets/regular_excercise_history_log.dart';
import 'package:gym_tracker_ui/pages/widgets/rir_history_excercise_log.dart';
import 'package:gym_tracker_ui/pages/widgets/rpe_history_excercise_log.dart';
import 'package:gym_tracker_ui/pages/widgets/subjective_excercise_history_log.dart';
import 'package:intl/intl.dart';

final _formatter = DateFormat('MMM dd, yyyy');

class ExcerciseHistoryPage extends StatefulWidget {
  static const String route = "/excercise-history";

  const ExcerciseHistoryPage({super.key});

  @override
  State<ExcerciseHistoryPage> createState() => _ExcerciseHistoryPageState();
}

class _ExcerciseHistoryPageState extends State<ExcerciseHistoryPage> {
  late DateTime _selectedStartDate;
  late DateTime _selectedEndDate;

  ///
  /// Mostrar date picker.
  ///
  Future<DateTime?> _presentDatePicker(DateTime initialDate) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: initialDate,
      firstDate: DateTime(2000),
      lastDate: DateTime(2030),
    );

    return pickedDate;
  }

  @override
  void initState() {
    super.initState();

    _selectedStartDate = DateTime.now().add(const Duration(days: -30));
    _selectedEndDate = DateTime.now();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.background,
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        title: const Text("Excercise Name"),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.of(context).pushNamed(ExcerciseCalendarPage.route);
            },
            icon: const Icon(Icons.calendar_month),
          ),
          IconButton(
            onPressed: () {
              Navigator.of(context).pushNamed(ExcerciseStatsPage.route);
            },
            icon: const Icon(Icons.show_chart),
          ),
        ],
      ),
      body: const SingleChildScrollView(
        child: Column(
          children: [
            RIRHistoryExcerciseLog(),
            RPEHistoryExcerciseLog(),
            RegularExcerciseHistoryLog(),
            SubjectiveExcerciseHistoryLog(),
          ],
        ),
      ),
      bottomNavigationBar: SafeArea(
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            color: Theme.of(context).bottomSheetTheme.backgroundColor,
          ),
          child: Padding(
            padding: const EdgeInsets.all(8),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TextButton.icon(
                      onPressed: () async {
                        final selectedDate = await _presentDatePicker(
                          _selectedStartDate,
                        );

                        setState(() {
                          _selectedStartDate =
                              selectedDate ?? _selectedStartDate;
                        });
                      },
                      label: Text(_formatter.format(_selectedStartDate)),
                      icon: Icon(Icons.calendar_month),
                    ),
                    Icon(Icons.remove),
                    TextButton.icon(
                      onPressed: () async {
                        final selectedDate = await _presentDatePicker(
                          _selectedEndDate,
                        );

                        setState(() {
                          _selectedEndDate = selectedDate ?? _selectedEndDate;
                        });
                      },
                      label: Text(_formatter.format(_selectedEndDate)),
                      icon: Icon(Icons.calendar_month),
                    ),
                    const Spacer(),
                    IconButton(
                      onPressed: () {
                        context.showBottomDialog(
                          const FilterExcerciseHistoryDialog(),
                        );
                      },
                      icon: Icon(Icons.tune),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton.icon(
                    onPressed: () {
                      Navigator.of(
                        context,
                      ).push(MaterialPageRoute(builder: (ctx) => PlotData()));
                    },
                    label: Text("Plot Data"),
                    icon: const Icon(Icons.bar_chart),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
