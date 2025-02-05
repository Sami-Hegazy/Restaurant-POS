import 'package:flutter/material.dart';
import 'package:restaurant_pos/models/menu_item_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:restaurant_pos/cubits/menu/menu_cubit.dart';

class MenuGrid extends StatelessWidget {
  const MenuGrid({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MenuCubit, List<MenuItemModel>>(
      builder: (context, filteredItems) {
        return LayoutBuilder(
          builder: (context, constraints) {
            int columnCount;
            if (constraints.maxWidth > 1200) {
              columnCount = 4;
            } else if (constraints.maxWidth > 800) {
              columnCount = 3;
            } else if (constraints.maxWidth > 600) {
              columnCount = 2;
            } else {
              columnCount = 1;
            }

            return SliverGrid(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: columnCount,
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
        );
      },
    );
  }
}

class MenuGridItem extends StatelessWidget {
  final String image;
  final String title;
  final String price;
  final String item;

  const MenuGridItem({
    super.key,
    required this.image,
    required this.title,
    required this.price,
    required this.item,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(18),
        color: const Color(0xff1f2029),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                image: DecorationImage(
                  image: AssetImage(image),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 8, bottom: 4),
            child: Text(
              title,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 14,
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                price,
                style: const TextStyle(
                  color: Colors.deepOrange,
                  fontSize: 16,
                ),
              ),
              Text(
                item,
                style: const TextStyle(
                  color: Colors.white60,
                  fontSize: 12,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
