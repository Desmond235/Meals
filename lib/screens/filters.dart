import 'package:flutter/material.dart';

import 'package:meal/providers/filters_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class FiltersScreen extends ConsumerWidget {
  const FiltersScreen({
    super.key,
  });

  Widget switchLisTile(
    String data,
    String text,
    bool setBool,
    void Function(bool) onChanged,
    BuildContext context,
  ) {
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
  Widget build(BuildContext context, WidgetRef ref) {
    final initialFilter = ref.watch(filtersProvider);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Filters'),
      ),
      body: Column(
        children: [
          switchLisTile(
            'Gluten-free',
            'Only include gluten-free meals. ',
            initialFilter[Filter.glutenFree]!,
            (isChecked) {
              ref
                  .read(filtersProvider.notifier)
                  .setFilter(Filter.glutenFree, isChecked);
            },
            context,
          ),
          switchLisTile(
            'Lactose-free',
            'Only include lactose-free meals. ',
            initialFilter[Filter.lactosFree]!,
            (isChecked) {
              ref
                  .read(filtersProvider.notifier)
                  .setFilter(Filter.lactosFree, isChecked);
            },
            context,
          ),
          switchLisTile(
            'Vegetarian-free',
            'Only include Vegetarian-free meals. ',
            initialFilter[Filter.vegetarianFree]!,
            (isChecked) {
              ref
                  .read(filtersProvider.notifier)
                  .setFilter(Filter.vegetarianFree, isChecked);
            },
            context,
          ),
          switchLisTile(
            'Vegan-free',
            'Only include Vegan-free meals. ',
            initialFilter[Filter.veganFree]!,
            (isChecked) {
              ref
                  .read(filtersProvider.notifier)
                  .setFilter(Filter.veganFree, isChecked);
            },
            context,
          )
        ],
      ),
    );
  }
}
