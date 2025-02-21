import 'dart:convert';

import '../models/product.dart';

abstract class IProductRepository {
  Future<List<Product>> getProducts();
  Future<List<Product>> getProductsByCategory(String category);
  Future<Product?> getProductById(int id);
}

class ProductRepository implements IProductRepository {
  final String _jsonData = '''
    {
      "products": [
        {
          "id": 1,
          "name": "Smartphone X",
          "description": "Latest smartphone with amazing features",
          "price": 999.99,
          "imageUrl": "https://img.freepik.com/free-photo/mobile-phone-screen-mockup-digital-device_53876-96026.jpg?t=st=1740161111~exp=1740164711~hmac=cc3882b79edcd7ad419bb77050ce4bfde60de36a74091418742907d76c9832ae&w=1060",
          "category": "Electronics"
        },
        {
          "id": 2,
          "name": "Running Shoes",
          "description": "Comfortable running shoes for athletes",
          "price": 129.99,
          "imageUrl": "https://img.freepik.com/free-psd/running-shoes-sneakers-transparent-background_84443-1604.jpg?t=st=1740161149~exp=1740164749~hmac=00604ee4ac8ee968d1ae1e4603972dc43d3cea27a3a21622b07b7ba6d530ff63&w=740",
          "category": "Sports"
        },
        {
          "id": 3,
          "name": "Coffee Maker",
          "description": "Premium coffee maker for your home",
          "price": 299.99,
          "imageUrl": "https://img.freepik.com/free-psd/coffee-maker-isolated-transparent-background_191095-25563.jpg?t=st=1740161178~exp=1740164778~hmac=8c8e3087138295d69ee1bdf01fbe4bfd63fa873d0e84c4df7ca7741ba0d9f3b1&w=740",
          "category": "Home"
        }
      ]
    }
  ''';

  @override
  Future<List<Product>> getProducts() async {
    // Simulate network delay
    await Future.delayed(const Duration(milliseconds: 500));

    final Map<String, dynamic> data = json.decode(_jsonData);
    return (data['products'] as List)
        .map((json) => Product.fromJson(json))
        .toList();
  }

  @override
  Future<List<Product>> getProductsByCategory(String category) async {
    final products = await getProducts();
    return products.where((product) => product.category == category).toList();
  }

  @override
  Future<Product?> getProductById(int id) async {
    final products = await getProducts();
    return products.firstWhere((product) => product.id == id);
  }
}

