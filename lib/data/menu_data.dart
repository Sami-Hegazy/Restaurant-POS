Map<int, String> menuItemNames = {
  1: 'Big Mac Burger',
  2: 'Chicken Burger',
  3: 'Beef Noodles',
  4: 'Shrimp Noodles',
  5: 'Cola',
  6: 'Orange Juice',
  7: 'Chocolate Cake',
  8: 'Ice Cream',
  // Add more items as needed
};

String getMenuItemName(int id) {
  return menuItemNames[id] ?? 'Unknown Item';
}
