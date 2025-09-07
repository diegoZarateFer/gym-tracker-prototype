import 'package:flutter/material.dart';
import 'package:gym_tracker_ui/pages/widgets/regular_excercise_log.dart';
import 'package:gym_tracker_ui/pages/widgets/rir_excercise_log.dart';
import 'package:gym_tracker_ui/pages/widgets/rpe_excercise_log.dart';
import 'package:gym_tracker_ui/pages/widgets/subjective_excercise_log.dart';
import 'package:gym_tracker_ui/pages/widgets/week_calendar.dart';
import 'package:intl/intl.dart';

final formatter = DateFormat.yMd();

class RegisterWorkoutPage extends StatelessWidget {
  static const String route = "register-workout";

  const RegisterWorkoutPage({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Workout Name"),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(4),
            child: Container(
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.surface,
                borderRadius: BorderRadius.circular(12),
                boxShadow: const [
                  BoxShadow(
                    color: Colors.black12,
                    blurRadius: 4,
                    offset: Offset(0, 2),
                  ),
                ],
              ),
              child: Padding(
                padding: const EdgeInsets.all(4),
                child: Column(
                  children: [
                    const WeekCalendar(),
                    const SizedBox(height: 16),
                    ElevatedButton.icon(
                      onPressed: () {},
                      icon: const Icon(Icons.add),
                      label: const Text(
                        "Add Excercise",
                      ),
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 8,
                        ),
                        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      ),
                    ),
                    const SizedBox(height: 8),
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(height: 16),
          const Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  RIRExcerciseLog(),
                  SizedBox(height: 16),
                  RegularExcerciseLog(),
                  SizedBox(height: 16),
                  RPEExcerciseLog(),
                  SizedBox(height: 16),
                  SubjectiveExcerciseLog(),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}


//  CalendarWeek(
//             backgroundColor: Colors.transparent,
//             height: 150,
//             showMonth: false,
//             minDate: DateTime.now().add(const Duration(days: -365)),
//             maxDate: DateTime.now().add(const Duration(days: 365)),
//             monthViewBuilder: (DateTime time) => Align(
//               alignment: FractionalOffset.center,
//               child: Container(
//                 margin: const EdgeInsets.symmetric(
//                   vertical: 2,
//                 ),
//                 child: Text(
//                   formatter.format(time),
//                   overflow: TextOverflow.ellipsis,
//                   textAlign: TextAlign.center,
//                   style: const TextStyle(
//                     fontWeight: FontWeight.w600,
//                   ),
//                 ),
//               ),
//             ),
//             decorations: [
//               DecorationItem(
//                 decorationAlignment: FractionalOffset.bottomRight,
//                 date: DateTime.now(),
//                 decoration: const Icon(
//                   Icons.today,
//                   color: Colors.blue,
//                 ),
//               ),
//             ],
//           ),