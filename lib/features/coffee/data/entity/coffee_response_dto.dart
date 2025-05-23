import 'package:coffee_shop/features/coffee/data/entity/coffee_dto.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'coffee_response_dto.g.dart';

@JsonSerializable()
class CoffeeResponseDto {
  CoffeeResponseDto({required this.data});

  final List<CoffeeDto> data;

  factory CoffeeResponseDto.fromJson(Map<String, dynamic> json) =>
      _$CoffeeResponseDtoFromJson(json);

  Map<String, dynamic> toJson() => _$CoffeeResponseDtoToJson(this);
}
