import 'package:path/path.dart';
import '../models/menu_item_model.dart';
import '../models/order_model.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper._internal();
  static Database? _database;

  factory DatabaseHelper() => _instance;

  DatabaseHelper._internal();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    String path = join(await getDatabasesPath(), 'restaurant.db');
    return await openDatabase(
      path,
      version: 2,
      onCreate: _onCreate,
      onUpgrade: _onUpgrade,
    );
  }

  Future<void> _onCreate(Database db, int version) async {
    // Menu Items table
    await db.execute('''
      CREATE TABLE menu_items(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        image TEXT,
        title TEXT,
        price TEXT,
        quantity TEXT,
        category TEXT
      )
    ''');

    // Orders table
    await db.execute('''
      CREATE TABLE orders(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        table_number TEXT,
        total_amount REAL,
        status TEXT,
        created_at TEXT,
        customer_name TEXT,
        customer_phone TEXT,
        customer_address TEXT
      )
    ''');

    // Order Items table (for items in each order)
    await db.execute('''
      CREATE TABLE order_items(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        order_id INTEGER,
        menu_item_id INTEGER,
        quantity INTEGER,
        price REAL,
        FOREIGN KEY (order_id) REFERENCES orders (id),
        FOREIGN KEY (menu_item_id) REFERENCES menu_items (id)
      )
    ''');

    // Insert initial menu items
    for (var item in menuItems) {
      await db.insert('menu_items', {
        'image': item.image,
        'title': item.title,
        'price': item.price,
        'quantity': item.quantity,
        'category': item.category,
      });
    }
  }

  Future<void> _onUpgrade(Database db, int oldVersion, int newVersion) async {
    if (oldVersion < 2) {
      // Drop the old tables
      await db.execute('DROP TABLE IF EXISTS order_items');
      await db.execute('DROP TABLE IF EXISTS orders');

      // Create new tables with updated schema
      await db.execute('''
        CREATE TABLE orders(
          id INTEGER PRIMARY KEY AUTOINCREMENT,
          table_number TEXT,
          total_amount REAL,
          status TEXT,
          created_at TEXT,
          customer_name TEXT,
          customer_phone TEXT,
          customer_address TEXT
        )
      ''');

      await db.execute('''
        CREATE TABLE order_items(
          id INTEGER PRIMARY KEY AUTOINCREMENT,
          order_id INTEGER,
          menu_item_id INTEGER,
          quantity INTEGER,
          price REAL,
          FOREIGN KEY (order_id) REFERENCES orders (id),
          FOREIGN KEY (menu_item_id) REFERENCES menu_items (id)
        )
      ''');
    }
  }

  // Menu Items operations
  Future<List<MenuItemModel>> getMenuItems() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query('menu_items');
    return List.generate(maps.length, (i) {
      return MenuItemModel(
        image: maps[i]['image'],
        title: maps[i]['title'],
        price: maps[i]['price'],
        quantity: maps[i]['quantity'],
        category: maps[i]['category'],
      );
    });
  }

  Future<List<MenuItemModel>> getMenuItemsByCategory(String category) async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query(
      'menu_items',
      where: 'category = ?',
      whereArgs: [category],
    );
    return List.generate(maps.length, (i) {
      return MenuItemModel(
        image: maps[i]['image'],
        title: maps[i]['title'],
        price: maps[i]['price'],
        quantity: maps[i]['quantity'],
        category: maps[i]['category'],
      );
    });
  }

  // Order operations
  Future<int> insertOrder(OrderModel order) async {
    final db = await database;
    final orderId = await db.insert('orders', {
      'table_number': order.tableNumber,
      'total_amount': order.totalAmount,
      'status': order.status,
      'created_at': order.createdAt.toIso8601String(),
      'customer_name': order.customerInfo.name,
      'customer_phone': order.customerInfo.phone,
      'customer_address': order.customerInfo.address,
    });

    // Insert order items
    for (var item in order.items) {
      await db.insert('order_items', {
        'order_id': orderId,
        'menu_item_id': item.menuItemId,
        'quantity': item.quantity,
        'price': item.price,
      });
    }

    return orderId;
  }

  Future<List<OrderModel>> getOrders() async {
    final db = await database;
    final List<Map<String, dynamic>> orderMaps = await db.query(
      'orders',
      orderBy: 'created_at DESC',
    );

    return Future.wait(orderMaps.map((orderMap) async {
      final List<Map<String, dynamic>> itemMaps = await db.query(
        'order_items',
        where: 'order_id = ?',
        whereArgs: [orderMap['id']],
      );

      final items = itemMaps
          .map((itemMap) => OrderItemModel(
                id: itemMap['id'],
                orderId: itemMap['order_id'],
                menuItemId: itemMap['menu_item_id'],
                quantity: itemMap['quantity'],
                price: itemMap['price'],
              ))
          .toList();

      return OrderModel(
        id: orderMap['id'],
        tableNumber: orderMap['table_number'] ?? '',
        totalAmount: orderMap['total_amount'] ?? 0.0,
        status: orderMap['status'] ?? 'pending',
        createdAt: DateTime.parse(
            orderMap['created_at'] ?? DateTime.now().toIso8601String()),
        items: items,
        customerInfo: CustomerInfo(
          name: orderMap['customer_name'] ?? 'Unknown',
          phone: orderMap['customer_phone'],
          address: orderMap['customer_address'],
        ),
      );
    }).toList());
  }
}
