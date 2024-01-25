import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:meal/navigation_bar_color.dart';
import 'package:meal/providers/filters_provider.dart';

import 'package:meal/screens/categories.dart';
import 'package:meal/screens/filters.dart';
import 'package:meal/screens/meals.dart';
import 'package:meal/widgets/side_bar.dart';
import 'package:meal/providers/favorites_provider.dart';

class TabsScreen extends ConsumerStatefulWidget {
  const TabsScreen({super.key});

  @override
  ConsumerState<TabsScreen> createState() => _TabsScreenState();
}

class _TabsScreenState extends ConsumerState<TabsScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;
  late Animation<Offset> slideTransition;
  int _selectedPageIndex = 0;

  void _selectPage(int index) {
    setState(() {
      _selectedPageIndex = index;
    });
  }

  void _loadScreen(String identifier) async {
    Navigator.of(context).pop();
    if (identifier == 'filters') {
      await Navigator.of(context).push<Map<Filter, bool>>(
        MaterialPageRoute(builder: (context) => const FiltersScreen()),
      );
    }
  }

  @override
  void initState() {
    super.initState();
    controller = AnimationController(
      vsync: this,
      duration: const Duration(
        milliseconds: 1500,
      ),
    );

    slideTransition = Tween(
      begin: const Offset(0, 0.3),
      end: Offset.zero,
    ).animate(
      CurvedAnimation(parent: controller, curve: Curves.ease),
    );

    controller.forward();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final availableMeals = ref.watch(filteredMealsProvider);
    Widget activePage = CategoriesScreen(
      availableMeals: availableMeals,
    );
    var activePageTitle = 'Categories';

    if (_selectedPageIndex == 1) {
      final favoriteMeals = ref.watch(favoriteMealsProvider);
      activePage = AnimatedBuilder(
        animation: controller,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: MealScreen(
            meals: favoriteMeals,
          ),
        ),
        builder: (context, child) {
          return SlideTransition(
            position: slideTransition,
            child: child,
          );
        },
      );
      activePageTitle = 'Your Favorites';
    }
    return AnnotatedRegion(
      value: overlayStyle,
      child: Scaffold(
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
      ),
    );
  }
}
