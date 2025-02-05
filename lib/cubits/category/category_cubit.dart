import 'package:flutter_bloc/flutter_bloc.dart';

class CategoryCubit extends Cubit<String> {
  CategoryCubit() : super('Burger'); // Default category

  void changeCategory(String category) {
    emit(category);
  }
}
