import 'package:flutter/material.dart';
import 'package:gym_tracker_ui/core/extensions/context_ext.dart';
import 'package:gym_tracker_ui/pages/widgets/check_button.dart';
import 'package:gym_tracker_ui/pages/widgets/modal_bottom_handle.dart';

enum Unit { units, kgs, lbs, none }

extension UnitLabels on Unit {
  String get label {
    switch (this) {
      case Unit.kgs:
        return "kgs";
      case Unit.lbs:
        return "lbs";
      case Unit.units:
        return "units";
      case Unit.none:
        return "";
    }
  }
}

class UnitSelectorDialog extends StatefulWidget {
  const UnitSelectorDialog({super.key});

  @override
  State<UnitSelectorDialog> createState() => _UnitSelectorDialogState();
}

class _UnitSelectorDialogState extends State<UnitSelectorDialog> {
  ///
  /// Unidad de medida seleccionada.
  ///
  Unit _selectedUnit = Unit.kgs;

  ///
  /// Cmabiar la ubidiad selecionada.
  ///
  void _changeSelectedUnit(Unit unit) {
    setState(() {
      _selectedUnit = unit;
    });
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Padding(
        padding: EdgeInsets.fromLTRB(2, 2, 2, context.keyBoardSpace),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const ModalBottomHandle(),
            const Text(
              "Unit For The Excercise",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                CheckButton(
                  isChecked: _selectedUnit == Unit.kgs,
                  title: "Kilograms (kgs)",
                  onPressed: () {
                    _changeSelectedUnit(Unit.kgs);
                  },
                ),
                const SizedBox(height: 16),
                CheckButton(
                  isChecked: _selectedUnit == Unit.lbs,
                  title: "Pounds (lbs)",
                  onPressed: () {
                    _changeSelectedUnit(Unit.lbs);
                  },
                ),
                const SizedBox(height: 16),
                CheckButton(
                  isChecked: _selectedUnit == Unit.units,
                  title: "Generic unit",
                  onPressed: () {
                    _changeSelectedUnit(Unit.units);
                  },
                ),
                const SizedBox(height: 16),
                CheckButton(
                  isChecked: _selectedUnit == Unit.none,
                  title: "None",
                  onPressed: () {
                    _changeSelectedUnit(Unit.none);
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
