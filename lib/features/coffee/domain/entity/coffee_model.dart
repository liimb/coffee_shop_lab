import 'package:coffee_shop/features/category/domain/entity/category_model.dart';
import 'package:coffee_shop/features/price/domain/entity/price_model.dart';

class CoffeeModel {
  final int id;
  final String name;
  final String description;
  final CategoryModel category;
  final String imageUrl;
  final List<PriceModel> prices;

  CoffeeModel ({
    required this.id,
    required this.name,
    required this.description,
    required this.category,
    required this.imageUrl,
    required this.prices
  });
}
