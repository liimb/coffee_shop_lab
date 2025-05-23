import 'package:coffee_shop/features/coffee/data/entity/coffee_dto.dart';
import 'package:coffee_shop/features/coffee/domain/entity/coffee_model.dart';
import 'package:coffee_shop/features/price/domain/mapping/price_mapper.dart';

extension CoffeeMapper on CoffeeDto {
  CoffeeModel toModel() {
    return CoffeeModel(id: id, name: name, description: description, category: category, imageUrl: imageUrl, prices: prices.map((e) => e.toModel()).toList());
  }
}
