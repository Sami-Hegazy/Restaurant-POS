import 'package:flutter_bloc/flutter_bloc.dart';
import '../../models/order_model.dart';
import '../../data/database_helper.dart';

class OrderHistoryState {
  final List<OrderModel> orders;
  final List<OrderModel> filteredOrders;
  final bool isLoading;
  final String searchQuery;

  OrderHistoryState({
    this.orders = const [],
    this.filteredOrders = const [],
    this.isLoading = true,
    this.searchQuery = '',
  });

  OrderHistoryState copyWith({
    List<OrderModel>? orders,
    List<OrderModel>? filteredOrders,
    bool? isLoading,
    String? searchQuery,
  }) {
    return OrderHistoryState(
      orders: orders ?? this.orders,
      filteredOrders: filteredOrders ?? this.filteredOrders,
      isLoading: isLoading ?? this.isLoading,
      searchQuery: searchQuery ?? this.searchQuery,
    );
  }
}

class OrderHistoryCubit extends Cubit<OrderHistoryState> {
  final DatabaseHelper _databaseHelper = DatabaseHelper();

  OrderHistoryCubit() : super(OrderHistoryState()) {
    loadOrders();
  }

  Future<void> loadOrders() async {
    emit(state.copyWith(isLoading: true));
    final orders = await _databaseHelper.getOrders();
    emit(state.copyWith(
      orders: orders,
      filteredOrders: orders,
      isLoading: false,
    ));
  }

  void filterOrders(String query) {
    final filteredOrders = state.orders.where((order) {
      final customerName = order.customerInfo.name.toLowerCase();
      final tableNumber = order.tableNumber.toLowerCase();
      final searchLower = query.toLowerCase();
      return customerName.contains(searchLower) ||
          tableNumber.contains(searchLower);
    }).toList();

    emit(state.copyWith(
      filteredOrders: filteredOrders,
      searchQuery: query,
    ));
  }
}
