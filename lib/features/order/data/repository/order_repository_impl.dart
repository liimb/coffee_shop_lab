import 'package:coffee_shop/features/order/data/datasource/order_datasource.dart';
import 'package:coffee_shop/features/order/data/entity/order_response_dto.dart';
import 'package:coffee_shop/features/order/domain/entity/order_model.dart';
import 'package:coffee_shop/features/order/domain/mapping/order_mapper.dart';
import 'package:coffee_shop/features/order/domain/repository/order_repository.dart';

class OrderRepository implements IOrderRepository {
  final IOrderDataSource _orderDataSource;

  OrderRepository({required orderDataSource}) : _orderDataSource = orderDataSource;

  @override
  Future<OrderResponseDto> createOrder(OrderModel order) async {
    return await _orderDataSource.createOrder(order.toDto());
  }
}
