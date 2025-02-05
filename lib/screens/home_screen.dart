import 'package:flutter/material.dart';
import 'package:restaurant_pos/cubits/category/category_cubit.dart';
import '../widgets/menu_grid.dart';
import '../widgets/order_section.dart';
import '../widgets/category_tabs.dart';
import '../widgets/top_menu.dart';
import '../widgets/search_bar.dart';
import '../models/menu_item_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final bool isDesktop = constraints.maxWidth > 1200;
        final bool isTablet =
            constraints.maxWidth <= 1200 && constraints.maxWidth > 600;

        if (isDesktop) {
          return Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                flex: 14,
                child: _buildMainContent(),
              ),
              const Expanded(flex: 1, child: SizedBox()),
              const Expanded(
                flex: 5,
                child: OrderSection(),
              ),
            ],
          );
        } else if (isTablet) {
          return Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                flex: 3,
                child: _buildMainContent(),
              ),
              const Expanded(
                flex: 2,
                child: OrderSection(),
              ),
            ],
          );
        } else {
          // Mobile layout
          return Column(
            children: [
              Expanded(
                child: _buildMainContent(),
              ),
              Container(
                height: 50,
                color: Colors.deepOrangeAccent,
                child: Center(
                  child: TextButton.icon(
                    onPressed: () {
                      // Show order section in bottom sheet
                      showModalBottomSheet(
                        context: context,
                        builder: (context) => const OrderSection(),
                        isScrollControlled: true,
                      );
                    },
                    icon: const Icon(Icons.shopping_cart, color: Colors.white),
                    label: const Text(
                      'View Order',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              ),
            ],
          );
        }
      },
    );
  }

  Widget _buildMainContent() {
    return CustomScrollView(
      slivers: [
        SliverToBoxAdapter(
          child: Column(
            children: [
              TopMenu(
                title: 'Lorem Restaurant',
                subTitle: '20 October 2022',
                action: CustomSearchBar(
                  onChanged: (value) {
                    print(value);
                  },
                ),
              ),
              const SizedBox(height: 16),
              const CategoryTabs(),
            ],
          ),
        ),
        SliverPadding(
          padding: const EdgeInsets.all(10),
          sliver: Builder(
            builder: (context) {
              final selectedCategory = context.watch<CategoryCubit>().state;
              final filteredItems = menuItems
                  .where((item) => item.category == selectedCategory)
                  .toList();

              return SliverGrid(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: MediaQuery.of(context).size.width > 1200
                      ? 4
                      : MediaQuery.of(context).size.width > 800
                          ? 3
                          : MediaQuery.of(context).size.width > 600
                              ? 2
                              : 1,
                  childAspectRatio: 0.8,
                  mainAxisSpacing: 10,
                  crossAxisSpacing: 10,
                ),
                delegate: SliverChildBuilderDelegate(
                  (context, index) {
                    if (index >= filteredItems.length) return null;
                    final item = filteredItems[index];
                    return MenuGridItem(
                      image: item.image,
                      title: item.title,
                      price: item.price,
                      item: item.quantity,
                    );
                  },
                  childCount: filteredItems.length,
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
