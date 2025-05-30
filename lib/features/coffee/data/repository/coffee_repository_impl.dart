import 'package:coffee_shop/features/coffee/data/datasource/coffee_datasource.dart';
import 'package:coffee_shop/features/coffee/data/entity/dto/coffee_response_dto.dart';
import 'package:coffee_shop/features/coffee/domain/entity/coffee_model.dart';
import 'package:coffee_shop/features/coffee/domain/mapping/coffee_mapper.dart';
import 'package:coffee_shop/features/coffee/domain/repository/coffee_repository.dart';

class CoffeeRepository implements ICoffeeRepository {

  final ICoffeeDataSource _coffeeDataSource;

  CoffeeRepository({required ICoffeeDataSource coffeeDataSource}) : _coffeeDataSource = coffeeDataSource;

  @override
  Future<List<CoffeeModel>> getCoffee() async {
    CoffeeResponseDto coffeeResponse = await _coffeeDataSource.getCoffee();
    return coffeeResponse.data.map((e) => e.toModel()).toList();
  }

  @override
  Future<List<CoffeeModel>> getCoffeeFromDb() async {
    return await _coffeeDataSource.getCoffeeFromDb();
  }

  @override
  Future<void> saveCoffeeToDb(List<CoffeeModel> coffee) async {
    await _coffeeDataSource.saveCoffeeToDb(coffee);
  }
}
