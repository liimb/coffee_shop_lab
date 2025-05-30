part of 'order_bloc.dart';

@freezed
class OrderState with _$OrderState {
  const factory OrderState.initial() = OrderInitialState;
  const factory OrderState.loading() = OrderLoadingState;
  const factory OrderState.success(String message) = OrderSuccessState;
  const factory OrderState.error(String message) = OrderErrorState;
}
