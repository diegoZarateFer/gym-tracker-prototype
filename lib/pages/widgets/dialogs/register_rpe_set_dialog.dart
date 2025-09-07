import 'package:flutter/material.dart';
import 'package:gym_tracker_ui/core/extensions/context_ext.dart';
import 'package:gym_tracker_ui/pages/widgets/dialogs/plate_calculator.dart';
import 'package:gym_tracker_ui/pages/widgets/modal_bottom_handle.dart';

class RegisterRPESet extends StatefulWidget {
  const RegisterRPESet({super.key});

  @override
  State<RegisterRPESet> createState() => _RegisterRPESetState();
}

class _RegisterRPESetState extends State<RegisterRPESet> {
  int _selectedRPEValue = 8;

  /// Focus de la UI.
  ///
  final FocusNode _firstFocus = FocusNode();
  final FocusNode _secondFocus = FocusNode();

  ///
  /// Controllers.
  ///
  final _weightController = TextEditingController();

  void _setRPEValue(double newRPEValue) {
    setState(() {
      _selectedRPEValue = newRPEValue.toInt();
    });
  }

  @override
  void dispose() {
    _firstFocus.dispose();
    _secondFocus.dispose();

    super.dispose();
  }

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
                    "Register Your Set",
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
              const SizedBox(
                height: 16,
              ),
              Row(
                children: [
                  const Spacer(),
                  SizedBox(
                    width: 80,
                    child: TextField(
                      controller: _weightController,
                      textAlignVertical: TextAlignVertical.center,
                      focusNode: _firstFocus,
                      keyboardType: const TextInputType.numberWithOptions(),
                      textInputAction: TextInputAction.next,
                      onSubmitted: (_) {
                        FocusScope.of(context).requestFocus(_secondFocus);
                      },
                      textAlign: TextAlign.center,
                      maxLength: 5,
                      maxLines: 1,
                      decoration: const InputDecoration(
                        counterText: "",
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 8,
                  ),
                  const Text(
                    "units",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                  const SizedBox(
                    width: 8,
                  ),
                  const Text(
                    "x",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                  const SizedBox(
                    width: 8,
                  ),
                  Expanded(
                    child: TextField(
                      textAlignVertical: TextAlignVertical.center,
                      textInputAction: TextInputAction.done,
                      focusNode: _secondFocus,
                      onSubmitted: (_) {
                        FocusScope.of(context).unfocus();
                      },
                      keyboardType: const TextInputType.numberWithOptions(),
                      textAlign: TextAlign.center,
                      maxLength: 5,
                      maxLines: 1,
                      decoration: const InputDecoration(
                        counterText: "",
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 8,
                  ),
                  Text(
                    "@ $_selectedRPEValue",
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                  const Spacer(),
                ],
              ),
              const SizedBox(height: 16),
              const Text(
                "RPE",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
              const SizedBox(height: 4),
              Slider(
                thumbColor: Colors.white,
                value: _selectedRPEValue.toDouble(),
                min: 1,
                max: 10,
                onChanged: _setRPEValue,
              ),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.max,
                children: [
                  Expanded(
                    child: ElevatedButton.icon(
                      onPressed: () {},
                      icon: const Icon(Icons.videocam),
                      label: const Text("Record"),
                      style: ElevatedButton.styleFrom(
                        backgroundColor:
                            Theme.of(context).colorScheme.onBackground,
                        foregroundColor:
                            Theme.of(context).colorScheme.background,
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: ElevatedButton.icon(
                      onPressed: () async {
                        final weight = await context
                            .showModalDialog<double?>(const PlateCalculator());

                        if (weight != null) {
                          _weightController.text = weight.toString();
                        }
                      },
                      icon: const Icon(Icons.calculate),
                      label: const Text("Calculator"),
                      style: ElevatedButton.styleFrom(
                        backgroundColor:
                            Theme.of(context).colorScheme.onBackground,
                        foregroundColor:
                            Theme.of(context).colorScheme.background,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton.icon(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  icon: const Icon(Icons.check),
                  label: const Text("Done"),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
