import 'package:drift/drift.dart';

@DataClassName("CartItemEntry")
class CartItems extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get coffeeId => integer()();
  IntColumn get count => integer()();
}
