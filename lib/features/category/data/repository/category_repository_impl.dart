import 'package:coffee_shop/features/category/data/datasource/category_datasource.dart';
import 'package:coffee_shop/features/category/domain/entity/category_model.dart';
import 'package:coffee_shop/features/category/domain/mapping/category_mapper.dart';
import 'package:coffee_shop/features/category/domain/repository/category_repository.dart';

import '../entity/dto/category_response_dto.dart';

class CategoryRepository implements ICategoryRepository {
  final ICategoryDataSource _categoryDataSource;

  CategoryRepository({
    required ICategoryDataSource categoryDataSource
  }) : _categoryDataSource = categoryDataSource;

  @override
  Future<List<CategoryModel>> getCategories() async {
    CategoryResponseDto categories = await _categoryDataSource.getCategories();
    return categories.data.map((c) => c.toModel()).toList();
  }

  @override
  Future<List<CategoryModel>> getCategoriesFromDb() async {
    return await _categoryDataSource.getCategoriesFromDb();
  }
}
