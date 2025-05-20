import 'package:coffee_shop/features/home/presentation/widgets/cart_fab.dart';
import 'package:coffee_shop/features/home/presentation/widgets/category/category_list_view.dart';
import 'package:coffee_shop/features/home/presentation/widgets/coffee/coffee_list_view.dart';
import 'package:coffee_shop/features/home/presentation/widgets/theme_fab.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
          children: [
            SafeArea(
              child: CategoryListView(),
            ),
            Expanded(child: CoffeeListView())
          ]
      ),

      floatingActionButton: Padding (
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row (
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  ThemeFab(),
                  CartFab()
                ],
              )
          ),

      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
