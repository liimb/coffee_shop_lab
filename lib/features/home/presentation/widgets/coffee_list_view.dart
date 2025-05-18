import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/entity/coffee_model.dart';
import '../bloc/coffee/coffee_bloc.dart';
import 'coffee_card.dart';

class CoffeeListView extends StatelessWidget {
  const CoffeeListView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CoffeeBloc, CoffeeState>(
      builder: (context, state) {
        switch (state) {
          case CoffeeLoadingState():
            return const Center(
              child: SizedBox(width: 25, height: 25, child: CircularProgressIndicator()),
            );

          case CoffeeLoadedState():
            final coffees = state.coffee;

            final grouped = <String, List<CoffeeModel>>{};
            for (final coffee in coffees) {
              final categoryName = coffee.category.slug;
              grouped.putIfAbsent(categoryName, () => []).add(coffee);
            }

            return ListView(
              padding: const EdgeInsets.symmetric(horizontal: 32),
              children: grouped.entries.expand((entry) {
                final category = entry.key;
                final items = entry.value;

                return [
                  Padding(
                    padding: const EdgeInsets.only(bottom: 0),
                    child: Text(
                      category,
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),

                  GridView.builder(
                    itemCount: items.length,
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      mainAxisSpacing: 8,
                      crossAxisSpacing: 8,
                      childAspectRatio: 0.65,
                    ),
                    itemBuilder: (context, index) {
                      final coffee = items[index];
                      return CoffeeCard(
                        coffee: coffee,
                        onAdd: () {
                          // context.read<CartBloc>().add(CartEvent.addItem(coffee));
                        },
                      );
                    },
                  ),
                ];
              }).toList(),
            );

          case CoffeeErrorState():
            return Center(child: Text(state.message));

          default:
            return const SizedBox();
        }
      },
    );
  }
}
