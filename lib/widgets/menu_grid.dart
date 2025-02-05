import 'package:flutter/material.dart';
import 'package:restaurant_pos/generated/l10n.dart';
import 'package:restaurant_pos/models/menu_item_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:restaurant_pos/cubits/menu/menu_cubit.dart';
import 'package:restaurant_pos/cubits/order/order_cubit.dart';

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
                    menuItem: item,
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
  final MenuItemModel menuItem;

  const MenuGridItem({
    super.key,
    required this.image,
    required this.title,
    required this.price,
    required this.item,
    required this.menuItem,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        context.read<OrderCubit>().addItem(menuItem);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            behavior: SnackBarBehavior.floating,
            width: 500,
            backgroundColor: Colors.deepOrangeAccent,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            content: Row(
              children: [
                const Icon(
                  Icons.shopping_cart_checkout,
                  color: Colors.white,
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Text(
                    S.of(context).addedToOrder(title),
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                  ),
                ),
              ],
            ),
            duration: const Duration(seconds: 1),
            action: SnackBarAction(
              label: S.of(context).undo,
              textColor: Colors.white,
              onPressed: () {
                context.read<OrderCubit>().removeItem(menuItem.id!);
              },
            ),
          ),
        );
      },
      child: Container(
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
      ),
    );
  }
}
