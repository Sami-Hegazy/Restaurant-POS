class OrderModel {
  final int? id;
  final String tableNumber;
  final double totalAmount;
  final String status;
  final DateTime createdAt;
  final List<OrderItemModel> items;
  final CustomerInfo customerInfo;

  OrderModel({
    this.id,
    required this.tableNumber,
    required this.totalAmount,
    required this.status,
    required this.createdAt,
    required this.items,
    required this.customerInfo,
  });
}

class OrderItemModel {
  final int? id;
  final int? orderId;
  final int menuItemId;
  final int quantity;
  final double price;

  OrderItemModel({
    this.id,
    this.orderId,
    required this.menuItemId,
    required this.quantity,
    required this.price,
  });
}

class CustomerInfo {
  final String name;
  final String? phone;
  final String? address;

  CustomerInfo({
    required this.name,
    this.phone,
    this.address,
  });
}
