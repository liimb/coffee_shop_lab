import 'package:coffee_shop/features/home/domain/entity/coffee_model.dart';

abstract interface class ICoffeeRepository {
  Future<List<CoffeeModel>> getCoffee();
}
