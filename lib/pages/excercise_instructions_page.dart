import 'package:flutter/material.dart';
import 'package:gym_tracker_ui/domain/entitites/excercise_blueprint.dart';
import 'package:gym_tracker_ui/pages/widgets/category_excercises_list.dart';

class ExcercisesInstructionsPage extends StatefulWidget {
  static const String route = "/excercise-blueprints";

  const ExcercisesInstructionsPage({
    super.key,
  });

  @override
  State<ExcercisesInstructionsPage> createState() => _ExcerciseCalendarPageState();
}

class _ExcerciseCalendarPageState extends State<ExcercisesInstructionsPage> {
  /// Funciones para los widgets.
  ///
  void _showCategoryScreen(ExcerciseCategory category, String categoryTitle) {
    Navigator.of(context).push(
      PageRouteBuilder(
        pageBuilder: (ctx, animatin, secondaryAnimation) =>
            CategoryExcercisesList(
          category: category,
          categoryTitle: categoryTitle,
        ),
        transitionsBuilder: (ctx, animation, secondaryAnimation, child) {
          const begin = Offset(1.0, 0.0);
          const end = Offset.zero;
          const curve = Curves.ease;

          final tween =
              Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

          return SlideTransition(
            position: animation.drive(tween),
            child: child,
          );
        },
      ),
    );
  }

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
        title: const Text("Excercise Categories"),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const SizedBox(height: 16),
              Container(
                decoration: BoxDecoration(
                  color: Theme.of(context).inputDecorationTheme.fillColor,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Column(
                  children: [
                    GestureDetector(
                      onTap: () {
                        _showCategoryScreen(ExcerciseCategory.chest, "Chest");
                      },
                      child: const ListTile(
                        title: Text("Chest"),
                        trailing: Icon(
                          Icons.arrow_forward_ios,
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        _showCategoryScreen(ExcerciseCategory.back, "Back");
                      },
                      child: const ListTile(
                        title: Text("Back"),
                        trailing: Icon(
                          Icons.arrow_forward_ios,
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        _showCategoryScreen(ExcerciseCategory.arms, "Arms");
                      },
                      child: const ListTile(
                        title: Text("Arms"),
                        trailing: Icon(
                          Icons.arrow_forward_ios,
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        _showCategoryScreen(ExcerciseCategory.shoulders, "Shoulders");
                      },
                      child: const ListTile(
                        title: Text("Shoulders"),
                        trailing: Icon(
                          Icons.arrow_forward_ios,
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        _showCategoryScreen(ExcerciseCategory.quads, "Quads");
                      },
                      child: const ListTile(
                        title: Text("Quads"),
                        trailing: Icon(
                          Icons.arrow_forward_ios,
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        _showCategoryScreen(ExcerciseCategory.hamstrings,"Hamstrings");
                      },
                      child: const ListTile(
                        title: Text("Hamstrings"),
                        trailing: Icon(
                          Icons.arrow_forward_ios,
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        _showCategoryScreen(ExcerciseCategory.glutes,"Glutes");
                      },
                      child: const ListTile(
                        title: Text("Glutes"),
                        trailing: Icon(
                          Icons.arrow_forward_ios,
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        _showCategoryScreen(ExcerciseCategory.calves,"Calves");
                      },
                      child: const ListTile(
                        title: Text("Calves"),
                        trailing: Icon(
                          Icons.arrow_forward_ios,
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        _showCategoryScreen(ExcerciseCategory.abs,"Abs");
                      },
                      child: const ListTile(
                        title: Text("Abs"),
                        trailing: Icon(
                          Icons.arrow_forward_ios,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
