import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

class WeekCalendar extends StatelessWidget {
  final CalendarFormat _calendarFormat = CalendarFormat.week;

  const WeekCalendar({super.key});

  @override
  Widget build(BuildContext context) {
    return TableCalendar(
      firstDay: DateTime.now().add(const Duration(days: -365)),
      focusedDay: DateTime.now(),
      lastDay: DateTime.now().add(const Duration(days: 365)),
      calendarFormat: _calendarFormat,
      availableCalendarFormats: const {CalendarFormat.week: 'week'},
      headerStyle: const HeaderStyle(
        titleCentered: true,
      ),
    );
  }
}
