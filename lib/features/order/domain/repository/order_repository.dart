import 'package:coffee_shop/features/order/domain/entity/order_model.dart';
import '../../data/entity/order_response_dto.dart';

abstract interface class IOrderRepository {
  Future<OrderResponseDto> createOrder(OrderModel order);
}
