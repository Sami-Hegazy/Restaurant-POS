import 'package:flutter/material.dart';
import 'menu_item.dart';
import 'logo.dart';

class SideMenu extends StatelessWidget {
  final String pageActive;
  final Function(String) onPageChanged;

  const SideMenu({
    super.key,
    required this.pageActive,
    required this.onPageChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      const Logo(),
      const SizedBox(height: 20),
      Expanded(
        child: ListView(
          children: [
            MenuItem(
              menu: 'Home',
              icon: Icons.rocket_sharp,
              isActive: pageActive == 'Home',
              onTap: () => onPageChanged('Home'),
            ),
            MenuItem(
              menu: 'Menu',
              icon: Icons.format_list_bulleted_rounded,
              isActive: pageActive == 'Menu',
              onTap: () => onPageChanged('Menu'),
            ),
            MenuItem(
              menu: 'History',
              icon: Icons.history_toggle_off_rounded,
              isActive: pageActive == 'History',
              onTap: () => onPageChanged('History'),
            ),
            MenuItem(
              menu: 'Promos',
              icon: Icons.discount_outlined,
              isActive: pageActive == 'Promos',
              onTap: () => onPageChanged('Promos'),
            ),
            MenuItem(
              menu: 'Settings',
              icon: Icons.sports_soccer_outlined,
              isActive: pageActive == 'Settings',
              onTap: () => onPageChanged('Settings'),
            ),
          ],
        ),
      ),
    ]);
  }
}
