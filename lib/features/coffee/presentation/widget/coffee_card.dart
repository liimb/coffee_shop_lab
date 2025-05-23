import 'package:coffee_shop/features/cart/presentation/bloc/cart_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../../../resourses/app_images.dart';
import '../../domain/entity/coffee_model.dart';

class CoffeeCard extends StatelessWidget {
  final CoffeeModel coffee;
  final VoidCallback onAdd;
  final VoidCallback onRemove;

  const CoffeeCard({
    super.key,
    required this.coffee,
    required this.onAdd,
    required this.onRemove
  });

  @override
  Widget build(BuildContext context) {
    final price = coffee.prices.first.value;

    return Material(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            InkWell(
                splashColor: Colors.transparent,
                onTap: () {
                  context.pushNamed('coffeeDetails', extra: coffee);
                },
                borderRadius: BorderRadius.circular(16),
                child: Ink(
                    padding: const EdgeInsets.only(right: 16, top: 16, left: 16, bottom: 16),
                    decoration: BoxDecoration(
                      color: Theme.of(context).cardColor,
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(16),
                            child: Image.network(
                              height: 100,
                              coffee.imageUrl,
                              fit: BoxFit.cover,
                              errorBuilder: (context, url, error) => Image.asset(AppImages.coffeeError),
                            ),
                          ),

                        const SizedBox(height: 16),
                        Text(
                          coffee.name,
                          style: Theme.of(context).textTheme.titleLarge,
                          textAlign: TextAlign.center,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    )
                )
            ),

            Expanded(
                child: Padding(
                    padding: const EdgeInsets.only(right: 16, left: 16, bottom: 8),
                    child:Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        BlocBuilder<CartBloc, CartState> (
                            builder: (context, state) {
                              if(state.coffee.contains(coffee)) {
                                return SizedBox(width: 0,height: 0);
                              } else {
                                return Text(
                                    '$price ₽',
                                    style: Theme.of(context).textTheme.titleMedium
                                );
                              }
                            }
                        ),

                        BlocBuilder<CartBloc, CartState> (
                            builder: (context, state) {
                              if(state.coffee.contains(coffee)) {
                                return Expanded(
                                    child: Row (
                                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      children: [
                                        Container (
                                            width: 35,
                                            height: 35,
                                            decoration: BoxDecoration(
                                              color: Theme.of(context).colorScheme.secondary,
                                              shape: BoxShape.circle,
                                            ),
                                            child: IconButton(
                                              icon: const Icon(Icons.remove, size: 25),
                                              onPressed: onRemove,
                                              color: Theme.of(context).colorScheme.inversePrimary,
                                              padding: EdgeInsets.zero,
                                              splashRadius: 18,
                                            )),
                                        Text(
                                          '${state.coffee.where((e) => e == coffee).length}',
                                          style: Theme.of(context).textTheme.titleMedium,
                                        ),
                                        Container (
                                            width: 35,
                                            height: 35,
                                            decoration: BoxDecoration(
                                              color: Theme.of(context).colorScheme.secondary,
                                              shape: BoxShape.circle,
                                            ),
                                            child: IconButton(
                                              icon: const Icon(Icons.add, size: 25),
                                              onPressed: onAdd,
                                              color: Theme.of(context).colorScheme.inversePrimary,
                                              padding: EdgeInsets.zero,
                                              splashRadius: 18,
                                            )
                                        )
                                      ],
                                    )
                                );
                              } else {
                                return Container (
                                    width: 35,
                                    height: 35,
                                    decoration: BoxDecoration(
                                      color: Theme.of(context).colorScheme.primary,
                                      shape: BoxShape.circle,
                                    ),
                                    child: IconButton(
                                      icon: const Icon(Icons.add, size: 25),
                                      onPressed: onAdd,
                                      color: Colors.white,
                                      padding: EdgeInsets.zero,
                                      splashRadius: 18,
                                    )
                                );
                              }
                            }
                        ),
                      ],
                    )
                )
            ),
          ],
        )
    );
  }
}
