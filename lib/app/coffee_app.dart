import 'package:coffee_shop/common/api_client.dart';
import 'package:coffee_shop/common/app_database.dart';
import 'package:coffee_shop/features/cart/data/datasource/cart_datasource.dart';
import 'package:coffee_shop/features/cart/data/repository/cart_repository_impl.dart';
import 'package:coffee_shop/features/cart/domain/repository/cart_repository.dart';
import 'package:coffee_shop/features/category/data/datasource/category_datasource.dart';
import 'package:coffee_shop/features/coffee/data/datasource/coffee_datasource.dart';
import 'package:coffee_shop/features/order/data/datasource/order_datasource.dart';
import 'package:coffee_shop/features/order/data/repository/order_repository_impl.dart';
import 'package:coffee_shop/features/order/domain/repository/order_repository.dart';
import 'package:coffee_shop/features/order/presentation/bloc/order_bloc.dart';
import 'package:coffee_shop/features/theme/data/datasource/theme_datasource.dart';
import 'package:coffee_shop/features/category/data/repository/category_repository_impl.dart';
import 'package:coffee_shop/features/coffee/data/repository/coffee_repository_impl.dart';
import 'package:coffee_shop/features/theme/data/repository/theme_repository_impl.dart';
import 'package:coffee_shop/features/category/domain/repository/category_repository.dart';
import 'package:coffee_shop/features/coffee/domain/repository/coffee_repository.dart';
import 'package:coffee_shop/features/theme/domain/repository/theme_repository.dart';
import 'package:coffee_shop/features/cart/presentation/bloc/cart_bloc.dart';
import 'package:coffee_shop/features/category/presentation/bloc/category_bloc.dart';
import 'package:coffee_shop/features/coffee/presentation/bloc/coffee_bloc.dart';
import 'package:coffee_shop/features/theme/presentation/bloc/theme_bloc.dart';
import 'package:coffee_shop/routing/app_routing.dart';
import 'package:coffee_shop/uikit/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../features/theme/presentation/bloc/theme_event.dart';
import '../features/theme/presentation/bloc/theme_state.dart';

class CoffeeApp extends StatelessWidget {
  const CoffeeApp({super.key, required apiClient, required appDatabase}) :
        _apiClient = apiClient,
        _appDatabase = appDatabase;

  final ApiClient _apiClient;
  final AppDatabase _appDatabase;

  @override
  Widget build(BuildContext context) {

    return MultiRepositoryProvider(

        providers: [
          RepositoryProvider<IThemeRepository>(
            create: (context) => ThemeRepository(themeDataSource: ThemeDataSource(storage: SharedPreferencesAsync())),
          ),
          RepositoryProvider<ICategoryRepository>(
            create: (context) => CategoryRepository(categoryDataSource: CategoryDataSource(apiClient: _apiClient, appDatabase: _appDatabase)),
          ),
          RepositoryProvider<ICoffeeRepository>(
            create: (context) => CoffeeRepository(coffeeDataSource: CoffeeDataSource(apiClient: _apiClient, appDatabase: _appDatabase)),
          ),
          RepositoryProvider<ICartRepository>(
            create: (context) => CartRepository(cartDataSource: CartDataSource(appDatabase: _appDatabase)),
          ),
          RepositoryProvider<IOrderRepository>(
            create: (context) => OrderRepository(orderDataSource: OrderDataSource(apiClient: _apiClient)),
          )

        ],

        child: MultiBlocProvider(

            providers: [
              BlocProvider(
                create: (context) {
                  final bloc = ThemeBloc(themeRepository: context.read<IThemeRepository>());
                  bloc.add(LoadSavedTheme());
                  return bloc;
                },
              ),
              BlocProvider(
                create: (context) {
                  final bloc = CategoryBloc(categoryRepository: context.read<ICategoryRepository>());
                  bloc.add(CategoryEvent.loadCategories());
                  return bloc;
                },
              ),
              BlocProvider(
                create: (context) {
                  final bloc = CoffeeBloc(coffeeRepository: context.read<ICoffeeRepository>());
                  bloc.add(CoffeeEvent.loadCoffee());
                  return bloc;
                },
              ),
              BlocProvider(
                create: (context) {
                  final bloc = CartBloc(cartRepository: context.read<ICartRepository>());
                  return bloc;
                },
              ),
              BlocProvider(
                create: (context) {
                  final bloc = OrderBloc(orderRepository: context.read<IOrderRepository>());
                  return bloc;
                },
              )
            ],

            child: BlocBuilder<ThemeBloc, ThemeState> (
              buildWhen: (previous, current) => previous.themeMode != current.themeMode,
              builder: (context, state) {
                return MaterialApp.router(
                  theme: AppTheme.lightTheme,
                  darkTheme: AppTheme.darkTheme,
                  themeMode: state.themeMode,
                  routerConfig: router,
                );
              },
            )
        )
    );
  }
}
