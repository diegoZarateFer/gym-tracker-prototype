import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gym_tracker_ui/pages/widgets/modal_bottom_handle.dart';

/// Lista para los minutos.
///
final _minutes = List.generate(61, (minute) => Text('$minute'));

/// Lista para los segundos.
///
final _seconds = List.generate(61, (second) => Text('$second'));

class RestTimeSelectorDialog extends StatefulWidget {
  const RestTimeSelectorDialog({super.key});

  @override
  State<RestTimeSelectorDialog> createState() => _RestTimeSelectorDialogState();
}

class _RestTimeSelectorDialogState extends State<RestTimeSelectorDialog> {
  @override
  Widget build(BuildContext context) {
    final keyboardSpace = MediaQuery.of(context).viewInsets.bottom;

    return SizedBox(
      width: double.infinity,
      height: 300,
      child: Padding(
        padding: EdgeInsets.fromLTRB(2, 2, 2, keyboardSpace + 16),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            const ModalBottomHandle(),
            const Text(
              "Set Rest Timer",
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            Expanded(
              child: Center(
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Expanded(
                          child: SizedBox(
                            height: 120,
                            child: CupertinoPicker(
                              looping: true,
                              itemExtent: 40,
                              onSelectedItemChanged: (int index) {},
                              children: _minutes,
                            ),
                          ),
                        ),
                        const Text("min."),
                        const SizedBox(width: 8),
                        Expanded(
                          child: SizedBox(
                            height: 120,
                            child: CupertinoPicker(
                              looping: true,
                              itemExtent: 40,
                              onSelectedItemChanged: (int index) {},
                              children: _seconds,
                            ),
                          ),
                        ),
                        const Text("secs."),
                      ],
                    ),
                  ],
                ),
              ),
            ),
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
      ),
    );
  }
}
