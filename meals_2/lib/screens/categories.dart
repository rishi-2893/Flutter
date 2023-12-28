import 'package:meals/models/category.dart';
import 'package:flutter/material.dart';
import 'package:meals/data/dummy_data.dart';
import 'package:meals/screens/meals.dart';
import 'package:meals/widgets/category_grid_item.dart';
import 'package:meals/models/meal.dart';

// Converting to StatefulWidget as we want ANIMATIONS!
class CategoriesScreen extends StatefulWidget {
  CategoriesScreen({
    super.key,
    required this.availableMeals,
  });

  final List<Meal> availableMeals;

  @override
  State<CategoriesScreen> createState() => _CategoriesScreenState();
}

// We use multiple inheritance ("with") to use Animations
class _CategoriesScreenState extends State<CategoriesScreen>
    with SingleTickerProviderStateMixin {
  // late keyword is used to declare a non-nullable variable that is
  // initially uninitialized. It tells the Dart analyzer that the variable
  // will be assigned a value before it is accessed
  late AnimationController _animationController;

  // As animation controller must be set before the build method executes
  // we put it inside initState()
  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      // animation controller will start from 0 (at 0 ms)
      // and end with a value of 1 at 300th millisecond
      duration: const Duration(milliseconds: 300),
      lowerBound: 0,
      upperBound: 1,
    );

    _animationController.forward();
  }

  @override
  void dispose() {
    // makes sure that animation widget is removed once popped
    _animationController.dispose();
    super.dispose();
  }

  // Screen stack
  void _selectCategory(BuildContext context, Category category) {
    final filteredMeals = widget.availableMeals
        .where(
          (meal) => meal.categories.contains(category.id),
        )
        .toList();

    // Pushing MealsScreen to the top
    Navigator.of(context).push(MaterialPageRoute(
      builder: (ctx) => MealsScreen(
        title: category.title,
        meals: filteredMeals,
      ),
    ));
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
        // _animationController tells AnimatedBuilder when it should call
        // the builder function
        animation: _animationController,
        // child includes all the widgets which should be output as part of the
        // animated widget but that should not be animated themselves
        // this helps to improve performance by not re-building all the
        // widgets as long as animation is running
        child: GridView(
          padding: const EdgeInsets.all(24),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            // main axis is top to bottom
            crossAxisCount: 2, // two columns
            childAspectRatio: 1.5,
            crossAxisSpacing: 20,
            mainAxisSpacing: 20,
          ),
          children: [
            for (final category in availableCategories)
              CategoryGridItem(
                category: category,
                onSelectCategory: () {
                  _selectCategory(context, category);
                },
              )
          ],
        ),
        // Called every time animation changes value
        // The function passed to builder is called every tick of our animation
        // ex: for 60 fps, it calls the function for every frame i.e., 60/sec
        // the GridView will not be re-evaluated 60 times per second
        // only padding widget will be re-evaluated that often
        builder: (context, child) => Padding(
              padding: EdgeInsets.only(
                top: 100 - _animationController.value * 100,
              ),
              child: child,
            ));
  }
}
