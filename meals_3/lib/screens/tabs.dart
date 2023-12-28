import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:meals/providers/favorites_provider.dart';
import 'package:meals/providers/filters_provider.dart';
import 'package:meals/screens/categories.dart';
import 'package:meals/screens/meals.dart';
import 'package:meals/widgets/main_drawer.dart';
import 'package:meals/screens/filters.dart';

const kInitialFilters = {
  Filter.glutenFree: false,
  Filter.lactoseFree: false,
  Filter.vegetarian: false,
  Filter.vegan: false
};

// Change StatefulWidget to ConsumerStatefulWidget
class TabsScreen extends ConsumerStatefulWidget {
  const TabsScreen({super.key});

  @override
  ConsumerState<TabsScreen> createState() {
    return _TabsScreenState();
  }
}

class _TabsScreenState extends ConsumerState<TabsScreen> {
  // Initially CategoriesScreen is shown
  int _selectedPageIndex = 0;



  // When every user clicks on the BottomNavigationBar flutter automatically
  // passes the index of the item that was tapped
  void _selectPage(int index) {
    setState(() {
      _selectedPageIndex = index;
    });
  }


  void _setScreen(String identifier) async {
    if (identifier == 'filters') {
      Navigator.of(context).pop();
      // Map is assigned to "results" once user pops off filters screen
      await Navigator.of(context).push<Map<Filter, bool>>(
        MaterialPageRoute(
          builder: (ctx) => const FiltersScreen(),
        ),
      );
    } else {
      // simply close the drawer as you are already in tabScreen
      Navigator.of(context).pop();
    }
  }

  @override
  // Build is called every time an item on BottomNavigationBar is tapped
  Widget build(BuildContext context) {
    // Similar to 'widget' in a StatefulWidget, in ConsumerStatefulWidget
    // we have 'ref' object available
    // .watch() returns the value by a provider and rebuild the widget
    // when that value changes
    // This sets up a listener which re-executes this build method whenever
    // the mealsProvider should change
    final availableMeals = ref.watch(filteredMealsProvider);

    Widget activePage = CategoriesScreen(
      availableMeals: availableMeals,
    );
    var activePageTitle = 'Categories';

    if (_selectedPageIndex == 1) {
      final favoriteMeals = ref.watch(favoriteMealsProvider);
      activePage = MealsScreen(
        meals: favoriteMeals,
      );
      activePageTitle = 'Your Favorites';
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(activePageTitle),
      ),
      drawer: MainDrawer(onSelectScreen: _setScreen),
      body: activePage,
      bottomNavigationBar: BottomNavigationBar(
        onTap: _selectPage,
        // currentIndex  (at the bottom) is highlighted
        currentIndex: _selectedPageIndex,
        // items contains the of tabs
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.set_meal),
            label: 'Categories',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.star),
            label: 'Favorites',
          ),
        ],
      ),
    );
  }
}