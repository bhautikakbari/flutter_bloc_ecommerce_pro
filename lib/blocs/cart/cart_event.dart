import '../../models/product.dart';

abstract class CartEvent {}

class AddToCart extends CartEvent {
  final Product product;
  AddToCart(this.product);
}

class RemoveFromCart extends CartEvent {
  final Product product;
  RemoveFromCart(this.product);
}

class UpdateCartItemQuantity extends CartEvent {
  final Product product;
  final int quantity;
  UpdateCartItemQuantity(this.product, this.quantity);
}

