import 'package:flutter_bloc/flutter_bloc.dart';
import '../../models/menu_item_model.dart';
import '../../data/database_helper.dart';
import '../../data/menu_data.dart';

class MenuCubit extends Cubit<List<MenuItemModel>> {
  final DatabaseHelper _databaseHelper = DatabaseHelper();
  final List<MenuItemModel> _allItems = menuItems;
  String _searchQuery = '';
  String _selectedCategory = 'burger';

  MenuCubit() : super(menuItems) {
    // Load initial data
    loadMenuItems();
  }

  Future<void> loadMenuItems() async {
    final items = await _databaseHelper.getMenuItems();
    emit(items);
  }

  void filterByCategory(String category) {
    _selectedCategory = category;
    _applyFilters();
  }

  void searchItems(String query) {
    _searchQuery = query.toLowerCase();
    _applyFilters();
  }

  void _applyFilters() {
    final filteredItems = _allItems.where((item) {
      final matchesCategory = item.category == _selectedCategory;
      final itemName = getMenuItemName(item.id!).toLowerCase();
      final matchesSearch = itemName.contains(_searchQuery);
      return matchesCategory && matchesSearch;
    }).toList();

    emit(filteredItems);
  }
}
