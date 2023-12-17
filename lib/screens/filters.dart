import 'package:flutter/material.dart';
// import 'package:meal/screens/tabs.dart';
// import 'package:meal/widgets/side_bar.dart';

class FiltersScreen extends StatefulWidget {
  const FiltersScreen({super.key});

  @override
  State<FiltersScreen> createState() => _FiltersScreenState();
}

class _FiltersScreenState extends State<FiltersScreen> {
 
  var _glutenFree = false;
  var _lactoseFree = false;
  var _vegetarianFree = false;
  var _veganFree = false;

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
      body: Column(
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
            _lactoseFree,
            (isSwitched) {
              setState(() {
                _lactoseFree = isSwitched;
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
    );
  }
}
