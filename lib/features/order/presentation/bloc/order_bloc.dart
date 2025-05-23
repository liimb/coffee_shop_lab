import 'package:coffee_shop/features/order/domain/repository/order_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import '../../domain/entity/order_model.dart';

part 'order_bloc.freezed.dart';
part 'order_event.dart';
part 'order_state.dart';

class OrderBloc extends Bloc<OrderEvent, OrderState> {
  final IOrderRepository _orderRepository;

  OrderBloc({required orderRepository}) : _orderRepository = orderRepository, super(const OrderState.initial()) {

    on<CreateOrderEvent>((event, emit) async {
      emit(const OrderState.loading());
      try {
        final response = await _orderRepository.createOrder(event.order);
        if(response.message == "succлess") {
          emit(const OrderState.success('Заказ создан'));
        } else {
          emit(const OrderState.error('Возникла ошибка при заказе'));
        }
      } catch (e) {
        emit(const OrderState.error('Возникла ошибка при заказе'));
      }
    });
  }
}
