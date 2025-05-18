import 'package:coffee_shop/features/home/data/entity/category_dto.dart';
import 'package:coffee_shop/features/home/data/entity/price_dto.dart';
import 'package:json_annotation/json_annotation.dart';

part 'coffee_dto.g.dart';

@JsonSerializable()
class CoffeeDto {
  final int id;
  final String name;
  final String description;
  final CategoryDto category;
  final String imageUrl;
  final List<PriceDto> prices;

  CoffeeDto({required this.id, required this.name, required this.description, required this.category, required this.imageUrl, required this.prices});

  factory CoffeeDto.fromJson(Map<String, dynamic> json) =>
      _$CoffeeDtoFromJson(json);

  Map<String, dynamic> toJson() => _$CoffeeDtoToJson(this);
}
