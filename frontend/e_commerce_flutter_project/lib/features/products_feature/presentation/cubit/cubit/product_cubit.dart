import 'package:bloc/bloc.dart';
import 'package:e_commerce_flutter_project/core/utils/result.dart';
import 'package:e_commerce_flutter_project/features/products_feature/data/models/product_model.dart';
import 'package:e_commerce_flutter_project/features/products_feature/domain/usecases/get_all_products_use_case.dart';
import 'package:meta/meta.dart';

part 'product_state.dart';

class ProductCubit extends Cubit<ProductState> {
  final GetAllProductsUseCase getAllProductsUseCase;
  ProductCubit({required this.getAllProductsUseCase}) : super(ProductInitial());

  void fetchProducts({bool isLoadMore = false}) async {

    if (!isLoadMore) {
      emit(ProductLoading());
    }

    try {

      final int pageToFetch = isLoadMore && state is ProductLoaded
          ? (state as ProductLoaded).pageNumber + 1
          : 1;


      final Result<List<Product>> result = await getAllProductsUseCase.call(
        GetProductParams(
          pageNumber: pageToFetch,
          limit: 10,
        ),
      );

      if (result.error != null) {
        emit(ProductError(error: result.error!.message));
      } else {
        final newProducts = result.successData!;
        final hasMore = newProducts.length == 10; 

        if (isLoadMore && state is ProductLoaded) {
        
          final currentState = state as ProductLoaded;
          emit(currentState.copyWith(
            products: [...currentState.products, ...newProducts],
            pageNumber: pageToFetch,
            hasMore: hasMore,
          ));
        } else {

          emit(ProductLoaded(
            products: newProducts,
            pageNumber: 1,
            hasMore: hasMore,
          ));
        }
      }
    } catch (e) {
      emit(ProductError(error: e.toString()));
    }
  }
}