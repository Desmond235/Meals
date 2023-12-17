import 'package:flutter/material.dart';

class SideBar extends StatelessWidget {
  const SideBar({super.key});

  Widget sideBarItems(BuildContext context, IconData icon, double size,
      Color color, String data, TextStyle style, void Function() onTap) {
    return ListTile(
      leading: Icon(icon, size: size, color: color),
      title: Text(data, style: style),
      onTap: onTap,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          DrawerHeader(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
                gradient: LinearGradient(
              colors: [
                Theme.of(context).colorScheme.primaryContainer,
                Theme.of(context).colorScheme.primaryContainer.withOpacity(0.7),
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            )),
            child: Row(
              children: [
                Icon(
                  Icons.fastfood,
                  size: 48,
                  color: Theme.of(context).colorScheme.primary,
                ),
                const SizedBox(),
                Text(
                  'Cooking up',
                  style: Theme.of(context)
                      .textTheme
                      .titleLarge!
                      .copyWith(color: Theme.of(context).colorScheme.primary),
                ),
              ],
            ),
          ),
          sideBarItems(
            context,
            Icons.restaurant,
            26,
            Theme.of(context).colorScheme.onBackground,
            'Meals',
            Theme.of(context)
                .textTheme
                .titleSmall!
                .copyWith(color: Theme.of(context).colorScheme.onBackground),
            () {},
          ),
          sideBarItems(
            context,
            Icons.settings,
            26,
            Theme.of(context).colorScheme.onBackground,
            'Filters',
            Theme.of(context)
                .textTheme
                .titleSmall!
                .copyWith(color: Theme.of(context).colorScheme.onBackground),
            () {},
          )
        ],
      ),
    );
  }
}
