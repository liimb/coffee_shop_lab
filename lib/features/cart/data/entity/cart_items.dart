import 'package:drift/drift.dart';

@DataClassName("CartItemEntity")
class CartItems extends Table {
  IntColumn get id => integer()();
  IntColumn get count => integer()();

  @override
  Set<Column> get primaryKey => {id};
}
