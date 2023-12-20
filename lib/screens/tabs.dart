import 'package:flutter/material.dart';
import 'package:meal/data/dummy_data.dart';
import 'package:meal/models/meal.dart';
import 'package:meal/screens/categories.dart';
import 'package:meal/screens/filters.dart';
import 'package:meal/screens/meals.dart';
import 'package:meal/widgets/side_bar.dart';

// global variable for filtered meals
const kInitialFilters = {
  Filter.glutenFree: false,
  Filter.lactosFree: false,
  Filter.vegetarianFree: false,
  Filter.veganFree: false
};

class TabsScreen extends StatefulWidget {
  const TabsScreen({super.key});

  @override
  State<TabsScreen> createState() => _TabsScreenState();
}

class _TabsScreenState extends State<TabsScreen> {
  int _selectedPageIndex = 0;
  final List<Meal> _favoriteMeals = [];

  // variable for filtered meals
  Map<Filter, bool> _selectedFilters = kInitialFilters;

// indicates whether a user has added a meal to favoriete or removed a meal from favorite
  void _showInfoMessage(String message) {
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(message),
    ));
  }

  void _toogleFavoriteMeal(Meal meal) {
    setState(() {
      final isExisting = _favoriteMeals.contains(meal);
      if (isExisting) {
        setState(() {
          _favoriteMeals.remove(meal);
          _showInfoMessage('Meal is removed from favorite');
        });
      } else {
        setState(() {
          _favoriteMeals.add(meal);
          _showInfoMessage("Meal added to favorite");
        });
      }
    });
  }

  void _selectPage(int index) {
    setState(() {
      _selectedPageIndex = index;
    });
  }

  void _loadScreen(String identifier) async {
    Navigator.of(context).pop();
    if (identifier == 'filters') {
      final result = await Navigator.of(context).push<Map<Filter, bool>>(
        MaterialPageRoute(
         builder: (context) => FiltersScreen(currentFilters: _selectedFilters)
        ),
      );
      // When the user chooses a filter
      // the category screen will be updated according to
      //  to the filter
      setState(() {
        _selectedFilters = result ?? kInitialFilters;
      });
    }
  }

  @override
  Widget build(BuildContext context) {

    // if the user selects a filter from the filter screen
    // and the meal does not match the filter it will not be displayed
    // also if there is a particular category that does match the filter,
    // it will not be displayed in the category screen
    final availableMeals = dummyMeals.where((meal) {
      if (_selectedFilters[Filter.glutenFree]! && !meal.isGlutenFree) {
        return false;
      }
      if (_selectedFilters[Filter.lactosFree]! && !meal.isLactoseFree) {
        return false;
      }
      if (_selectedFilters[Filter.vegetarianFree]! && !meal.isVegetarian) {
        return false;
      }
      if (_selectedFilters[Filter.veganFree]! && !meal.isVegan) {
        return false;
      }
      return true;
    }).toList();
    Widget activePage = CategoriesScreen(
      onToggleFavorite: _toogleFavoriteMeal,
      availableMeals: availableMeals,
    );
    var activePageTitle = 'Categories';

    if (_selectedPageIndex == 1) {
      activePage = MealScreen(
        meals: _favoriteMeals,
        onToggleFavorite: _toogleFavoriteMeal,
      );
      activePageTitle = 'Your Favorites';
    }
    return Scaffold(
      appBar: AppBar(
        title: Text(activePageTitle),
      ),
      drawer: SideBar(
        selectedScreen: _loadScreen,
      ),
      body: activePage,
      bottomNavigationBar: BottomNavigationBar(
        onTap: _selectPage,
        currentIndex: _selectedPageIndex,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.set_meal),
            label: 'Category',
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
