part of 'coffee_bloc.dart';

@freezed
class CoffeeState with _$CoffeeState {
  const factory CoffeeState.initial() = CoffeeInitialState;
  const factory CoffeeState.loading() = CoffeeLoadingState;
  const factory CoffeeState.loaded(List<CoffeeModel> coffee) = CoffeeLoadedState;
  const factory CoffeeState.error(String message) = CoffeeErrorState;
}
