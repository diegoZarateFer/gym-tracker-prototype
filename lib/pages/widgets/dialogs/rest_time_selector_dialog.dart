import 'package:flutter/material.dart';
import 'package:gym_tracker_ui/core/extensions/context_ext.dart';
import 'package:gym_tracker_ui/pages/widgets/modal_bottom_handle.dart';
import 'package:gym_tracker_ui/pages/widgets/rest_time_selector.dart';

class RestTimeSelectorDialog extends StatefulWidget {
  const RestTimeSelectorDialog({super.key});

  @override
  State<RestTimeSelectorDialog> createState() => _RestTimeSelectorDialogState();
}

class _RestTimeSelectorDialogState extends State<RestTimeSelectorDialog> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(2, 2, 2, context.keyBoardSpace),
      child: Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          const ModalBottomHandle(),
          const Text(
            "Set Rest Timer",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),
          RestTimeSelector(),
          const SizedBox(height: 16),
          ElevatedButton.icon(
            onPressed: () {
              Navigator.of(context).pop();
            },
            icon: const Icon(Icons.done),
            label: const Text("Set Timer"),
          ),
        ],
      ),
    );
  }
}
