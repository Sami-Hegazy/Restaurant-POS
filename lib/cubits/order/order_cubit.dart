import 'package:flutter_bloc/flutter_bloc.dart';
import '../../models/order_model.dart';
import '../../models/menu_item_model.dart';
import '../../data/database_helper.dart';

class OrderState {
  final List<OrderItemModel> items;
  final String tableNumber;
  final double totalAmount;

  OrderState({
    this.items = const [],
    this.tableNumber = '1',
    this.totalAmount = 0,
  });

  OrderState copyWith({
    List<OrderItemModel>? items,
    String? tableNumber,
    double? totalAmount,
  }) {
    return OrderState(
      items: items ?? this.items,
      tableNumber: tableNumber ?? this.tableNumber,
      totalAmount: totalAmount ?? this.totalAmount,
    );
  }
}

class OrderCubit extends Cubit<OrderState> {
  final DatabaseHelper _databaseHelper = DatabaseHelper();

  OrderCubit() : super(OrderState());

  void addItem(MenuItemModel menuItem) {
    final currentItems = List<OrderItemModel>.from(state.items);
    final price = double.parse(menuItem.price.replaceAll('\$', ''));

    // Check if item already exists
    final existingItemIndex = currentItems.indexWhere(
      (item) => item.menuItemId == menuItem.id,
    );

    if (existingItemIndex != -1) {
      // Update quantity if item exists
      final existingItem = currentItems[existingItemIndex];
      currentItems[existingItemIndex] = OrderItemModel(
        id: existingItem.id,
        orderId: existingItem.orderId,
        menuItemId: existingItem.menuItemId,
        quantity: existingItem.quantity + 1,
        price: price,
      );
    } else {
      // Add new item
      currentItems.add(OrderItemModel(
        menuItemId: menuItem.id!,
        quantity: 1,
        price: price,
      ));
    }

    final newTotal = currentItems.fold<double>(
      0,
      (total, item) => total + (item.price * item.quantity),
    );

    emit(state.copyWith(
      items: currentItems,
      totalAmount: newTotal,
    ));
  }

  void removeItem(int menuItemId) {
    final currentItems = List<OrderItemModel>.from(state.items);
    currentItems.removeWhere((item) => item.menuItemId == menuItemId);

    final newTotal = currentItems.fold<double>(
      0,
      (total, item) => total + (item.price * item.quantity),
    );

    emit(state.copyWith(
      items: currentItems,
      totalAmount: newTotal,
    ));
  }

  void updateQuantity(int menuItemId, int quantity) {
    if (quantity <= 0) {
      removeItem(menuItemId);
      return;
    }

    final currentItems = List<OrderItemModel>.from(state.items);
    final itemIndex = currentItems.indexWhere(
      (item) => item.menuItemId == menuItemId,
    );

    if (itemIndex != -1) {
      final item = currentItems[itemIndex];
      currentItems[itemIndex] = OrderItemModel(
        id: item.id,
        orderId: item.orderId,
        menuItemId: item.menuItemId,
        quantity: quantity,
        price: item.price,
      );

      final newTotal = currentItems.fold<double>(
        0,
        (total, item) => total + (item.price * item.quantity),
      );

      emit(state.copyWith(
        items: currentItems,
        totalAmount: newTotal,
      ));
    }
  }

  void setTableNumber(String number) {
    emit(state.copyWith(tableNumber: number));
  }

  Future<void> completeOrder(CustomerInfo customerInfo) async {
    if (state.items.isEmpty) return;

    final order = OrderModel(
      tableNumber: state.tableNumber,
      totalAmount: state.totalAmount,
      status: 'pending',
      createdAt: DateTime.now(),
      items: state.items,
      customerInfo: customerInfo,
    );

    await _databaseHelper.insertOrder(order);
    emit(OrderState());
  }
}
