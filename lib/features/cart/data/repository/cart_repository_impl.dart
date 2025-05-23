import 'package:coffee_shop/features/cart/data/datasource/cart_datasource.dart';

import '../../domain/entity/cart_item.dart';
import '../../domain/repository/cart_repository.dart';

class CartRepository implements ICartRepository {
  final ICartDataSource _cartDataSource;

  CartRepository({required ICartDataSource cartDataSource}) : _cartDataSource = cartDataSource;

  @override
  Future<void> addOrUpdateItemToCart(CartItem item) async {
    return _cartDataSource.addOrUpdateItemToCart(item);
  }

  @override
  Future<void> clearCart() {
    return _cartDataSource.clearCart();
  }

  @override
  Future<List<CartItem>> getCart() {
    return _cartDataSource.getCart();
  }
}
