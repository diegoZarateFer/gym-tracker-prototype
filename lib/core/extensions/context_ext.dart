import 'package:flutter/material.dart';

extension ContextExt on BuildContext {
  ThemeData get theme => Theme.of(this);

  MediaQueryData get mediaQuery => MediaQuery.of(this);

  Size get size => mediaQuery.size;

  double get width => size.width;
  double get height => size.height;
  double get keyBoardSpace => mediaQuery.viewInsets.bottom + 50;

  void showScaffoldMessage(
    String message, {
    int duration = 3,
    SnackBarAction? action,
  }) {
    ScaffoldMessenger.of(this).clearSnackBars();
    ScaffoldMessenger.of(this).showSnackBar(
      SnackBar(
        content: Text(
          message,
          style: TextStyle(color: Theme.of(this).colorScheme.onSurface),
        ),
        duration: Duration(seconds: duration),
        backgroundColor: Theme.of(this).colorScheme.surface,
        action: action,
      ),
    );
  }

  Future<T?> showBottomDialog<T>(Widget content) async {
    return await showModalBottomSheet<T>(
      context: this,
      useSafeArea: true,
      isScrollControlled: true,
      builder: (BuildContext modalContext) {
        return Padding(padding: const EdgeInsets.all(8), child: content);
      },
    );
  }

  Future<T?> showModalDialog<T>(Widget dialog) async {
    return await showDialog<T>(
      context: this,
      builder: (BuildContext dialogContext) {
        return dialog;
      },
    );
  }

  Future<T?> pushWithSlide<T>(Widget screen) {
    return Navigator.push<T>(
      this,
      PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) => screen,
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          const begin = Offset(1.0, 0.0);
          const end = Offset.zero;
          const curve = Curves.ease;

          var tween = Tween(
            begin: begin,
            end: end,
          ).chain(CurveTween(curve: curve));
          var offsetAnimation = animation.drive(tween);

          return SlideTransition(position: offsetAnimation, child: child);
        },
      ),
    );
  }
}
