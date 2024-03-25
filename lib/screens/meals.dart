import 'package:flutter/material.dart';
import 'package:meal/models/meal.dart';
import 'package:meal/screens/meal_details.dart';
import 'package:meal/widgets/meal_item.dart';

class MealScreen extends StatefulWidget {
  const MealScreen({
    super.key,
    this.title,
    required this.meals,
  });

  final String? title;
  final List<Meal> meals;

  @override
  State<MealScreen> createState() => _MealScreenState();
}

class _MealScreenState extends State<MealScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;
  late Animation<Offset> slideTransition;

  void selectMeal(BuildContext context, Meal meal) {
    Navigator.of(context).push(MaterialPageRoute(
      builder: (context) => MealDetailsScreen(meal: meal),
    ));
  }

  @override
  void initState() {
    super.initState();
    controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1500),
    );
    slideTransition = Tween(begin: const Offset(0, 0.3), end: Offset.zero)
        .animate(controller);
  }

  //  Slide transtion form meal screen to meal details screen
  @override
  Widget build(BuildContext context) {
    Widget content = ListView.builder(
        itemCount: widget.meals.length,
        itemBuilder: (context, index) {
          return SlideTransition(
            position: slideTransition,
            child: MealItem(
                meal: widget.meals[index],
                onSelectMeal: (meal) {
                  selectMeal(context, meal);
                }),
          );
        });
    if (widget.meals.isEmpty) {
      content = Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              "No meals here",
              style: Theme.of(context).textTheme.headlineLarge!.copyWith(
                    color: Theme.of(context).colorScheme.onBackground,
                  ),
            ),
            const SizedBox(
              height: 15,
            ),
            Text(
              "Try selecting a different category!",
              style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                    color: Theme.of(context).colorScheme.onBackground,
                  ),
            )
          ],
        ),
      );
    }

    if (widget.title == null) {
      return content;
    }
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.title!),
        ),
        body: content);
  }
}
