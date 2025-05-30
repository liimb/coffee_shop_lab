import 'package:coffee_shop/features/theme/data/datasource/theme_datasource.dart';
import 'package:coffee_shop/features/theme/domain/repository/theme_repository.dart';
import '../../presentation/bloc/theme_state.dart';

class ThemeRepository implements IThemeRepository {
  final IThemeDataSource _themeDataSource;
  
  ThemeRepository({required IThemeDataSource themeDataSource}) : _themeDataSource = themeDataSource;

  @override
  Future<String> getAppTheme() async {
    return await _themeDataSource.getAppTheme();
  }

  @override
  Future<void> setAppTheme(Themes theme) async {
    await _themeDataSource.setAppTheme(theme);
  }
}
