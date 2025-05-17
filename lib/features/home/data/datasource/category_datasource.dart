import 'package:coffee_shop/features/home/data/entity/category_response_dto.dart';

import '../../../../common/api_client.dart';

abstract interface class ICategoryDataSource {
  Future<CategoryResponseDto> getAllCategories();
}

class CategoryDataSource implements ICategoryDataSource {

  final ApiClient _client;

  const CategoryDataSource({required ApiClient apiClient}) : _client = apiClient;

  @override
  Future<CategoryResponseDto> getAllCategories() async {
    final CategoryResponseDto response = await _client.getCategories();
    return response;
  }

}
