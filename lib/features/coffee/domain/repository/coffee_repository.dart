import 'package:coffee_shop/features/coffee/domain/entity/coffee_model.dart';

abstract interface class ICoffeeRepository {
  Future<List<CoffeeModel>> getCoffee();
  Future<void> saveCoffeeToDb(List<CoffeeModel> coffee);
  Future<List<CoffeeModel>> getCoffeeFromDb();
}
