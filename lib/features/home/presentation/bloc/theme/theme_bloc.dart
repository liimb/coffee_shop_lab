import 'package:bloc/bloc.dart';
import 'package:coffee_shop/features/home/presentation/bloc/theme/theme_event.dart';
import 'package:coffee_shop/features/home/presentation/bloc/theme/theme_state.dart';
import 'package:flutter/material.dart';

class ThemeBloc extends Bloc<ThemeEvent, ThemeState> {
  ThemeBloc() : super(const ThemeState(themeMode: ThemeMode.light)) {
    on<ToggleTheme>((event, emit) {
      final isDark = state.themeMode == ThemeMode.dark;
      emit(ThemeState(themeMode: isDark ? ThemeMode.light : ThemeMode.dark));
    });
  }
}
