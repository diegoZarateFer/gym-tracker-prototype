import 'package:flutter/material.dart';

enum BarType { ez, standard, light }

const Map<BarType, double> barWeights = {
  BarType.ez: 15,
  BarType.standard: 45,
  BarType.light: 25,
};

class BarSelector extends StatelessWidget {
  const BarSelector({
    super.key,
    required this.selectedBarType,
    required this.onBarChange,
  });

  final BarType? selectedBarType;
  final void Function(BarType? newSelectedBarType) onBarChange;

  void _onButtonPressed(int index) {
    if (selectedBarType != null) {
      int selectedBarTypeIndex = BarType.values.indexOf(selectedBarType!);
      if (index == selectedBarTypeIndex) {
        onBarChange(null);
        return;
      }
    }

    BarType newSelectedBarType = BarType.values[index];
    onBarChange(newSelectedBarType);
  }

  @override
  Widget build(BuildContext context) {
    final toggleButtonState = List.filled(3, false);
    if (selectedBarType != null) {
      toggleButtonState[BarType.values.indexOf(selectedBarType!)] = true;
    }

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          ToggleButtons(
            isSelected: toggleButtonState,
            constraints: const BoxConstraints(minWidth: 100, minHeight: 40),
            borderRadius: BorderRadius.circular(8),
            onPressed: _onButtonPressed,
            children: const [
              Padding(
                padding: EdgeInsets.all(4),
                child: Text("EZ Bar (7.5kg)"),
              ),
              Padding(
                padding: EdgeInsets.all(4),
                child: Text("Standard Bar (20kg)"),
              ),
              Padding(
                padding: EdgeInsets.all(4),
                child: Text("Light Bar (15kg)"),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
