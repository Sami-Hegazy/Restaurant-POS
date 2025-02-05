import 'package:flutter/material.dart';
import 'package:restaurant_pos/generated/l10n.dart';
import 'menu_item.dart';
import 'logo.dart';
import 'package:go_router/go_router.dart';
import '../config/routes.dart';

class SideMenu extends StatelessWidget {
  final String currentPath;

  const SideMenu({
    super.key,
    required this.currentPath,
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
              menu: S.of(context).home,
              icon: Icons.rocket_sharp,
              isActive: currentPath == AppRoutes.home,
              onTap: () => context.go(AppRoutes.home),
            ),
            MenuItem(
              menu: S.of(context).menu,
              icon: Icons.format_list_bulleted_rounded,
              isActive: currentPath == AppRoutes.menu,
              onTap: () => context.go(AppRoutes.menu),
            ),
            MenuItem(
              menu: S.of(context).history,
              icon: Icons.history_toggle_off_rounded,
              isActive: currentPath == AppRoutes.history,
              onTap: () => context.go(AppRoutes.history),
            ),
            MenuItem(
              menu: S.of(context).promos,
              icon: Icons.discount_outlined,
              isActive: currentPath == AppRoutes.promos,
              onTap: () => context.go(AppRoutes.promos),
            ),
            MenuItem(
              menu: S.of(context).settings,
              icon: Icons.sports_soccer_outlined,
              isActive: currentPath == AppRoutes.settings,
              onTap: () => context.go(AppRoutes.settings),
            ),
          ],
        ),
      ),
    ]);
  }
}
