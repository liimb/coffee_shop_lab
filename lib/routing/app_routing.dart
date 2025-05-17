import 'package:coffee_shop/features/coffee/presentation/coffee_details_screen.dart';
import 'package:coffee_shop/features/home/domain/entity/coffee_model.dart';
import 'package:coffee_shop/features/home/presentation/home_screen.dart';
import 'package:go_router/go_router.dart';

final router = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(
      path: '/',
      name: 'home',
      builder: (context, state) => const HomeScreen(),
      routes: [
        GoRoute(
          path: 'details',
          name: 'coffeeDetails',
          builder: (context, state) {
            final coffee = state.extra as CoffeeModel;
            return CoffeeDetailsScreen(coffee: coffee);
          },
        ),
      ],
    ),
  ],
);
