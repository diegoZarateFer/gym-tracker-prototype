import 'package:flutter/cupertino.dart';

///
/// Lista para los minutos.
///
final _minutes = List.generate(
  61,
  (minute) => minute < 10 ? Text('0$minute') : Text('$minute'),
);

///
/// Lista para los segundos.
///
final _seconds = List.generate(
  61,
  (second) => second < 10 ? Text('0$second') : Text('$second'),
);

class RestTimeSelector extends StatelessWidget {
  const RestTimeSelector({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
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
      );
  }
}
