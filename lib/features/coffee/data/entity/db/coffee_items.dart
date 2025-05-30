import 'package:drift/drift.dart';

@DataClassName("CoffeeItemEntity")
class CoffeeItems extends Table {
  IntColumn get id => integer()();
  TextColumn get name => text()();
  TextColumn get description => text()();
  IntColumn get categoryId => integer()();
  TextColumn get imageUrl => text()();

  @override
  Set<Column> get primaryKey => {id};

  @override
  List<String> get customConstraints => [
    'FOREIGN KEY(category_id) REFERENCES category_items(id) ON DELETE CASCADE'
  ];
}
