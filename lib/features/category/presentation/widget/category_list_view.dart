import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/category_bloc.dart';
import 'category_card.dart';

class CategoryListView extends StatelessWidget {
  const CategoryListView({required onTapCard, super.key}) : _onTapCard = onTapCard;

  final Function(int id) _onTapCard;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CategoryBloc, CategoryState>(
      builder: (context, state) {
        switch (state) {
          case CategoryLoadingState():
            return SizedBox(height: 60);
          case CategoryLoadedState():
            final loadedState = state;
            final categories = loadedState.categories;
            return SizedBox(height: 60, child: Padding(padding: EdgeInsets.only(top: 16, bottom: 8),child: ListView.builder(
                shrinkWrap: true,
                primary: false,
                itemCount: categories.length,
                itemBuilder: (context, i) {

                  final category = categories[i];
                  final isSelected = category.id == state.selectedCategoryId;

                  final isFirst = i == 0;
                  final isLast = i == categories.length - 1;

                  return Padding(
                    padding: EdgeInsets.only(
                      left: isFirst && !isLast ? 16 : 8,
                      right: isLast ? 16 : 0,
                    ),
                    child: CategoryCard(
                      categoryModel: category,
                      isSelected: isSelected,
                      onTap: () => _onTapCard(category.id)
                    ),
                  );
                },
                scrollDirection: Axis.horizontal
            )));

          case CategoryErrorState():
            return SizedBox(height: 60);

          default:
            return const SizedBox();
        }
      },
    );
  }
}
