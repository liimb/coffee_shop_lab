import 'package:coffee_shop/features/category/domain/entity/category_model.dart';

abstract interface class ICategoryRepository {
  Future<List<CategoryModel>> getCategories();
  Future<List<CategoryModel>> getCategoriesFromDb();
}
