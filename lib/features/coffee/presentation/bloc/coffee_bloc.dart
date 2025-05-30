import 'package:coffee_shop/features/coffee/domain/entity/coffee_model.dart';
import 'package:coffee_shop/features/coffee/domain/repository/coffee_repository.dart';
import 'package:coffee_shop/util/request_retry.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'coffee_bloc.freezed.dart';
part 'coffee_event.dart';
part 'coffee_state.dart';

class CoffeeBloc extends Bloc<CoffeeEvent, CoffeeState> {
  final ICoffeeRepository _coffeeRepository;

  CoffeeBloc({required ICoffeeRepository coffeeRepository}) : _coffeeRepository = coffeeRepository, super(CoffeeState.initial()) {
    on<LoadCoffeeEvent>((event, emit) async {
      try {
        emit(CoffeeState.loading());
        final coffee = await fetchWithRetry(() => _coffeeRepository.getCoffee());
        await _coffeeRepository.saveCoffeeToDb(coffee);
        emit(CoffeeState.loaded(coffee));
      } catch (e) {
        final coffee = await _coffeeRepository.getCoffeeFromDb();
        if(coffee.isNotEmpty) {
          emit(CoffeeState.loaded(coffee));
        } else {
          emit(CoffeeState.error('Ошибка загрузки кофе'));
        }
      }
    });
  }
}
