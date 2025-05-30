import 'package:drift/drift.dart';
import 'package:coffee_shop/features/coffee/data/entity/db/coffee_items.dart';

@DataClassName("PriceItemEntity")
class PriceItems extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get coffeeId => integer()();
  TextColumn get value => text()();
  TextColumn get currency => text()();

  @override
  List<String> get customConstraints => [
    'FOREIGN KEY(coffee_id) REFERENCES coffee_items(id) ON DELETE CASCADE'
  ];
}
