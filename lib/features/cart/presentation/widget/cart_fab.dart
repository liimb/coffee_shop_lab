import 'package:coffee_shop/features/category/presentation/bloc/category_bloc.dart';
import 'package:coffee_shop/features/coffee/presentation/bloc/coffee_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../resourses/app_images.dart';
import '../../../../uikit/theme/app_colors.dart';
import '../bloc/cart_bloc.dart';

class CartFab extends StatelessWidget {
  final VoidCallback onPressed;

  const CartFab({super.key, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CartBloc, CartState>(
      builder: (context, state) {
        if (context.read<CoffeeBloc>().state is CoffeeLoadedState && context.read<CategoryBloc>().state is CategoryLoadedState && state.coffee.isNotEmpty) {
          return FloatingActionButton.extended (
              backgroundColor: Theme.of(context).colorScheme.primary,
              onPressed: onPressed,
              heroTag: "cartFAB",
              icon: Image.asset(AppImages.cart, width: 25, height: 25),
              label: Text("${state.price / 100}", style: Theme.of(context).textTheme.displayLarge?.copyWith(color: AppColors.white))
          );
        } else {
          return const SizedBox(height: 60);
        }
      },
    );
  }
}
