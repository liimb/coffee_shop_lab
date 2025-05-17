import 'package:coffee_shop/features/home/presentation/bloc/theme/theme_state.dart';

abstract interface class IThemeRepository {
  Future<String> getAppTheme();
  Future<void> setAppTheme(Themes theme);
}
