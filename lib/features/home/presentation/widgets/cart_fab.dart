import 'package:flutter/material.dart';

import '../../../../resourses/app_images.dart';
import '../../../../uikit/theme/app_colors.dart';

class CartFab extends StatelessWidget {
  const CartFab({super.key});

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton.extended (
        backgroundColor: Theme.of(context).colorScheme.primary,
        onPressed: () {

        },
        heroTag: "cartFAB",
        icon: Image.asset(AppImages.cart, width: 25, height: 25),
        label: Text("7979797979 руб", style: Theme.of(context).textTheme.displayLarge?.copyWith(color: AppColors.white)
        )
    );
  }
}
