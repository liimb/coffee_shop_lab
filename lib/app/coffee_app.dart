import 'package:coffee_shop/common/api_client.dart';
import 'package:coffee_shop/features/home/data/datasource/category_datasource.dart';
import 'package:coffee_shop/features/home/data/datasource/theme_datasource.dart';
import 'package:coffee_shop/features/home/data/repository/category_repository_impl.dart';
import 'package:coffee_shop/features/home/data/repository/theme_repository_impl.dart';
import 'package:coffee_shop/features/home/domain/repository/category_repository.dart';
import 'package:coffee_shop/features/home/domain/repository/theme_repository.dart';
import 'package:coffee_shop/features/home/presentation/bloc/category/category_bloc.dart';
import 'package:coffee_shop/features/home/presentation/bloc/theme/theme_bloc.dart';
import 'package:coffee_shop/features/home/presentation/bloc/theme/theme_state.dart';
import 'package:coffee_shop/routing/app_routing.dart';
import 'package:coffee_shop/uikit/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../features/home/presentation/bloc/theme/theme_event.dart';

class CoffeeApp extends StatelessWidget {
  const CoffeeApp({super.key, required apiClient}) : _apiClient = apiClient;

  final ApiClient _apiClient;

  @override
  Widget build(BuildContext context) {

    return MultiRepositoryProvider(
        providers: [
          RepositoryProvider<IThemeRepository>(
            create: (context) => ThemeRepository(themeDataSource: ThemeDataSource(storage: SharedPreferencesAsync())),
          ),
          RepositoryProvider<ICategoryRepository>(
            create: (context) => CategoryRepository(categoryDataSource: CategoryDataSource(apiClient: _apiClient)),
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
            ],
            child: BlocBuilder<ThemeBloc, ThemeState>(
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
