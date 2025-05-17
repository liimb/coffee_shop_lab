import 'package:coffee_shop/app/coffee_app.dart';
import 'package:coffee_shop/common/api_client.dart';
import 'package:coffee_shop/env/env.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final dio = Dio();
  final apiClient = ApiClient(dio, baseUrl: Env.baseUrl);

  runApp(CoffeeApp(apiClient: apiClient));
}
