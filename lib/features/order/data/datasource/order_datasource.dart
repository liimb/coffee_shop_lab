import 'package:coffee_shop/common/api_client.dart';
import 'package:coffee_shop/features/order/data/entity/order_dto.dart';
import 'package:coffee_shop/features/order/data/entity/order_response_dto.dart';

abstract interface class IOrderDataSource {
  Future<OrderResponseDto> createOrder(OrderDto order);
}

class OrderDataSource implements IOrderDataSource {
  final ApiClient _apiClient;

  OrderDataSource({required apiClient}) : _apiClient = apiClient;

  @override
  Future<OrderResponseDto> createOrder(OrderDto order) async {
    return await _apiClient.createOrder(order);
  }
}
