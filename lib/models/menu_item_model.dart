class MenuItemModel {
  final String image;
  final String title;
  final String price;
  final String quantity;
  final String category;

  const MenuItemModel({
    required this.image,
    required this.title,
    required this.price,
    required this.quantity,
    required this.category,
  });
}

final List<MenuItemModel> menuItems = [
  // Burgers
  const MenuItemModel(
    image: 'assets/items/1.png',
    title: 'Original Burger',
    price: '\$5.99',
    quantity: '11 item',
    category: 'Burger',
  ),
  const MenuItemModel(
    image: 'assets/items/2.png',
    title: 'Double Burger',
    price: '\$10.99',
    quantity: '10 item',
    category: 'Burger',
  ),
  // ... add more burgers

  // Noodles
  const MenuItemModel(
    image: 'assets/items/5.png',
    title: 'Ramen Noodles',
    price: '\$8.99',
    quantity: '8 item',
    category: 'Noodles',
  ),
  // ... add more noodles

  // Drinks
  const MenuItemModel(
    image: 'assets/items/8.png',
    title: 'Cola',
    price: '\$2.99',
    quantity: '20 item',
    category: 'Drinks',
  ),
  // ... add more drinks

  // Desserts
  const MenuItemModel(
    image: 'assets/items/11.png',
    title: 'Ice Cream',
    price: '\$4.99',
    quantity: '15 item',
    category: 'Desserts',
  ),
  // ... add more desserts
];
