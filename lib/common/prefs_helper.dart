import 'package:shared_preferences/shared_preferences.dart';

import '../features/home/presentation/bloc/theme/theme_state.dart';

class PrefsHelper {
  static final PrefsHelper _instance = PrefsHelper._internal();

  factory PrefsHelper() {
    return _instance;
  }

  PrefsHelper._internal();

  SharedPreferences? _prefs;

  Future<void> init() async {
    _prefs = await SharedPreferences.getInstance();
  }

  final String _themeKey = "theme";

  Future<void> saveAppTheme(String theme) async {
    await _prefs?.setString(_themeKey, theme);
  }

  Future<String> getAppTheme() async {
    return _prefs?.getString(_themeKey) ?? Themes.light.name;
  }
}
