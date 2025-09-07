import 'package:flutter/material.dart';
import 'package:gym_tracker_ui/pages/widgets/excercise_history_log_header.dart';
import 'package:gym_tracker_ui/pages/widgets/history_log_cell.dart';
import 'package:gym_tracker_ui/pages/widgets/title_cell.dart';

class SubjectiveExcerciseHistoryLog extends StatelessWidget {
  const SubjectiveExcerciseHistoryLog({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
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
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const ExcerciseHistoryLogHeader(title: "Subjective Log Excercise"),
            Divider(
              height: 1,
              thickness: 1,
              color: Theme.of(context).colorScheme.onSecondary,
            ),
            Table(
              border: const TableBorder(
                horizontalInside: BorderSide(
                  color: Colors.black,
                  width: 1,
                ),
              ),
              columnWidths: const {
                0: FlexColumnWidth(1),
                1: FlexColumnWidth(1),
                2: FlexColumnWidth(1),
                3: FlexColumnWidth(2),
              },
              children: const <TableRow>[
                TableRow(
                  children: [
                    TitleCell("Set"),
                    TitleCell("Weight"),
                    TitleCell("Reps"),
                    TitleCell("Difficulty"),
                  ],
                ),
                TableRow(
                  children: [
                    TitleCell("1"),
                    HistoryLogCell(
                      value: "120",
                    ),
                    HistoryLogCell(
                      value: "12",
                      isFailure: true,
                    ),
                    HistoryLogCell(
                      value: "Easy",
                    ),
                  ],
                ),
                TableRow(
                  children: [
                    TitleCell("2"),
                    HistoryLogCell(
                      value: "120",
                    ),
                    HistoryLogCell(
                      value: "12",
                      isPr: true,
                    ),
                    HistoryLogCell(
                      value: "Medium",
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
