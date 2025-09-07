import 'package:flutter/material.dart';

class FilterControl extends StatefulWidget {
  const FilterControl({super.key, required this.filterName});

  final String filterName;

  @override
  State<FilterControl> createState() => _FilterControlState();
}

class _FilterControlState extends State<FilterControl> {
  bool _isOn = false;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        left: 8,
        right: 8,
      ),
      child: Center(
        child: Row(
          children: [
            Text(
              widget.filterName,
              style: const TextStyle(
                fontSize: 16,
              ),
            ),
            const Spacer(),
            Switch(
              value: _isOn,
              onChanged: (bool value) {
                setState(() {
                  _isOn = value;
                });
              },
            ),
          ],
        ),
      ),
    );
  }
}
