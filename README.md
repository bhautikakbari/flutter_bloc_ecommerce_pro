# Flutter BLoC E-commerce Pro 🛍️

<div align="center">

[![Flutter](https://img.shields.io/badge/Flutter-3.0+-02569B?logo=flutter)](https://flutter.dev/)
[![Bloc](https://img.shields.io/badge/Bloc-8.1.3-blue?logo=blockit)](https://bloclibrary.dev/)
[![Stars](https://img.shields.io/github/stars/yourusername/flutter_bloc_ecommerce_pro?style=social)](https://github.com/yourusername/flutter_bloc_ecommerce_pro/stargazers)
[![Forks](https://img.shields.io/github/forks/yourusername/flutter_bloc_ecommerce_pro?style=social)](https://github.com/yourusername/flutter_bloc_ecommerce_pro/network/members)

A professional-grade Flutter e-commerce application demonstrating BLoC pattern implementation in large-scale projects. This project serves as a comprehensive example of implementing clean architecture, SOLID principles, and best practices in Flutter.

[Getting Started](#getting-started) •
[Features](#features) •
[Architecture](#architecture) •
[Screenshots](#screenshots) •
[Contributing](#contributing)

</div>

## 🎯 Project Goals

This project aims to demonstrate:
- Proper implementation of BLoC pattern without Cubit
- Clean Architecture principles in a real-world application
- SOLID principles in Flutter
- Scalable state management for e-commerce features
- Reusable widget patterns
- Responsive design implementation

## ✨ Features

### Implemented
- [x] Product listing with grid view
- [x] Product details with Hero animation
- [x] Shopping cart management
- [x] Quantity controls
- [x] Image caching
- [x] Responsive design
- [x] Common widgets
- [x] Search functionality

### Upcoming
- [ ] User authentication
- [ ] Checkout process
- [ ] Order history
- [ ] Wishlist
- [ ] Product categories
- [ ] Product reviews

## 🏗️ Architecture

### Project Structure

<div align="left">
  <table>
    <tr>
      <th>Project Structure</th>
    </tr>
    <tr>
      <td>
        <pre>
lib/
├── core/
│   ├── constants/
│   │   ├── app_colors.dart
│   │   └── app_typography.dart
│   └── widgets/
│       ├── app_text.dart
│       ├── app_button.dart
│       ├── app_input.dart
│       ├── app_card.dart
│       └── quantity_selector.dart
├── models/
│   ├── product.dart
│   └── cart_item.dart
├── repositories/
│   └── product_repository.dart
├── blocs/
│   ├── product/
│   │   ├── product_bloc.dart
│   │   ├── product_event.dart
│   │   └── product_state.dart
│   └── cart/
│       ├── cart_bloc.dart
│       ├── cart_event.dart
│       └── cart_state.dart
├── views/
│   ├── product_list_view.dart
│   ├── product_detail_view.dart
│   └── cart_view.dart
│── widgets/
│   ├── product_card.dart
│   └── cart_item_card.dart
└── main.dart</pre>
      </td>
    </tr>
  </table>
</div>


### Design Patterns

#### 1. BLoC Pattern
- Separation of UI and business logic
- Event-driven state management
- Unidirectional data flow

// Example of BLoC implementation
class CartBloc extends Bloc<CartEvent, CartState> {
  CartBloc() : super(CartState()) {
    on<AddToCart>(_onAddToCart);
    on<RemoveFromCart>(_onRemoveFromCart);
    on<UpdateCartItemQuantity>(_onUpdateCartItemQuantity);
  }
  // ... event handlers
}


#### 2. Repository Pattern

abstract class IProductRepository {
  Future<List<Product>> getProducts();
  Future<List<Product>> getProductsByCategory(String category);
  Future<Product?> getProductById(int id);
}
