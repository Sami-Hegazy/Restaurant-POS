import 'package:flutter/material.dart';
import 'screens/home_screen.dart';
import 'widgets/side_menu.dart';
import 'widgets/logo.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'cubits/category/category_cubit.dart';
import 'cubits/menu/menu_cubit.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => CategoryCubit()),
        BlocProvider(create: (_) => MenuCubit()),
      ],
      child: MaterialApp(
        title: 'POS Food',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme: const ColorScheme.dark(
            primary: Colors.deepOrange,
            secondary: Colors.deepOrangeAccent,
            // surface: Color(0xff1f2029),
            surface: Color(0xff17181f),
          ),
          scaffoldBackgroundColor: const Color(0xff1f2029),
          useMaterial3: true,
        ),
        home: const MainPage(),
      ),
    );
  }
}

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  String pageActive = 'Home';

  Widget _pageView() {
    switch (pageActive) {
      case 'Home':
        return const HomeScreen();
      case 'Menu':
      case 'History':
      case 'Promos':
      case 'Settings':
        return const Center(child: Text('Coming Soon...'));
      default:
        return const HomeScreen();
    }
  }

  void _setPage(String page) {
    setState(() {
      pageActive = page;
    });
  }

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
                    pageActive: pageActive,
                    onPageChanged: _setPage,
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
                    child: _pageView(),
                  ),
                ),
              ],
            );
          } else {
            // Mobile layout
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
                    child: _pageView(),
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
            pageActive: pageActive,
            onPageChanged: (page) {
              _setPage(page);
              Navigator.pop(context);
            },
          ),
        ),
      ),
    );
  }
}
