import '../../presentation/bloc/theme_state.dart';

abstract interface class IThemeRepository {
  Future<String> getAppTheme();
  Future<void> setAppTheme(Themes theme);
}
