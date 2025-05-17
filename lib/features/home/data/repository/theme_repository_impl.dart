import 'package:coffee_shop/features/home/data/datasource/theme_datasource.dart';
import 'package:coffee_shop/features/home/domain/repository/theme_repository.dart';
import 'package:coffee_shop/features/home/presentation/bloc/theme/theme_state.dart';

class ThemeRepository implements IThemeRepository {
  final IThemeDataSource _themeDataSource;
  
  ThemeRepository({required IThemeDataSource themeDataSource}) : _themeDataSource = themeDataSource;

  @override
  Future<String> getAppTheme() async {
    final theme = await _themeDataSource.getAppTheme();
    return theme;
  }

  @override
  Future<void> setAppTheme(Themes theme) async {
    await _themeDataSource.setAppTheme(theme);
  }
}
