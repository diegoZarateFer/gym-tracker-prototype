import 'package:flutter/material.dart';
import 'package:gym_tracker_ui/pages/widgets/excercise_charts/last_year_chart.dart';
import 'package:intl/intl.dart';

final List<int> dummyDays = [1, 4, 8, 11, 14, 16, 19];

final formatter = DateFormat.yMd();

class ExcerciseStatsPage extends StatefulWidget {
  static const String route = "/excercise-stats";

  const ExcerciseStatsPage({super.key});

  @override
  State<ExcerciseStatsPage> createState() => _ExcerciseStatsPageState();
}

class _ExcerciseStatsPageState extends State<ExcerciseStatsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.background,
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        title: const Text("Excercise Name"),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: Column(children: [LastYearChart()]),
        ),
      ),
    );
  }
}
