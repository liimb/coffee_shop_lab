import 'package:coffee_shop/features/home/data/datasource/coffee_datasource.dart';
import 'package:coffee_shop/features/home/data/entity/coffee_response_dto.dart';
import 'package:coffee_shop/features/home/domain/entity/coffee_model.dart';
import 'package:coffee_shop/features/home/domain/mapping/coffee_mapper.dart';
import 'package:coffee_shop/features/home/domain/repository/coffee_repository.dart';

class CoffeeRepository implements ICoffeeRepository {

  final ICoffeeDataSource _coffeeDataSource;

  CoffeeRepository({required ICoffeeDataSource coffeeDataSource}) : _coffeeDataSource = coffeeDataSource;

  @override
  Future<List<CoffeeModel>> getCoffee() async {
    CoffeeResponseDto coffeeResponse = await _coffeeDataSource.getAllCoffee();
    return coffeeResponse.data.map((e) => e.toModel()).toList();
  }
}
