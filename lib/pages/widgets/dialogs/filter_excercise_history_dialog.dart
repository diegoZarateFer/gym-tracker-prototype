import 'package:flutter/material.dart';
import 'package:gym_tracker_ui/pages/widgets/filter_control.dart';
import 'package:gym_tracker_ui/pages/widgets/modal_bottom_handle.dart';

class FilterExcerciseHistoryDialog extends StatelessWidget {
  const FilterExcerciseHistoryDialog({super.key});

  @override
  Widget build(BuildContext context) {
    final keyboardSpace = MediaQuery.of(context).viewInsets.bottom;
    return SizedBox(
      width: double.infinity,
      child: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.fromLTRB(2, 2, 2, keyboardSpace + 16),
          child: Column(
            children: [
              const ModalBottomHandle(),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    icon: const Icon(
                      Icons.check,
                    ),
                  ),
                  const Spacer(),
                  const Text(
                    "Show only",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const Spacer(),
                  IconButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    icon: const Icon(
                      Icons.close,
                    ),
                  ),
                ],
              ),
              const Divider(),
              const FilterControl(filterName: "Set 1"),
              const SizedBox(height: 8),
              const FilterControl(filterName: "Set 2"),
              const SizedBox(height: 8),
              const FilterControl(filterName: "Set 3"),
              const SizedBox(height: 8),
              const FilterControl(filterName: "Set 4"),
              const SizedBox(height: 8),
              const FilterControl(filterName: "Set 5"),
              const SizedBox(height: 16),
              ElevatedButton.icon(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                icon: const Icon(Icons.check),
                label: const Text("Apply"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
