import 'package:coffee_shop/features/home/domain/entity/category_model.dart';
import 'package:coffee_shop/features/home/presentation/bloc/theme/theme_bloc.dart';
import 'package:coffee_shop/uikit/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CategoryCard extends StatelessWidget {
  const CategoryCard({
    required CategoryModel categoryModel,
    required bool isSelected,
    required VoidCallback onTap,
    super.key}) : _categoryModel = categoryModel, _isSelected = isSelected, _onTap = onTap;

  final CategoryModel _categoryModel;
  final bool _isSelected;
  final VoidCallback _onTap;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        height: 60,
        child: Material (
          color: _isSelected ? Theme.of(context).colorScheme.primary : Theme.of(context).cardColor,
          borderRadius: BorderRadius.circular(32),
          child: InkWell(
              borderRadius: BorderRadius.circular(32),
              onTap: _onTap,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: Center(child: Text(
                    _categoryModel.slug,
                    style: _getTextStyle(context)
                ),
                ),
              )
          ),
        )
    );
  }

  TextStyle? _getTextStyle(BuildContext context) {
    final isLight = context.read<ThemeBloc>().state.themeMode == ThemeMode.light;
    return isLight
        ? (_isSelected ? Theme.of(context).textTheme.labelLarge?.copyWith(color: AppColors.white) : Theme.of(context).textTheme.labelLarge?.copyWith(color: AppColors.neutralDark))
        : Theme.of(context).textTheme.labelLarge?.copyWith(color: AppColors.white);
  }
}
