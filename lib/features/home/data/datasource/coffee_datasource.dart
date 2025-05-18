import 'package:coffee_shop/common/api_client.dart';
import 'package:coffee_shop/features/home/data/entity/coffee_response_dto.dart';

abstract interface class ICoffeeDataSource {
  Future<CoffeeResponseDto> getAllCoffee();
}

class CoffeeDataSource implements ICoffeeDataSource {

  final ApiClient _client;

  CoffeeDataSource({required ApiClient apiClient}) : _client = apiClient;

  @override
  Future<CoffeeResponseDto> getAllCoffee() async {
    final response = await _client.getCoffee();
    return response;
  }
}
