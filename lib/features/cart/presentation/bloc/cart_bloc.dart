import 'package:coffee_shop/common/app_constants.dart';
import 'package:coffee_shop/features/cart/domain/entity/cart_item.dart';
import 'package:coffee_shop/features/cart/domain/repository/cart_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import '../../../coffee/domain/entity/coffee_model.dart';

part 'cart_bloc.freezed.dart';
part 'cart_event.dart';
part 'cart_state.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  final ICartRepository _cartRepository;

  CartBloc({required cartRepository}) : _cartRepository = cartRepository, super(const CartState()) {
    on<CartInitialEvent>((event, emit) async {
      final cartItems = await _cartRepository.getCart();

      final cartCoffee = <CoffeeModel>[];

      for (final item in cartItems) {
        final coffee = event.allAvailableCoffee.firstWhere(
              (coffee) => coffee.id == item.id
        );
        cartCoffee.addAll(List.filled(item.count, coffee));
      }

      final totalPriceInCents = cartCoffee
          .map((e) => (double.parse(e.prices.first.value) * 100).toInt())
          .fold(0, (prev, price) => prev + price);

      emit(state.copyWith(coffee: cartCoffee, price: totalPriceInCents));
    });

      on<CartAddCoffeeEvent>((event, emit) async {
        final coffeeCount = state.coffee.where((e) => e == event.coffeeModel).length;

        if (coffeeCount < maxCoffeeCount) {
          final updatedCoffee = List<CoffeeModel>.from(state.coffee)..add(event.coffeeModel);

          await _cartRepository.addOrUpdateItemToCart(CartItem(id: event.coffeeModel.id, count: coffeeCount + 1));

          final totalPriceInCents = updatedCoffee
              .map((e) => (double.parse(e.prices.first.value) * 100).toInt())
              .fold(0, (prev, price) => prev + price);

          emit(state.copyWith(coffee: updatedCoffee, price: totalPriceInCents));
        }

      });

      on<CartRemoveCoffeeEvent>((event, emit) async {
        final updatedCoffee = List<CoffeeModel>.from(state.coffee)..remove(event.coffeeModel);

        final coffeeCount = updatedCoffee.where((e) => e == event.coffeeModel).length;

        await _cartRepository.addOrUpdateItemToCart(CartItem(id: event.coffeeModel.id, count: coffeeCount));

        final totalPriceInCents = updatedCoffee
            .map((e) => (double.parse(e.prices.first.value) * 100).toInt())
            .fold(0, (prev, price) => prev + price);

        emit(state.copyWith(coffee: updatedCoffee, price: totalPriceInCents));
      });

      on<CartCleanEvent>((event, emit) async {
        await _cartRepository.clearCart();
        emit(state.copyWith(coffee: List.empty(), price: 0));
      });
    }
  }
