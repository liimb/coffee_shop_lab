import 'package:coffee_shop/features/home/domain/entity/category_model.dart';

abstract interface class ICategoryRepository {
  Future<List<CategoryModel>> getCategories();
}
