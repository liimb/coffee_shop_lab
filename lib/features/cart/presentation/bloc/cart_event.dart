part of 'cart_bloc.dart';

@freezed
class CartEvent with _$CartEvent {
  const factory CartEvent.initial(List<CoffeeModel> allAvailableCoffee) = CartInitialEvent;
  const factory CartEvent.onAddCoffee(CoffeeModel coffeeModel) = CartAddCoffeeEvent;
  const factory CartEvent.onRemoveCoffee(CoffeeModel coffeeModel) = CartRemoveCoffeeEvent;
  const factory CartEvent.cleanCart() = CartCleanEvent;
}
