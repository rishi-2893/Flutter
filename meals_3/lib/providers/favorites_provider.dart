import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:meals/models/meal.dart';

// WHY AND WHEN TO USE StateNotifier?
// Use this when you want to maintain a state of a dynamic data structure
// Below we are managing the list of favorite meals
// In mealsProvider we did not use this because data was static
// Convention is to end the class name with "Notifier"
class FavoriteMealsNotifier extends StateNotifier<List<Meal>> {
  // Initializing constructor with some value
  // Can provide any data inside the super
  FavoriteMealsNotifier() : super([]);

  bool toggleMealFavoriteStatus(Meal meal) {
    final mealIsFavorite = state.contains(meal);

    if (mealIsFavorite) {
      // remove from the favorites
      // object "state" is provided by riverpod
      // "state" is the data you provided while initializing the class
      // You cannot simple perform state.add() or .remove() instead you have
      // to create a new list
      state = state.where((m) => m.id != meal.id).toList();
      return false;
    } else {
      // add to the favorites
      // We are doing this because we CANNOT EDIT list in place instead
      // we have to assign 'state' to a NEW LIST in the memory!
      state = [...state, meal];
      return true;
    }
  }
}

final favoriteMealsProvider =
    StateNotifierProvider<FavoriteMealsNotifier, List<Meal>>(
  (ref) {
    return FavoriteMealsNotifier();
  },
);
