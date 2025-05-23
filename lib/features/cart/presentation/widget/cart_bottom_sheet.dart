import 'package:coffee_shop/features/cart/presentation/bloc/cart_bloc.dart';
import 'package:coffee_shop/features/order/presentation/bloc/order_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../uikit/theme/app_colors.dart';
import '../../../coffee/domain/entity/coffee_model.dart';
import 'cart_item_widget.dart';

class CartBottomSheet extends StatelessWidget {
  final VoidCallback _onCleanCart;
  final VoidCallback _onCreateOrder;

  const CartBottomSheet({required onCleanCart, required onCreateOrder, super.key}) : _onCleanCart = onCleanCart, _onCreateOrder = onCreateOrder;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CartBloc, CartState>(
      builder: (context, state) {
        final coffeeList = state.coffee;
        final grouped = <CoffeeModel, int>{};
        for (final coffee in coffeeList) {
          grouped[coffee] = (grouped[coffee] ?? 0) + 1;
        }

        return DraggableScrollableSheet(
          expand: false,
          initialChildSize: 0.6,
          minChildSize: 0.6,
          maxChildSize: 0.8,
          builder: (_, scrollController) {
            return Scaffold(
                backgroundColor: Colors.transparent,
                body: Container(
                  decoration: BoxDecoration(
                    color: Theme.of(context).cardColor,
                    borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
                  ),
                  child: Column(
                    children: [
                      const SizedBox(height: 16),
                      Container(
                        width: 40,
                        height: 5,
                        decoration: BoxDecoration(
                          color: Theme.of(context).colorScheme.onSecondary,
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      const SizedBox(height: 16),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("Ваш заказ", style: Theme.of(context).textTheme.headlineSmall),
                            IconButton(
                              icon: Icon(Icons.delete_outline_rounded, color: Theme.of(context).colorScheme.onSecondary, size: 30),
                              onPressed: _onCleanCart,
                            ),
                          ],
                        ),
                      ),

                      Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          child:Divider(color: Theme.of(context).colorScheme.onPrimary)
                      ),

                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          child: NotificationListener<OverscrollIndicatorNotification>(
                            onNotification: (overscroll) {
                              overscroll.disallowIndicator();
                              return true;
                            },
                            child: ListView.builder(
                              controller: scrollController,
                              itemCount: grouped.length,
                              itemBuilder: (context, index) {
                                final coffee = grouped.keys.elementAt(index);
                                final count = grouped[coffee]!;
                                final price = (double.tryParse(coffee.prices.first.value) ?? 0) * count;
                                final formattedPrice = (price * 100).round() / 100;
                                return CartItem(
                                  imageUrl: coffee.imageUrl,
                                  title: coffee.name,
                                  count: count,
                                  price: (formattedPrice * 100).toInt(),
                                );
                              },
                            ),
                          ),
                        ),
                      ),


                      Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          child:Divider(color: Theme.of(context).colorScheme.onPrimary)
                      ),

                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("Итого", style: Theme.of(context).textTheme.titleMedium),
                            Text("${(state.price / 100).toStringAsFixed(2)} ₽", style: Theme.of(context).textTheme.titleMedium),
                          ],
                        ),
                      ),

                      SafeArea(
                          child:Padding(
                              padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
                              child: SizedBox(
                                  width: double.infinity,
                                  child: BlocBuilder<OrderBloc, OrderState>(
                                      builder: (context, state) {
                                        final isLoading = state is OrderLoadingState;

                                        return ElevatedButton(
                                          onPressed: isLoading ? null : _onCreateOrder,
                                          style: ElevatedButton.styleFrom(
                                            padding: EdgeInsets.all(12),
                                            backgroundColor: Theme.of(context).colorScheme.primary,
                                            foregroundColor: Colors.white,
                                            shape: RoundedRectangleBorder(
                                              borderRadius: BorderRadius.circular(30),
                                            ),
                                          ),
                                          child: isLoading ? SizedBox(width: 22, height: 22, child: CircularProgressIndicator()) : Text("Оформить заказ", style: Theme.of(context).textTheme.titleMedium?.copyWith(color: AppColors.white)),
                                        );
                                      }
                                  )
                              )
                          )
                      )
                    ],
                  ),
                )
            );
          },
        );
      },
    );
  }
}
