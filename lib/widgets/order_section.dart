import 'package:flutter/material.dart';
import 'package:restaurant_pos/generated/l10n.dart';
import 'order_item.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../cubits/order/order_cubit.dart';
import '../models/order_model.dart';
import '../widgets/customer_info_dialog.dart';

class OrderSection extends StatelessWidget {
  const OrderSection({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<OrderCubit, OrderState>(
      builder: (context, state) {
        return Column(
          children: [
            _topMenu(
              title: S.of(context).order,
              subTitle: S.of(context).table(state.tableNumber),
              action: Container(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                decoration: BoxDecoration(
                  color: const Color(0xff1f2029),
                  borderRadius: BorderRadius.circular(18),
                  border: Border.all(color: Colors.deepOrangeAccent, width: 1),
                ),
                child: DropdownButton<String>(
                  value: state.tableNumber,
                  icon:
                      const Icon(Icons.arrow_drop_down, color: Colors.white54),
                  dropdownColor: const Color(0xff1f2029),
                  underline: Container(), // Remove default underline
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                  ),
                  items: List.generate(10, (i) => (i + 1).toString())
                      .map((tableNum) => DropdownMenuItem(
                            value: tableNum,
                            child: Text(
                              S.of(context).table(tableNum),
                              style: const TextStyle(color: Colors.white),
                            ),
                          ))
                      .toList(),
                  onChanged: (value) {
                    if (value != null) {
                      context.read<OrderCubit>().setTableNumber(value);
                    }
                  },
                ),
              ),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: ListView.builder(
                itemCount: state.items.length,
                itemBuilder: (context, index) {
                  final item = state.items[index];
                  // You'll need to fetch menu item details using the menuItemId
                  return OrderItem(
                    image: 'assets/items/${item.menuItemId}.png',
                    title: S.of(context).menuItem(item.menuItemId),
                    qty: item.quantity.toString(),
                    price: '\$${item.price}',
                    onRemove: () {
                      context.read<OrderCubit>().removeItem(item.menuItemId);
                    },
                    onQuantityChanged: (quantity) {
                      context.read<OrderCubit>().updateQuantity(
                            item.menuItemId,
                            quantity,
                          );
                    },
                  );
                },
              ),
            ),
            _buildTotalSection(state.totalAmount),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.white,
                backgroundColor: Colors.deepOrange,
                padding: const EdgeInsets.symmetric(vertical: 8),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              onPressed: state.items.isEmpty
                  ? null
                  : () async {
                      final customerInfo = await showDialog<CustomerInfo>(
                        context: context,
                        builder: (context) => const CustomerInfoDialog(),
                      );

                      if (customerInfo != null) {
                        if (!context.mounted) return;
                        await context
                            .read<OrderCubit>()
                            .completeOrder(customerInfo);

                        if (!context.mounted) return;
                        showDialog(
                          context: context,
                          builder: (context) => AlertDialog(
                            backgroundColor: const Color(0xff1f2029),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                            title: Row(
                              children: [
                                const Icon(Icons.check_circle,
                                    color: Colors.green),
                                const SizedBox(width: 10),
                                Text(
                                  S.of(context).success,
                                  style: const TextStyle(color: Colors.white),
                                ),
                              ],
                            ),
                            content: Text(
                              S.of(context).orderCompleted(customerInfo.name),
                              style: const TextStyle(color: Colors.white70),
                            ),
                            actions: [
                              TextButton(
                                onPressed: () => Navigator.pop(context),
                                child: Text(
                                  S.of(context).ok,
                                  style: const TextStyle(
                                    color: Colors.deepOrangeAccent,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        );
                      }
                    },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.check_circle, size: 16),
                  const SizedBox(width: 6),
                  Text(S.of(context).completeOrder),
                ],
              ),
            ),
          ],
        );
      },
    );
  }

  Widget _topMenu({
    required String title,
    required String subTitle,
    required Widget action,
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 6),
            Text(
              subTitle,
              style: const TextStyle(
                color: Colors.white54,
                fontSize: 10,
              ),
            ),
          ],
        ),
        Expanded(flex: 1, child: Container(width: double.infinity)),
        Expanded(flex: 5, child: action),
      ],
    );
  }

  Widget _buildTotalSection(double total) {
    return Container(
      padding: const EdgeInsets.all(20),
      margin: const EdgeInsets.symmetric(vertical: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(14),
        color: const Color(0xff1f2029),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Total',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  fontSize: 18,
                ),
              ),
              Text(
                '\$${total.toStringAsFixed(2)}',
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.deepOrangeAccent,
                  fontSize: 18,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
