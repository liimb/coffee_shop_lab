import 'package:coffee_shop/features/home/presentation/bloc/theme/theme_state.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract interface class IThemeDataSource {
  Future<String> getAppTheme();
  Future<void> setAppTheme(Themes theme);
}

class ThemeDataSource implements IThemeDataSource {
  const ThemeDataSource({required SharedPreferencesAsync storage})
      : _storage = storage;
  final SharedPreferencesAsync _storage;

  final themeKey = "theme";

  @override
  Future<void> setAppTheme(Themes theme) async {
    await _storage.setString(themeKey, theme.name);
  }

  @override
  Future<String> getAppTheme() async {
    final String? theme = await _storage.getString(themeKey);
    return theme ?? Themes.light.name;
  }
}
