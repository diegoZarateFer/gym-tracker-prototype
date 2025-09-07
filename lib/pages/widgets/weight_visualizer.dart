import 'package:flutter/material.dart';

abstract class Plate {
  final double height;
  final double weightInKgs;
  final double weightInLbs;

  Plate({
    required this.height,
    required this.weightInKgs,
    required this.weightInLbs,
  });

  String get label;
  Paint get paint;
}

class Plate45 extends Plate {
  Plate45()
      : super(
          height: 150,
          weightInKgs: 20.4,
          weightInLbs: 45,
        );

  @override
  Paint get paint => Paint()
    ..color = Colors.red
    ..style = PaintingStyle.fill;

  @override
  String get label => "45";
}

class Plate35 extends Plate {
  Plate35()
      : super(
          height: 140,
          weightInKgs: 15.9,
          weightInLbs: 35,
        );

  @override
  Paint get paint => Paint()
    ..color = Colors.blue
    ..style = PaintingStyle.fill;

  @override
  String get label => "35";
}

class Plate25 extends Plate {
  Plate25()
      : super(
          height: 130,
          weightInKgs: 11.3,
          weightInLbs: 25,
        );

  @override
  Paint get paint => Paint()
    ..color = const Color.fromARGB(255, 155, 142, 30)
    ..style = PaintingStyle.fill;

  @override
  String get label => "25";
}

class Plate10 extends Plate {
  Plate10()
      : super(
          height: 120,
          weightInKgs: 4.5,
          weightInLbs: 10,
        );

  @override
  Paint get paint => Paint()
    ..color = Colors.green
    ..style = PaintingStyle.fill;

  @override
  String get label => "10";
}

class Plate5 extends Plate {
  Plate5()
      : super(
          height: 110,
          weightInKgs: 2.2,
          weightInLbs: 5,
        );

  @override
  Paint get paint => Paint()
    ..color = Colors.red
    ..style = PaintingStyle.fill;

  @override
  String get label => "5";
}

class Plate2Dot5 extends Plate {
  Plate2Dot5()
      : super(
          height: 105,
          weightInKgs: 1.13,
          weightInLbs: 2.5,
        );

  @override
  Paint get paint => Paint()
    ..color = Colors.blue
    ..style = PaintingStyle.fill;

  @override
  String get label => "2.5";
}

class WeightVisualizer extends StatelessWidget {
  const WeightVisualizer({
    super.key,
    required this.selectedPlates,
    required this.selectedBarWeight,
  });

  final Map<Plate, int> selectedPlates;
  final double selectedBarWeight;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200,
      child: Center(
        child: CustomPaint(
          size: const Size(250, 200),
          painter: BarPainter(selectedPlates, selectedBarWeight),
        ),
      ),
    );
  }
}

class BarPainter extends CustomPainter {
  final Map<Plate, int> selectedPlates;
  final double selectedBarWeight;

  BarPainter(this.selectedPlates, this.selectedBarWeight);

  @override
  void paint(Canvas canvas, Size size) {
    ///
    /// Definiendo los painters.
    ///

    /// Barra
    final barPaint = Paint()
      ..color = const Color.fromARGB(255, 99, 98, 98)
      ..style = PaintingStyle.fill;

    ///
    /// Definiendo rectangulo de la barra.
    ///

    const double barWidth = 200;
    const double barHeight = 20;

    final barPositionX = size.width / 2 - barWidth / 2;
    final barPositionY = size.height / 2;
    final barHandle =
        Rect.fromLTWH(barPositionX, barPositionY, barWidth, barHeight);

    ///
    /// Definir texto de la barra.
    ///
    final barTextPainter = TextPainter(
      text: TextSpan(
        text: "$selectedBarWeight",
        style: const TextStyle(
          fontSize: 12,
        ),
      ),
      textDirection: TextDirection.ltr,
    );

    barTextPainter.layout();

    final barTextPositionX = barPositionX + barTextPainter.width / 2;
    final barTextPositionY =
        barPositionY + barHeight / 2 - barTextPainter.height / 2;
    final barTextOffset = Offset(barTextPositionX, barTextPositionY);

    ///
    /// Definiendo posiciones y size del border de la barra.
    ///

    double barBorderPositionX = size.width / 2 + barWidth / 2;
    double borderWidth = 10;
    final barBorderRect =
        Rect.fromLTWH(barBorderPositionX, barPositionY, borderWidth, barHeight);
    const borderRadius = BorderRadius.only(
      topRight: Radius.circular(10),
      bottomRight: Radius.circular(10),
      bottomLeft: Radius.zero,
      topLeft: Radius.zero,
    );

    final barBorderRRect = RRect.fromRectAndCorners(
      barBorderRect,
      topLeft: borderRadius.topLeft,
      topRight: borderRadius.topRight,
      bottomLeft: borderRadius.bottomLeft,
      bottomRight: borderRadius.bottomRight,
    );

    ///
    /// Definiendo posiciones y size del tope de la barra.
    ///

    double barBumpWidth = 20;
    double barBumpHeight = barHeight + 15;

    double barBumpPositionX = barPositionX + barWidth / 2 - 80;
    double barBumpPositionY =
        (2 * barPositionY + barHeight - barBumpHeight) / 2;

    final barBumpRect = Rect.fromLTWH(
      barBumpPositionX,
      barBumpPositionY,
      barBumpWidth,
      barBumpHeight,
    );

    ///
    /// Dibujando los elementos.
    ///

    canvas.drawRect(barBumpRect, barPaint);

    canvas.drawRect(barHandle, barPaint);
    barTextPainter.paint(canvas, barTextOffset);

    canvas.drawRRect(barBorderRRect, barPaint);

    _drawSelectedPlatesRecs(
      canvas: canvas,
      barHeight: barHeight,
      barPositionY: barPositionY,
      initalPositionX: barBumpPositionX + barBumpWidth,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }

  void _drawSelectedPlatesRecs(
      {required Canvas canvas,
      required double barPositionY,
      required double barHeight,
      required double initalPositionX}) {
    const separationBetweenPlates = 1;
    const double plateWidth = 20;

    double platePositionX = initalPositionX;

    final plates = selectedPlates.keys.toList();
    plates.sort(
      (plateA, plateB) => plateB.weightInLbs.compareTo(plateA.weightInLbs),
    );

    for (final plate in plates) {
      final double platePositionY =
          (2 * barPositionY + barHeight - plate.height) / 2;

      for (var i = 0; i < selectedPlates[plate]!; i++) {
        ///
        /// Rectangulo para el disco.
        ///

        final plateRect = Rect.fromLTWH(
          platePositionX,
          platePositionY,
          plateWidth,
          plate.height,
        );

        const borderRadius = BorderRadius.all(Radius.circular(5));

        final barPlateRRect = RRect.fromRectAndCorners(
          plateRect,
          topLeft: borderRadius.topLeft,
          topRight: borderRadius.topRight,
          bottomLeft: borderRadius.bottomLeft,
          bottomRight: borderRadius.bottomRight,
        );

        ///
        /// Texto del rectanglulo.
        ///
        final plateTextPainter = TextPainter(
          text: TextSpan(
            text: plate.label,
            style: const TextStyle(
              fontSize: 12,
            ),
          ),
          textDirection: TextDirection.ltr,
        );

        plateTextPainter.layout();

        final plateTextPositionX =
            platePositionX + plateWidth / 2 - plateTextPainter.width / 2;
        final plateTextPositionY =
            platePositionY + plate.height / 2 - plateTextPainter.height / 2;
        final plateTextOffset = Offset(plateTextPositionX, plateTextPositionY);

        canvas.drawRRect(barPlateRRect, plate.paint);
        plateTextPainter.paint(canvas, plateTextOffset);

        platePositionX += plateWidth + separationBetweenPlates;
      }
    }
  }
}
