import 'package:flutter/material.dart';
import 'package:gym_tracker_ui/pages/excercise_history_page.dart';
import 'package:gym_tracker_ui/pages/excercise_settings_page.dart';
import 'package:gym_tracker_ui/core/extensions/context_ext.dart';
import 'package:gym_tracker_ui/pages/widgets/dialogs/add_excercise_comment_dialog.dart';

class ExcerciseLogHeader extends StatelessWidget {
  const ExcerciseLogHeader({
    super.key,
    required this.title,
  });

  final String title;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
      ),
      child: Row(
        children: [
          Text(
            title,
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
          const Spacer(),
          IconButton(
            onPressed: () {
              Navigator.of(context).pushNamed(ExcerciseHistoryPage.route);
            },
            icon: const Icon(Icons.history),
          ),
          IconButton(
            onPressed: () {
              context.showBottomDialog(const AddExerciseComment());
            },
            icon: const Icon(Icons.comment),
          ),
          IconButton(
            onPressed: () {
              Navigator.pushNamed(context, ExcerciseSettingsPage.route);
            },
            icon: const Icon(Icons.settings),
          ),
        ],
      ),
    );
  }
}
