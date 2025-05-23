import 'package:freezed_annotation/freezed_annotation.dart';

part 'order_response_dto.g.dart';

@JsonSerializable()
class OrderResponseDto {
  OrderResponseDto({required this.message, required this.orderId});

  final String message;
  final String orderId;

  factory OrderResponseDto.fromJson(Map<String, dynamic> json) =>
      _$OrderResponseDtoFromJson(json);

  Map<String, dynamic> toJson() => _$OrderResponseDtoToJson(this);
}
