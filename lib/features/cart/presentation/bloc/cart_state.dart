part of 'cart_bloc.dart';

@freezed
abstract class CartState with _$CartState {
  const factory CartState({
    @Default([]) List<CoffeeModel> coffee,
    @Default(0) int price,
  }) = _CartState;
}
