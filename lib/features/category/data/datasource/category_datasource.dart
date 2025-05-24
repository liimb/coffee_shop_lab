import 'package:coffee_shop/common/app_database.dart';
import 'package:coffee_shop/features/category/domain/entity/category_model.dart';

import '../../../../common/api_client.dart';
import '../entity/dto/category_response_dto.dart';

abstract interface class ICategoryDataSource {
  Future<CategoryResponseDto> getCategories();
  Future<List<CategoryModel>> getCategoriesFromDb();
}

class CategoryDataSource implements ICategoryDataSource {

  final ApiClient _client;
  final AppDatabase _appDatabase;

  const CategoryDataSource({required apiClient, required appDatabase}) : _client = apiClient, _appDatabase = appDatabase;

  @override
  Future<CategoryResponseDto> getCategories() async {
    final CategoryResponseDto response = await _client.getCategories();
    return response;
  }

  @override
  Future<List<CategoryModel>> getCategoriesFromDb() async {
    final categoryRows = await _appDatabase.select(_appDatabase.categoryItems).get();

    return categoryRows
        .map((row) => CategoryModel(
      id: row.id,
      slug: row.slug,
    )).toList();
  }
}
