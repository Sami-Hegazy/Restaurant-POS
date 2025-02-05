import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../screens/home_screen.dart';
import '../screens/history_screen.dart';
import '../screens/settings_screen.dart';
import '../widgets/side_menu.dart';
import '../widgets/logo.dart';
import 'routes.dart';

final router = GoRouter(
  initialLocation: AppRoutes.home,
  routes: [
    ShellRoute(
      builder: (context, state, child) {
        return MainScaffold(child: child);
      },
      routes: [
        GoRoute(
          path: AppRoutes.home,
          name: 'home',
          builder: (context, state) => const HomeScreen(),
        ),
        GoRoute(
          path: AppRoutes.history,
          name: 'history',
          builder: (context, state) => const HistoryScreen(),
        ),
        GoRoute(
          path: AppRoutes.menu,
          name: 'menu',
          builder: (context, state) =>
              const Center(child: Text('Coming Soon...')),
        ),
        GoRoute(
          path: AppRoutes.promos,
          name: 'promos',
          builder: (context, state) =>
              const Center(child: Text('Coming Soon...')),
        ),
        GoRoute(
          path: AppRoutes.settings,
          name: 'settings',
          builder: (context, state) => const SettingsScreen(),
        ),
      ],
    ),
  ],
);

class MainScaffold extends StatelessWidget {
  final Widget child;

  const MainScaffold({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LayoutBuilder(
        builder: (context, constraints) {
          final bool isDesktop = constraints.maxWidth > 1200;
          final bool isTablet =
              constraints.maxWidth <= 1200 && constraints.maxWidth > 600;

          if (isDesktop || isTablet) {
            return Row(
              children: [
                Container(
                  width: isDesktop ? 70 : 60,
                  padding: const EdgeInsets.only(top: 24, right: 12, left: 12),
                  height: MediaQuery.of(context).size.height,
                  child: SideMenu(
                    currentPath: GoRouterState.of(context).matchedLocation,
                  ),
                ),
                Expanded(
                  child: Container(
                    margin: const EdgeInsets.only(top: 24, right: 12),
                    padding:
                        const EdgeInsets.only(top: 12, right: 12, left: 12),
                    decoration: BoxDecoration(
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(12),
                        topRight: Radius.circular(12),
                      ),
                      color: Theme.of(context).colorScheme.surface,
                    ),
                    child: child,
                  ),
                ),
              ],
            );
          } else {
            return Column(
              children: [
                Container(
                  height: 60,
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  child: Row(
                    children: [
                      const Logo(),
                      const Spacer(),
                      IconButton(
                        icon: const Icon(Icons.menu, color: Colors.white),
                        onPressed: () {
                          Scaffold.of(context).openDrawer();
                        },
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.surface,
                    ),
                    child: child,
                  ),
                ),
              ],
            );
          }
        },
      ),
      drawer: Drawer(
        child: Container(
          color: Theme.of(context).scaffoldBackgroundColor,
          child: SideMenu(
            currentPath: GoRouterState.of(context).matchedLocation,
          ),
        ),
      ),
    );
  }
}
