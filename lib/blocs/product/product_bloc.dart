import 'package:flutter_bloc/flutter_bloc.dart';
import '../../repositories/product_repository.dart';
import 'product_event.dart';
import 'product_state.dart';

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  final IProductRepository repository;

  ProductBloc({required this.repository}) : super(ProductInitial()) {
    on<LoadProducts>(_onLoadProducts);
    on<LoadProductsByCategory>(_onLoadProductsByCategory);
    on<SearchProducts>(_onSearchProducts);
  }

  Future<void> _onLoadProducts(
      LoadProducts event,
      Emitter<ProductState> emit,
      ) async {
    try {
      emit(ProductLoading());
      final products = await repository.getProducts();
      emit(ProductLoaded(products));
    } catch (e) {
      emit(ProductError(e.toString()));
    }
  }

  Future<void> _onLoadProductsByCategory(
      LoadProductsByCategory event,
      Emitter<ProductState> emit,
      ) async {
    try {
      emit(ProductLoading());
      final products = await repository.getProductsByCategory(event.category);
      emit(ProductLoaded(products));
    } catch (e) {
      emit(ProductError(e.toString()));
    }
  }

  Future<void> _onSearchProducts(
      SearchProducts event,
      Emitter<ProductState> emit,
      ) async {
    try {
      emit(ProductLoading());
      final products = await repository.getProducts();
      final filteredProducts = products
          .where((product) =>
          product.name.toLowerCase().contains(event.query.toLowerCase()))
          .toList();
      emit(ProductLoaded(filteredProducts));
    } catch (e) {
      emit(ProductError(e.toString()));
    }
  }
}

