import 'package:e_commerce_flutter_project/core/di.dart';
import 'package:e_commerce_flutter_project/features/products_feature/domain/usecases/get_all_products_use_case.dart';
import 'package:e_commerce_flutter_project/features/products_feature/presentation/cubit/cubit/product_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final ScrollController _scrollController = ScrollController();
    _scrollController.addListener(() {
      
        if (_scrollController.position.pixels ==
            _scrollController.position.maxScrollExtent) {
          context.read<ProductCubit>().fetchProducts(isLoadMore: true);
        }
      
    },);
    return BlocProvider(
      create:
          (context) => ProductCubit(
            getAllProductsUseCase: getIt<GetAllProductsUseCase>(),
          )..fetchProducts(),
      child: Scaffold(
        appBar: AppBar(title: const Text('Home Page')),
        body: BlocBuilder<ProductCubit, ProductState>(
          builder: (context, state) {
            if (state is ProductLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is ProductError) {
              return Center(child: Text(state.error));
            } else if (state is ProductLoaded) {
              return ListView.builder(
                controller: _scrollController,
                itemCount: state.products.length,
                itemBuilder: (context, index) {
                  if(index == state.products.length && state.hasMore) {
                     context.read<ProductCubit>().fetchProducts(isLoadMore: true);
                    return const Center(child: CircularProgressIndicator());
                  }
                  final product = state.products[index];
                  return ListTile(
                    title: Text(product.title),
                    subtitle: Text('\$ ${product.price}'),
                  );
                },
              );
            } else {
              return const Center(child: Text('No products available'));
            }
          },
        ),
      ),
    );
  }
}
