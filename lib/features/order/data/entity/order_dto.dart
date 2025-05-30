import 'package:freezed_annotation/freezed_annotation.dart';

part 'order_dto.g.dart';

@JsonSerializable()
class OrderDto {
  OrderDto({required this.positions, required this.token});

  final Map<String, int> positions;
  final String token;

  factory OrderDto.fromJson(Map<String, dynamic> json) =>
      _$OrderDtoFromJson(json);

  Map<String, dynamic> toJson() => _$OrderDtoToJson(this);
}
