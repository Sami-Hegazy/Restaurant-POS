import 'package:flutter_bloc/flutter_bloc.dart';
import '../../models/menu_item_model.dart';

class MenuCubit extends Cubit<List<MenuItemModel>> {
  MenuCubit() : super(menuItems);

  void filterByCategory(String category) {
    final filteredItems =
        menuItems.where((item) => item.category == category).toList();
    emit(filteredItems);
  }
}
