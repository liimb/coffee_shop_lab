import 'package:coffee_shop/features/order/domain/entity/order_model.dart';

import '../../data/entity/order_dto.dart';

extension OrderMapper on OrderModel {
  OrderDto toDto() {
    return OrderDto(
      positions: positions.map((key, value) => MapEntry(key.toString(), value)),
      token: token,
    );
  }
}
