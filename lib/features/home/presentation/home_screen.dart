import 'package:coffee_shop/features/home/presentation/widgets/category_list_view.dart';
import 'package:coffee_shop/features/home/presentation/widgets/coffee_list_view.dart';
import 'package:coffee_shop/features/home/presentation/widgets/theme_cart_fab.dart';
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

      floatingActionButton: ThemeCartFab(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
