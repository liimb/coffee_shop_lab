import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/entity/coffee_model.dart';
import '../../bloc/coffee/coffee_bloc.dart';
import '../../bloc/category/category_bloc.dart';
import 'coffee_card.dart';

class CoffeeListView extends StatelessWidget {
  const CoffeeListView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CoffeeBloc, CoffeeState>(
      builder: (context, coffeeState) {
        return BlocBuilder<CategoryBloc, CategoryState>(
          builder: (context, categoryState) {
            return RefreshIndicator(
              onRefresh: () async {
                context.read<CoffeeBloc>().add(CoffeeEvent.loadCoffee());
                context.read<CategoryBloc>().add(
                    CategoryEvent.loadCategories());
                await Future.delayed(const Duration(milliseconds: 500));
              },
              child: () {
                if (coffeeState is CoffeeLoadingState ||
                    categoryState is CategoryLoadingState) {
                  return ListView(
                    physics: const AlwaysScrollableScrollPhysics(),
                    children: [
                      SizedBox(
                        height: MediaQuery
                            .of(context)
                            .size
                            .height * 0.6,
                        child: Center(child: CircularProgressIndicator()),
                      ),
                    ],
                  );
                }

                if (coffeeState is CoffeeErrorState ||
                    categoryState is CategoryErrorState) {
                  final message = coffeeState is CoffeeErrorState
                      ? coffeeState.message
                      : (categoryState is CategoryErrorState ? categoryState
                      .message : "Ошибка");

                  return ListView(
                    physics: const AlwaysScrollableScrollPhysics(),
                    children: [
                      SizedBox(
                        height: MediaQuery
                            .of(context)
                            .size
                            .height * 0.6,
                        child: Center(child: Text(message)),
                      ),
                    ],
                  );
                }

                if (coffeeState is CoffeeLoadedState &&
                    categoryState is CategoryLoadedState) {
                  final coffees = coffeeState.coffee;
                  final categories = categoryState.categories;
                  final grouped = <String, List<CoffeeModel>>{};
                  for (final category in categories) {
                    grouped[category.slug] =
                        coffees
                            .where((c) => c.category.slug == category.slug)
                            .toList();
                  }

                  return ListView(
                    padding: const EdgeInsets.only(left: 16, right: 16, bottom: 150),
                    physics: const BouncingScrollPhysics(),
                    children: grouped.entries.expand((entry) {
                      final items = entry.value;
                      if (items.isEmpty) return <Widget>[];

                      return [
                        Padding(
                          key: ValueKey(entry.key),//categoryState.categoryKeys[entry.key],
                          padding: const EdgeInsets.only(bottom: 24, top: 16),
                          child: Text(
                            entry.key,
                            style: Theme
                                .of(context)
                                .textTheme
                                .titleSmall,
                          ),
                        ),
                        MediaQuery.removePadding(
                          context: context,
                          removeTop: true,
                          child: GridView.builder(
                            itemCount: items.length,
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              mainAxisSpacing: 16,
                              crossAxisSpacing: 16,
                              childAspectRatio: 0.65,
                            ),
                            itemBuilder: (context, index) {
                              final coffee = items[index];
                              return CoffeeCard(
                                key: ValueKey(coffee.id),
                                coffee: coffee,
                                onAdd: () {
                                  // context.read<CartBloc>().add(CartEvent.addItem(coffee));
                                },
                              );
                            },
                          ),
                        ),
                      ];
                    }).toList(),
                  );
                }

                return const SizedBox();
              }(),
            );
          },
        );
      },
    );
  }
}
