import 'package:coffee_shop/common/api_client.dart';
import 'package:coffee_shop/features/coffee/data/entity/dto/coffee_response_dto.dart';
import 'package:drift/drift.dart';

import '../../../../common/app_database.dart';
import '../../../category/domain/entity/category_model.dart';
import '../../../price/domain/entity/price_model.dart';
import '../../domain/entity/coffee_model.dart';

abstract interface class ICoffeeDataSource {
  Future<CoffeeResponseDto> getCoffee();
  Future<void> saveCoffeeToDb(List<CoffeeModel> coffee);
  Future<List<CoffeeModel>> getCoffeeFromDb();
}

class CoffeeDataSource implements ICoffeeDataSource {

  final ApiClient _client;
  final AppDatabase _appDatabase;

  CoffeeDataSource({required apiClient, required appDatabase}) : _client = apiClient, _appDatabase = appDatabase;

  @override
  Future<CoffeeResponseDto> getCoffee() async {
    return await _client.getCoffee();
  }

  @override
  Future<void> saveCoffeeToDb(List<CoffeeModel> coffee) async {

    await _appDatabase.transaction(() async {
      await _appDatabase.priceItems.deleteAll();
      await _appDatabase.coffeeItems.deleteAll();
      await _appDatabase.categoryItems.deleteAll();

      final categories = <int, CategoryModel>{};

      for (final coffee in coffee) {
        categories[coffee.category.id] = coffee.category;
      }

      for (final category in categories.values) {
        await _appDatabase.into(_appDatabase.categoryItems).insert(
          CategoryItemsCompanion(
            id: Value(category.id),
            slug: Value(category.slug),
          ),
        );
      }

      for (final coffee in coffee) {
        await _appDatabase.into(_appDatabase.coffeeItems).insert(
          CoffeeItemsCompanion(
            id: Value(coffee.id),
            name: Value(coffee.name),
            description: Value(coffee.description),
            categoryId: Value(coffee.category.id),
            imageUrl: Value(coffee.imageUrl),
          ),
        );

        for (final price in coffee.prices) {
          await _appDatabase.into(_appDatabase.priceItems).insert(
            PriceItemsCompanion(
              coffeeId: Value(coffee.id),
              value: Value(price.value),
              currency: Value(price.currency),
            ),
          );
        }
      }
    });
  }

  @override
  Future<List<CoffeeModel>> getCoffeeFromDb() async {
    final coffeeRows = await _appDatabase.select(_appDatabase.coffeeItems).get();
    final priceRows = await _appDatabase.select(_appDatabase.priceItems).get();
    final categoryRows = await _appDatabase.select(_appDatabase.categoryItems).get();

    final categoriesMap = {
      for (final c in categoryRows) c.id: CategoryModel(id: c.id, slug: c.slug)
    };

    final pricesByCoffeeId = <int, List<PriceModel>>{};
    for (final price in priceRows) {
      pricesByCoffeeId.putIfAbsent(price.coffeeId, () => []).add(
        PriceModel(value: price.value, currency: price.currency),
      );
    }

    final coffee = coffeeRows.map((c) {
      final prices = pricesByCoffeeId[c.id] ?? [];
      return CoffeeModel(
        id: c.id,
        name: c.name,
        description: c.description,
        category: categoriesMap[c.categoryId]!,
        imageUrl: c.imageUrl,
        prices: prices,
      );
    }).toList();

    return coffee;
  }
}
