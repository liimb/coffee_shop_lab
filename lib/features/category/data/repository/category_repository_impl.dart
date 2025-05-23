import 'package:coffee_shop/features/category/data/datasource/category_datasource.dart';
import 'package:coffee_shop/features/category/data/entity/category_response_dto.dart';
import 'package:coffee_shop/features/category/domain/entity/category_model.dart';
import 'package:coffee_shop/features/category/domain/mapping/category_mapper.dart';
import 'package:coffee_shop/features/category/domain/repository/category_repository.dart';

class CategoryRepository implements ICategoryRepository {
  final ICategoryDataSource _categoryDataSource;

  CategoryRepository({
    required ICategoryDataSource categoryDataSource
  }) : _categoryDataSource = categoryDataSource;

  @override
  Future<List<CategoryModel>> getCategories() async {
    try {
      CategoryResponseDto categories = await _categoryDataSource.getAllCategories();
      return categories.data.map((c) => c.toModel()).toList();
    } catch(e) {
      rethrow;
    }
  }

}
