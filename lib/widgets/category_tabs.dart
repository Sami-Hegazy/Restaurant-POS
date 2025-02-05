import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'dart:ui';
import '../cubits/category/category_cubit.dart';
import '../cubits/menu/menu_cubit.dart';

class CategoryTabs extends StatelessWidget {
  const CategoryTabs({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CategoryCubit, String>(
      builder: (context, selectedCategory) {
        return DefaultTabController(
          length: categories.length,
          child: ScrollConfiguration(
            behavior: ScrollConfiguration.of(context).copyWith(
              dragDevices: {
                PointerDeviceKind.touch,
                PointerDeviceKind.mouse,
              },
            ),
            child: TabBar(
              isScrollable: true,
              tabAlignment: TabAlignment.start,
              dividerColor: Colors.transparent,
              indicatorSize: TabBarIndicatorSize.tab,
              indicatorPadding: const EdgeInsets.all(4),
              labelPadding: const EdgeInsets.symmetric(horizontal: 8),
              padding: const EdgeInsets.symmetric(horizontal: 8),
              indicator: BoxDecoration(
                border: Border.all(color: Colors.deepOrangeAccent),
                borderRadius: BorderRadius.circular(12),
              ),
              tabs: categories.map((category) {
                return Tab(
                  height: 60,
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Row(
                      children: [
                        Image.asset(
                          category.icon,
                          width: 24,
                          height: 24,
                        ),
                        const SizedBox(width: 8),
                        Text(category.title),
                      ],
                    ),
                  ),
                );
              }).toList(),
              onTap: (index) {
                final category = categories[index].title;
                context.read<CategoryCubit>().changeCategory(category);
                context.read<MenuCubit>().filterByCategory(category);
              },
            ),
          ),
        );
      },
    );
  }
}

final List<CategoryItem> categories = [
  const CategoryItem(icon: 'assets/icons/icon-burger.png', title: 'Burger'),
  const CategoryItem(icon: 'assets/icons/icon-noodles.png', title: 'Noodles'),
  const CategoryItem(icon: 'assets/icons/icon-drinks.png', title: 'Drinks'),
  const CategoryItem(icon: 'assets/icons/icon-desserts.png', title: 'Desserts'),
];

class CategoryItem {
  final String icon;
  final String title;

  const CategoryItem({
    required this.icon,
    required this.title,
  });
}
