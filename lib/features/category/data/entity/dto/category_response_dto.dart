import 'package:coffee_shop/features/category/data/entity/dto/category_dto.dart';
import 'package:json_annotation/json_annotation.dart';

part 'category_response_dto.g.dart';

@JsonSerializable()
class CategoryResponseDto {
  CategoryResponseDto({required this.data});

  final List<CategoryDto> data;

  factory CategoryResponseDto.fromJson(Map<String, dynamic> json) =>
      _$CategoryResponseDtoFromJson(json);

  Map<String, dynamic> toJson() => _$CategoryResponseDtoToJson(this);
}
