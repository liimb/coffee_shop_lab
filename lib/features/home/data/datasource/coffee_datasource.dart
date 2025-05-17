import 'package:coffee_shop/features/home/data/entity/coffee_dto.dart';

abstract interface class ICoffeeDataSource {
  Future<List<CoffeeDto>> getAllCoffee();
}
