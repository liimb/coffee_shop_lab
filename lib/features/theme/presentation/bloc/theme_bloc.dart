import 'package:coffee_shop/features/theme/domain/repository/theme_repository.dart';
import 'package:coffee_shop/features/theme/presentation/bloc/theme_event.dart';
import 'package:coffee_shop/features/theme/presentation/bloc/theme_state.dart';
import 'package:coffee_shop/resourses/app_images.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ThemeBloc extends Bloc<ThemeEvent, ThemeState> {

  final IThemeRepository _themeRepository;

  ThemeBloc({required IThemeRepository themeRepository}) :_themeRepository = themeRepository, super(ThemeState(themeMode: ThemeMode.light)) {

    on<ToggleTheme>((event, emit) async {
      final isDark = state.themeMode == ThemeMode.dark;
      final newTheme = isDark ? Themes.light : Themes.dark;
      await _themeRepository.setAppTheme(newTheme);
      emit(ThemeState(themeMode: isDark ? ThemeMode.light : ThemeMode.dark));
    });

    on<LoadSavedTheme>((event, emit) async {
      final saved = await _themeRepository.getAppTheme();
      final loadedTheme = saved == Themes.light.name ? ThemeMode.light : ThemeMode.dark;
      emit(ThemeState(themeMode: loadedTheme));
    });
  }

  String getThemeIcon() {
    return state.themeMode == ThemeMode.dark ? AppImages.moon : AppImages.sun;
  }
}
