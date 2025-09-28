import 'package:flutter/material.dart';

class RepRangeSelector extends StatefulWidget {
  const RepRangeSelector({super.key});

  @override
  State<RepRangeSelector> createState() => _RepRangeSelectorState();
}

class _RepRangeSelectorState extends State<RepRangeSelector> {
  ///
  /// Valores del rango de repeticiones.
  ///
  int _selectedRepRangeStart = 5;
  int _selectedRepRangeEnd = 10;

  ///
  /// Cambiar rango de repeticiones
  ///
  void _changeRepsRangeHandler(RangeValues newValues) {
    setState(() {
      _selectedRepRangeStart = newValues.start.toInt();
      _selectedRepRangeEnd = newValues.end.toInt();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        RichText(
          text: TextSpan(
            children: [
              const TextSpan(text: "Between"),
              TextSpan(
                text: " $_selectedRepRangeStart - $_selectedRepRangeEnd ",
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              const TextSpan(text: "reps."),
            ],
          ),
        ),
        const SizedBox(height: 8),
        SliderTheme(
          data: SliderTheme.of(context).copyWith(thumbColor: Colors.white),
          child: RangeSlider(
            min: 1,
            max: 25,
            values: RangeValues(
              _selectedRepRangeStart.toDouble(),
              _selectedRepRangeEnd.toDouble(),
            ),
            onChanged: _changeRepsRangeHandler,
          ),
        ),
      ],
    );
  }
}
