import 'package:coffee_shop/features/home/domain/entity/coffee_model.dart';
import 'package:coffee_shop/features/home/domain/repository/coffee_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:logger/logger.dart';

part 'coffee_bloc.freezed.dart';
part 'coffee_event.dart';
part 'coffee_state.dart';

class CoffeeBloc extends Bloc<CoffeeEvent, CoffeeState> {
  final ICoffeeRepository _coffeeRepository;

  CoffeeBloc({required ICoffeeRepository coffeeRepository}) : _coffeeRepository = coffeeRepository, super(CoffeeState.initial()) {
    on<LoadCoffee>((event, emit) async {
      try {
        final coffee = await _coffeeRepository.getCoffee();
        emit(CoffeeState.loaded(coffee));
      } catch (e,stack) {
        Logger().e(stack);
        emit(CoffeeState.error('Ошибка загрузки кофе'));
      }
    });
  }

}
