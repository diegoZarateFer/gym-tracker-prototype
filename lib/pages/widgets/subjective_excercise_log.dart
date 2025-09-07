import 'package:flutter/material.dart';
import 'package:gym_tracker_ui/core/extensions/context_ext.dart';
import 'package:gym_tracker_ui/pages/widgets/add_set_cell.dart';
import 'package:gym_tracker_ui/pages/widgets/dialogs/register_subjective_set_dialog.dart';
import 'package:gym_tracker_ui/pages/widgets/empty_cell.dart';
import 'package:gym_tracker_ui/pages/widgets/excercise_log_header.dart';
import 'package:gym_tracker_ui/pages/widgets/field_cell.dart';
import 'package:gym_tracker_ui/pages/widgets/dialogs/register_regular_set_dialog.dart';
import 'package:gym_tracker_ui/pages/widgets/text_cell.dart';
import 'package:gym_tracker_ui/pages/widgets/title_cell.dart';

class SubjectiveExcerciseLog extends StatelessWidget {
  const SubjectiveExcerciseLog({super.key});

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
            const ExcerciseLogHeader(title: "Subjective Log Excercise"),
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
              children: <TableRow>[
                const TableRow(
                  children: [
                    TitleCell("Set"),
                    TitleCell("Weight"),
                    TitleCell("Reps"),
                    TitleCell("Previous"),
                  ],
                ),
                TableRow(
                  children: [
                    const TitleCell("1"),
                    FieldCell(
                      value: "120",
                      onRegisterSet: () {
                        context.showBottomDialog(const RegisterRegularSet());
                      },
                    ),
                    FieldCell(
                      value: "12",
                      onRegisterSet: () {
                        context.showBottomDialog(const RegisterRegularSet());
                      },
                    ),
                    const TextCell("120kg"),
                  ],
                ),
                TableRow(
                  children: [
                    const TitleCell("2"),
                    const EmptyCell(),
                    AddSetCell(
                      onAddSet: () {
                        context.showBottomDialog(const RegisterSubjectiveSet());
                      },
                    ),
                    const TextCell("120kg"),
                  ],
                ),
              ],
            ),
            const SizedBox(
              height: 8,
            ),
            ElevatedButton.icon(
              onPressed: () {},
              icon: const Icon(Icons.add),
              label: const Text(
                "New Set",
              ),
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(
                  horizontal: 8,
                  vertical: 8,
                ),
                tapTargetSize: MaterialTapTargetSize.shrinkWrap,
              ),
            ),
            const SizedBox(height: 8),
          ],
        ),
      ),
    );
  }
}
