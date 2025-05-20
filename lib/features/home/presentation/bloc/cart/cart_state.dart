part of 'cart_bloc.dart';

@freezed
class CartState with _$CartState {
  const factory CartState.errorCreateOrder() = ErrorCreateOrder;
  const factory CartState.successCreateOrder() = SuccessCreateOrder;
}
