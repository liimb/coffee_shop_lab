import 'package:coffee_shop/features/cart/presentation/widget/cart_fab.dart';
import 'package:coffee_shop/features/order/presentation/widget/order_snack_bar.dart';
import 'package:coffee_shop/features/theme/presentation/widget/theme_fab.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../../common/app_constants.dart';
import '../../cart/presentation/bloc/cart_bloc.dart';
import '../../cart/presentation/widget/cart_bottom_sheet.dart';
import '../../category/presentation/bloc/category_bloc.dart';
import '../../category/presentation/widget/category_list_view.dart';
import '../../coffee/domain/entity/coffee_model.dart';
import '../../coffee/presentation/bloc/coffee_bloc.dart';
import '../../coffee/presentation/widget/coffee_list_view.dart';
import '../../order/domain/entity/order_model.dart';
import '../../order/presentation/bloc/order_bloc.dart';
import '../../theme/presentation/bloc/theme_bloc.dart';
import '../../theme/presentation/bloc/theme_event.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        BlocListener<CoffeeBloc, CoffeeState>(
          listener: (context, state) {
            if (state is CoffeeLoadedState) {
              context.read<CartBloc>().add(CartEvent.initial(state.coffee));
            }
          },
        ),
        BlocListener<OrderBloc, OrderState>(
            listener: (context, state) {
              if (state is OrderSuccessState) {
                context.read<CartBloc>().add(CartCleanEvent());
                context.pop();
                ScaffoldMessenger.of(context).hideCurrentSnackBar();
                ScaffoldMessenger.of(context).showSnackBar(orderSnackBar(state.message, context),
                );
              } else if (state is OrderErrorState) {
                ScaffoldMessenger.of(context).hideCurrentSnackBar();
                ScaffoldMessenger.of(context).showSnackBar(orderSnackBar(state.message, context)
                );
              }
            }
        )
      ],
      child: Scaffold(
        body: Column(
          children: [
            SafeArea(
                child: CategoryListView(onTapCard: (int id) {
                  context.read<CategoryBloc>().add(CategoryEvent.selectCategory(id),);
                })
            ),
            Expanded(
                child: CoffeeListView(
                onRefresh: () async {
                  context.read<CoffeeBloc>().add(CoffeeEvent.loadCoffee());
                  context.read<CategoryBloc>().add(CategoryEvent.loadCategories());
                  await Future.delayed(const Duration(milliseconds: 500));
                },
                onAdd: (CoffeeModel coffee) {
                  context.read<CartBloc>().add(CartEvent.onAddCoffee(coffee));
                },
                onRemove: (CoffeeModel coffee) {
                  context.read<CartBloc>().add(CartEvent.onRemoveCoffee(coffee));
                }
            )
            )
          ],
        ),
        floatingActionButton: SizedBox(
          height: 60,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ThemeFab(
                    onPressed: () {
                      context.read<ThemeBloc>().add(ToggleTheme());
                    }
                ),
                CartFab(
                  onPressed: () {
                    showModalBottomSheet(
                      context: context,
                      isScrollControlled: true,
                      backgroundColor: Theme.of(context).cardColor,
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
                      ),

                      builder: (context) {
                         return CartBottomSheet(
                          onCleanCart: () {
                            context.read<CartBloc>().add(CartCleanEvent());
                            context.pop();
                          },
                          onCreateOrder: () {
                            final cartState = context.read<CartBloc>().state;
                            final positions = <int, int>{};
                            for (final coffee in cartState.coffee) {
                              positions.update(coffee.id, (value) => value + 1, ifAbsent: () => 1);
                            }
                            final order = OrderModel(positions: positions, token: token);
                            context.read<OrderBloc>().add(CreateOrderEvent(order));
                          },
                        );
                      }
                    );
                  },
                ),
              ],
            ),
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      ),
    );
  }
}
