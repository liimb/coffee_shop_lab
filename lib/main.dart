import 'package:coffee_shop/app/coffee_app.dart';
import 'package:coffee_shop/common/api_client.dart';
import 'package:coffee_shop/common/app_database.dart';
import 'package:coffee_shop/env/env.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_displaymode/flutter_displaymode.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  if (!kIsWeb) {
    await FlutterDisplayMode.setHighRefreshRate();
  }

  final dio = Dio(BaseOptions(
    connectTimeout: const Duration(seconds: 3),
  ));

  final apiClient = ApiClient(dio, baseUrl: Env.baseUrl);
  final appDatabase = AppDatabase();

  runApp(
      CoffeeApp(apiClient: apiClient, appDatabase: appDatabase),
  );
}
