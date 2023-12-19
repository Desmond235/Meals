import 'package:flutter/material.dart';
// import 'package:meal/screens/tabs.dart';
// import 'package:meal/widgets/side_bar.dart';

enum Filter {
  glutenFree,
  lactosFree,
  vegetarianFree,
  veganFree,
}

class FiltersScreen extends StatefulWidget {
  const FiltersScreen({
    super.key,
    required this.currentFilters,
  });

  final Map<Filter, bool> currentFilters;
  @override
  State<FiltersScreen> createState() => _FiltersScreenState();
}

class _FiltersScreenState extends State<FiltersScreen> {
  var _glutenFree = false;
  var _lactosFree = false;
  var _vegetarianFree = false;
  var _veganFree = false;

// Assigns and saves the filters chosen by the user
  @override
  void initState() {
    super.initState();
    _glutenFree = widget.currentFilters[Filter.glutenFree]!;
    _lactosFree = widget.currentFilters[Filter.lactosFree]!;
    _vegetarianFree = widget.currentFilters[Filter.vegetarianFree]!;
    _veganFree = widget.currentFilters[Filter.veganFree]!;
  }

  Widget switchLisTile(
      String data, String text, bool setBool, void Function(bool) onChanged) {
    return SwitchListTile(
      value: setBool,
      onChanged: onChanged,
      title: Text(
        data,
        style: Theme.of(context)
            .textTheme
            .titleLarge!
            .copyWith(color: Theme.of(context).colorScheme.onBackground),
      ),
      subtitle: Text(
        text,
        style: Theme.of(context)
            .textTheme
            .labelMedium!
            .copyWith(color: Theme.of(context).colorScheme.onBackground),
      ),
      activeColor: Theme.of(context).colorScheme.tertiary,
      contentPadding: const EdgeInsets.only(left: 34, right: 22),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Filters'),
      ),
      // drawer: SideBar(selectedScreen: (identifier) {
      //   Navigator.of(context).pop();
      //   if (identifier == 'meals') {
      //     Navigator.of(context).pushReplacement(
      //       MaterialPageRoute(
      //         builder: (context) => const TabsScreen(),
      //       ),
      //     );
      //   }
      // }),
      body: PopScope(
        onPopInvoked: (didPop) => {
          Navigator.of(context).pop({
            Filter.glutenFree: _glutenFree,
            Filter.lactosFree: _lactosFree,
            Filter.vegetarianFree: _vegetarianFree,
            Filter.veganFree: _veganFree
          })
        },
        child: Column(
          children: [
            switchLisTile(
              'Gluten-free',
              'Only include gluten-free meals. ',
              _glutenFree,
              (isSwitched) {
                setState(() {
                  _glutenFree = isSwitched;
                });
              },
            ),
            switchLisTile(
              'Lactose-free',
              'Only include lactose-free meals. ',
              _lactosFree,
              (isSwitched) {
                setState(() {
                  _lactosFree = isSwitched;
                });
              },
            ),
            switchLisTile(
              'Vegetarian-free',
              'Only include Vegetarian-free meals. ',
              _vegetarianFree,
              (isSwitched) {
                setState(() {
                  _vegetarianFree = isSwitched;
                });
              },
            ),
            switchLisTile(
              'Vegan-free',
              'Only include Vegan-free meals. ',
              _veganFree,
              (isSwitched) {
                setState(() {
                  _veganFree = isSwitched;
                });
              },
            )
          ],
        ),
      ),
    );
  }
}
