import '../../domain/entity/cart_item.dart';

abstract interface class ICartRepository {
  Future<List<CartItem>> getCart();
  Future<void> addOrUpdateItemToCart(CartItem item);
  Future<void> clearCart();
}
