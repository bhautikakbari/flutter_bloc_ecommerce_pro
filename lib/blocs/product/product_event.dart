abstract class ProductEvent {}

class LoadProducts extends ProductEvent {}

class LoadProductsByCategory extends ProductEvent {
  final String category;

  LoadProductsByCategory(this.category);
}

class SearchProducts extends ProductEvent {
  final String query;

  SearchProducts(this.query);
}

