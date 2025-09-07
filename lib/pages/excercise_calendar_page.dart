import 'package:flutter/material.dart';
import 'package:gym_tracker_ui/pages/widgets/rir_history_excercise_log.dart';
import 'package:table_calendar/table_calendar.dart';

class ExcerciseCalendarPage extends StatefulWidget {
  static const String route = "/excercise-calendar";

  const ExcerciseCalendarPage({
    super.key,
  });

  @override
  State<ExcerciseCalendarPage> createState() => _ExcerciseCalendarPageState();
}

class _ExcerciseCalendarPageState extends State<ExcerciseCalendarPage> {
  final _focusedDay = DateTime.now();
  final _firstDay = DateTime.now().add(const Duration(days: -365));
  final _lastDay = DateTime.now().add(const Duration(days: 365));

  final CalendarFormat _calendarFormat = CalendarFormat.month;

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
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8),
              child: Container(
                height: 420,
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
                  padding: const EdgeInsets.all(8),
                  child: TableCalendar(
                    focusedDay: _focusedDay,
                    firstDay: _firstDay,
                    lastDay: _lastDay,
                    calendarFormat: _calendarFormat,
                    availableCalendarFormats: const {
                      CalendarFormat.month: 'month'
                    },
                    headerStyle: const HeaderStyle(
                      titleCentered: true,
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 16),
            const RIRHistoryExcerciseLog(),
          ],
        ),
      ),
    );
  }
}
