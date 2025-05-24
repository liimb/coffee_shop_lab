import 'dart:io';
import 'package:coffee_shop/features/coffee/data/entity/db/coffee_items.dart';
import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart';
import '../features/cart/data/entity/cart_items.dart';
import '../features/category/data/entity/db/category_items.dart';
import '../features/price/data/entity/db/price_items.dart';

part 'app_database.g.dart';

@DriftDatabase(tables: [CartItems, CoffeeItems, CategoryItems, PriceItems])
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(_openConnection());

  @override
  int get schemaVersion => 1;
}

LazyDatabase _openConnection() {
  return LazyDatabase(() async {
    final dbFolder = await getApplicationDocumentsDirectory();
    final file = File(path.join(dbFolder.path, 'db_app.sqlite'));
    return NativeDatabase.createInBackground(file);
  });
}
