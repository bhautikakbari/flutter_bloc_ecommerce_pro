import '../../models/cart_item.dart';

class CartState {
  final Map<int, CartItem> items;

  CartState({
    this.items = const {},
  });

  double get totalAmount {
    return items.values.fold(0, (sum, item) => sum + (item.product.price * item.quantity));
  }

  int getQuantity(int productId) {
    return items[productId]?.quantity ?? 0;
  }

  CartState copyWith({
    Map<int, CartItem>? items,
  }) {
    return CartState(
      items: items ?? this.items,
    );
  }
}

