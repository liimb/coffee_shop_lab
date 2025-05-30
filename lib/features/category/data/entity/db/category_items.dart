import 'package:drift/drift.dart';

@DataClassName("CategoryItemEntity")
class CategoryItems extends Table {
  IntColumn get id => integer()();
  TextColumn get slug => text()();

  @override
  Set<Column> get primaryKey => {id};
}
