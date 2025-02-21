import 'package:flutter_bloc/flutter_bloc.dart';
import '../../models/cart_item.dart';
import '../../models/product.dart';
import 'cart_event.dart';
import 'cart_state.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  CartBloc() : super(CartState()) {
    on<AddToCart>(_onAddToCart);
    on<RemoveFromCart>(_onRemoveFromCart);
    on<UpdateCartItemQuantity>(_onUpdateCartItemQuantity);
  }

  void _onAddToCart(AddToCart event, Emitter<CartState> emit) {
    final currentState = state;
    final updatedItems = Map<int, CartItem>.from(currentState.items);

    if (updatedItems.containsKey(event.product.id)) {
      updatedItems[event.product.id] = CartItem(
        product: event.product,
        quantity: updatedItems[event.product.id]!.quantity + 1,
      );
    } else {
      updatedItems[event.product.id] = CartItem(
        product: event.product,
        quantity: 1,
      );
    }

    emit(currentState.copyWith(items: updatedItems));
  }

  void _onRemoveFromCart(RemoveFromCart event, Emitter<CartState> emit) {
    final currentState = state;
    final updatedItems = Map<int, CartItem>.from(currentState.items);

    if (updatedItems.containsKey(event.product.id)) {
      if (updatedItems[event.product.id]!.quantity > 1) {
        updatedItems[event.product.id] = CartItem(
          product: event.product,
          quantity: updatedItems[event.product.id]!.quantity - 1,
        );
      } else {
        updatedItems.remove(event.product.id);
      }
    }

    emit(currentState.copyWith(items: updatedItems));
  }

  void _onUpdateCartItemQuantity(
      UpdateCartItemQuantity event,
      Emitter<CartState> emit,
      ) {
    final currentState = state;
    final updatedItems = Map<int, CartItem>.from(currentState.items);

    if (event.quantity > 0) {
      updatedItems[event.product.id] = CartItem(
        product: event.product,
        quantity: event.quantity,
      );
    } else {
      updatedItems.remove(event.product.id);
    }

    emit(currentState.copyWith(items: updatedItems));
  }
}

