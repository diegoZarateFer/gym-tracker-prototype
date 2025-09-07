import 'package:flutter/material.dart';
import 'package:gym_tracker_ui/pages/widgets/modal_bottom_handle.dart';

class ViewExerciseNotes extends StatelessWidget {
  const ViewExerciseNotes({super.key});

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
              const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Notes",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              const Divider(),
              const TextField(
                enabled: false,
                textAlignVertical: TextAlignVertical.center,
                textAlign: TextAlign.start,
                maxLines: 8,
                decoration: InputDecoration(
                  counterText: "",
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 16),
              ElevatedButton.icon(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                icon: const Icon(Icons.close),
                label: const Text("Close"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
