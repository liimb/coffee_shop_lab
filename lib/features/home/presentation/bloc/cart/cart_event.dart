part of 'cart_bloc.dart';

@freezed
class CartEvent with _$CartEvent {
  const factory CartEvent.onAddCoffee(CoffeeModel coffeeModel) = OnAddCoffee;
  const factory CartEvent.onRemoveCoffee(CoffeeModel coffeeModel) = OnRemoveCoffee;
  const factory CartEvent.createOrder() = CreateOrder;
  const factory CartEvent.cleanCart() = CleanCart;
}
