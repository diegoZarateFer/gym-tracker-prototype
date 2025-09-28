import 'package:alarm/alarm.dart';
import 'package:flutter/material.dart';
import 'package:gym_tracker_ui/core/services/permissions.dart';
import 'package:gym_tracker_ui/core/theme/app_theme.dart';
import 'package:gym_tracker_ui/pages/create_workout_page.dart';
import 'package:gym_tracker_ui/pages/excercise_calendar_page.dart';
import 'package:gym_tracker_ui/pages/excercise_history_page.dart';
import 'package:gym_tracker_ui/pages/excercise_settings_page.dart';
import 'package:gym_tracker_ui/pages/choose_excercise_page.dart';
import 'package:gym_tracker_ui/pages/excercise_stats_page.dart';
import 'package:gym_tracker_ui/pages/register_workout_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  ///
  /// Inicializando el gestor de alarmas.
  ///

  await Alarm.init();

  ///
  /// Pedir permisos para notificaciones.
  ///
  AlarmPermissions.checkNotificationPermission().then(
    (_) => AlarmPermissions.checkAndroidScheduleExactAlarmPermission(),
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: appDarkTheme,
      home: const CreateWorkoutPage(),
      routes: {
        RegisterWorkoutPage.route: (context) => const RegisterWorkoutPage(),
        ExcerciseSettingsPage.route: (context) => const ExcerciseSettingsPage(),
        ExcerciseHistoryPage.route: (context) => const ExcerciseHistoryPage(),
        ExcerciseCalendarPage.route: (context) => const ExcerciseCalendarPage(),
        ChooseExcercisePage.route: (context) => const ChooseExcercisePage(),
        ExcerciseStatsPage.route: (context) => const ExcerciseStatsPage(),
        CreateWorkoutPage.route: (context) => const CreateWorkoutPage(),
      },
    );
  }
}
