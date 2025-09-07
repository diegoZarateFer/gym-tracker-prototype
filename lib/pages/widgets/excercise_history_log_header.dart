import 'package:flutter/material.dart';
import 'package:gym_tracker_ui/core/extensions/context_ext.dart';
import 'package:gym_tracker_ui/pages/widgets/dialogs/show_set_videos_dialog.dart';
import 'package:gym_tracker_ui/pages/widgets/dialogs/view_excercise_notes_dialog.dart';

class ExcerciseHistoryLogHeader extends StatelessWidget {
  const ExcerciseHistoryLogHeader({
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
              context.showBottomDialog(const ViewExerciseNotes());
            },
            icon: const Icon(Icons.description),
          ),
          IconButton(
            onPressed: () {
              context.showBottomDialog(const ShowSetVideos());
            },
            icon: const Icon(Icons.video_library),
          ),
        ],
      ),
    );
  }
}
