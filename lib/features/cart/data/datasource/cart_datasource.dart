import 'package:coffee_shop/features/cart/domain/entity/cart_item.dart';
import 'package:drift/drift.dart';
import '../../../../common/app_database.dart';
import '../../../../common/app_database.dart' as db;

abstract interface class ICartDataSource {
  Future<List<CartItem>> getCart();
  Future<void> addOrUpdateItemToCart(CartItem item);
  Future<void> clearCart();
}

class CartDataSource implements ICartDataSource {

  final AppDatabase _appDatabase;

  CartDataSource({required appDatabase}) : _appDatabase = appDatabase;

  @override
  Future<List<CartItem>> getCart() async {
    final rows = await _appDatabase.select(_appDatabase.cartItems).get();
    return rows.map((row) => CartItem(
      id: row.id,
      count: row.count,
    )).toList();
  }

  @override
  Future<void> addOrUpdateItemToCart(CartItem item) async {
    await _appDatabase.into(_appDatabase.cartItems).insertOnConflictUpdate(
      db.CartItemsCompanion(
        id: Value(item.id),
        count: Value(item.count),
      ),
    );
  }

  @override
  Future<void> clearCart() async {
    await _appDatabase.delete(_appDatabase.cartItems).go();
  }
}
