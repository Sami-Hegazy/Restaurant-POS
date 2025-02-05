import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:restaurant_pos/generated/l10n.dart';
import '../models/order_model.dart';
import '../cubits/order_history/order_history_cubit.dart';
import 'package:intl/intl.dart';
import '../data/menu_data.dart';

class HistoryScreen extends StatelessWidget {
  const HistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => OrderHistoryCubit(),
      child: const HistoryView(),
    );
  }
}

class HistoryView extends StatelessWidget {
  const HistoryView({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            decoration: BoxDecoration(
              color: const Color(0xff1f2029),
              borderRadius: BorderRadius.circular(12),
            ),
            child: TextField(
              style: const TextStyle(color: Colors.white),
              decoration: InputDecoration(
                hintText: S.of(context).searchHint,
                hintStyle: const TextStyle(color: Colors.white54),
                prefixIcon: const Icon(Icons.search, color: Colors.white54),
                border: InputBorder.none,
              ),
              onChanged: (value) {
                context.read<OrderHistoryCubit>().filterOrders(value);
              },
            ),
          ),
          const SizedBox(height: 16),
          Expanded(
            child: BlocBuilder<OrderHistoryCubit, OrderHistoryState>(
              builder: (context, state) {
                if (state.isLoading) {
                  return const Center(child: CircularProgressIndicator());
                }

                if (state.filteredOrders.isEmpty) {
                  return Center(
                    child: Text(
                      S.of(context).noOrdersFound,
                      style: const TextStyle(color: Colors.white54),
                    ),
                  );
                }

                return ListView.builder(
                  itemCount: state.filteredOrders.length,
                  itemBuilder: (context, index) {
                    final order = state.filteredOrders[index];
                    return OrderHistoryCard(order: order);
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class OrderHistoryCard extends StatelessWidget {
  final OrderModel order;

  const OrderHistoryCard({
    super.key,
    required this.order,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      color: const Color(0xff1f2029),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: ExpansionTile(
        iconColor: Colors.deepOrangeAccent,
        collapsedIconColor: Colors.white54,
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text(
                  S.of(context).table(order.tableNumber),
                  style: const TextStyle(
                    color: Colors.deepOrangeAccent,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const Spacer(),
                Text(
                  DateFormat('MMM d, y hh:mm').format(order.createdAt),
                  style: const TextStyle(
                    color: Colors.white54,
                    fontSize: 12,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 4),
            Text(
              order.customerInfo.name,
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
            if (order.customerInfo.phone != null) ...[
              const SizedBox(height: 4),
              Text(
                order.customerInfo.phone!,
                style: const TextStyle(color: Colors.white54, fontSize: 12),
              ),
            ],
          ],
        ),
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (order.customerInfo.address != null) ...[
                  Text(
                    S.of(context).deliveryAddress,
                    style: const TextStyle(
                      color: Colors.white54,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    order.customerInfo.address!,
                    style: const TextStyle(color: Colors.white),
                  ),
                  const Divider(color: Colors.white24),
                ],
                Text(
                  S.of(context).orderItems,
                  style: const TextStyle(
                    color: Colors.white54,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                ...order.items.map((item) => Padding(
                      padding: const EdgeInsets.only(bottom: 4),
                      child: Row(
                        children: [
                          Text(
                            '${item.quantity}x',
                            style: const TextStyle(
                              color: Colors.deepOrangeAccent,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(width: 8),
                          Expanded(
                            child: Text(
                              getMenuItemName(item.menuItemId),
                              style: const TextStyle(color: Colors.white),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          Text(
                            '\$${(item.price * item.quantity).toStringAsFixed(2)}',
                            style: const TextStyle(color: Colors.white),
                          ),
                        ],
                      ),
                    )),
                const Divider(color: Colors.white24),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    const Text(
                      'Total:',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(width: 8),
                    Text(
                      '\$${order.totalAmount.toStringAsFixed(2)}',
                      style: const TextStyle(
                        color: Colors.deepOrangeAccent,
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
