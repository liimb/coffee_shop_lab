import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';
import '../../../category/presentation/bloc/category_bloc.dart';
import '../../domain/entity/coffee_model.dart';
import '../bloc/coffee_bloc.dart';
import 'coffee_card.dart';

class CoffeeListView extends StatelessWidget {
  const CoffeeListView({super.key, required this.onRefresh, required this.onAdd, required this.onRemove});

  final RefreshCallback onRefresh;
  final Function(CoffeeModel coffee) onAdd;
  final Function(CoffeeModel coffee) onRemove;

  @override
  Widget build(BuildContext context) {
    final ItemScrollController itemScrollController = ItemScrollController();
    final ItemPositionsListener itemPositionsListener = ItemPositionsListener.create();
    List<String> categorySlugs = [];

    return BlocBuilder<CoffeeBloc, CoffeeState>(
        builder: (context, coffeeState) {
          return BlocBuilder<CategoryBloc, CategoryState>(
            builder: (context, categoryState) {
              if (coffeeState is CoffeeLoadedState && categoryState is CategoryLoadedState) {
                final selectedId = categoryState.selectedCategoryId;
                final index = categoryState.categories.indexWhere((c) => c.id == selectedId);

                if (index != -1 && itemScrollController.isAttached) {
                  itemScrollController.scrollTo(
                    index: index,
                    duration: const Duration(milliseconds: 300),
                    curve: Curves.easeInOut,
                  );
                }
              }
              return RefreshIndicator(
                onRefresh: onRefresh,
                child: () {
                  if (coffeeState is CoffeeLoadingState ||
                      categoryState is CategoryLoadingState) {
                    return ListView(
                      physics: const AlwaysScrollableScrollPhysics(),
                      children: [
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.6,
                          child: const Center(child: CircularProgressIndicator()),
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
                          height: MediaQuery.of(context).size.height * 0.6,
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
                          coffees.where((c) =>
                          c.category.slug == category.slug).toList();
                    }

                    categorySlugs = grouped.keys.toList().where((slug) => grouped[slug]!.isNotEmpty).toList();

                    return ScrollablePositionedList.builder(
                      itemScrollController: itemScrollController,
                      itemPositionsListener: itemPositionsListener,
                      itemCount: categorySlugs.length,
                      padding: const EdgeInsets.only(
                          left: 16, right: 16, bottom: 150),
                      physics: const BouncingScrollPhysics(),
                      itemBuilder: (context, index) {
                        final slug = categorySlugs[index];
                        final items = grouped[slug]!;

                        if (items.isEmpty) return const SizedBox.shrink();

                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(bottom: 24, top: 16),
                              child: Text(slug, style: Theme.of(context).textTheme.titleSmall,),
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
                                      coffee: coffee,
                                      onAdd: () => onAdd(coffee),
                                      onRemove: () => onRemove(coffee)
                                  );
                                },
                              ),
                            ),
                          ],
                        );
                      },
                    );
                  }

                  return const SizedBox();
                }(),
              );
            },
          );
        }
    );
  }
}
