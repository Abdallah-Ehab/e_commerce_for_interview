part of 'product_cubit.dart';

@immutable
sealed class ProductState {}

final class ProductInitial extends ProductState {}

final class ProductLoading extends ProductState {}

final class ProductLoaded extends ProductState {
  final List<Product> products;
  final int pageNumber;
  final bool hasMore;

  ProductLoaded({required this.products,this.pageNumber = 1, this.hasMore = false});
  
  ProductLoaded copyWith({
    List<Product>? products,
    int? pageNumber,
    bool? hasMore,
  }) {
    return ProductLoaded(
      products: products ?? this.products,
      pageNumber: pageNumber ?? this.pageNumber,
      hasMore: hasMore ?? this.hasMore,
    );
  }
}
final class ProductError extends ProductState {
  final String error;

  ProductError({required this.error});
}
