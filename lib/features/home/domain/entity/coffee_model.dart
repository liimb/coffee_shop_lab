import 'package:coffee_shop/features/home/domain/entity/price_model.dart';

import '../../data/entity/category_dto.dart';

class CoffeeModel {
  final int id;
  final String name;
  final String description;
  final CategoryDto category;
  final String imageUrl;
  final List<PriceModel> prices;

  CoffeeModel({required this.id, required this.name, required this.description, required this.category, required this.imageUrl, required this.prices});
}
