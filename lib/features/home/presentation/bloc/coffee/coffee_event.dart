part of 'coffee_bloc.dart';

@freezed
class CoffeeEvent with _$CoffeeEvent {
  const factory CoffeeEvent.loadCoffee() = LoadCoffee;
  const factory CoffeeEvent.addCoffeeToCart(int id) = AddCoffeeToCart;
  const factory CoffeeEvent.removeCoffeeFromCart(int id) = RemoveCoffeeFromCart;
}
